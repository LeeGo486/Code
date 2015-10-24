using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;
using System.Text.RegularExpressions;
using HZY.COM.Common.Excel;
using System.IO;

namespace HZY.COM.WEB
{

    public class UploadFile
    {

        #region 属性
        HttpContext context = null;

        private DataSet m_dsExcelData = new DataSet();
        public DataSet dsExcelData
        {
            get { return m_dsExcelData; }
        }
        #endregion

        #region 构造函数
        public UploadFile(HttpContext context)
        {
            this.context = context;
        }
        #endregion

        #region Upload 上传主函数
        /// <summary>
        /// 上传主函数
        /// </summary>
        public void Upload()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("result");
            dt.Columns.Add("message");

            if (context.Request.Files.Count == 0)
            {
                dt.Rows.Add(new object[] { "False", "文件过大或提交的信息有误!" });
            }
            else
            {

                string strFileName = Path.GetFileName(context.Request.Files[0].FileName);
                string strFileNameSelfDef = "";

                if (context.Request["fileName"] != null && context.Request["fileName"].ToString() != "")
                {
                    strFileNameSelfDef = context.Request["fileName"].ToString();
                }
                string strExtension = Path.GetExtension(context.Request.Files[0].FileName).ToLower();

                if (strFileNameSelfDef == "")
                {
                    strFileName = strFileName.Substring(0, strFileName.Length - strExtension.Length) + "-" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + strExtension;

                }
                else
                {
                    strFileName = strFileNameSelfDef + strExtension;
                }

                string strFilePath = context.Request["filepath"];
                if (string.IsNullOrEmpty(strFilePath))
                {
                    dt.Rows.Add(new object[] { "False", "filepath不能为空" });
                }
                else
                {

                    int fileSize = 1024 * 1024 * 20; //20M
                    HttpPostedFile postedFile = context.Request.Files[0];
                    if (postedFile.ContentLength > fileSize)
                    {
                        dt.Rows.Add(new object[] { "False", "最大只能上传20M文件" });
                    }
                    else
                    {

                        strFilePath = "/" + strFilePath + "/" + strFileName;
                        string strLocation = context.Server.MapPath("upload") + strFilePath;
                        context.Request.Files[0].SaveAs(strLocation);

                        if (GetFileType(strFileName) == FileType.Excel)
                        {
                            //读取EXCEL信息
                            NpoiHelper excel = new NpoiHelper();
                            m_dsExcelData = excel.ReadExcel(strLocation);

                        }
                        else if (GetFileType(strFileName) == FileType.Pic)
                        {
                            if (context.Request["filepath"] == "HZY_mat")
                            {
                                CreateThumbnail(strLocation, 200, 200);
                            }
                            dt.Rows.Add(new object[] { "True", "/upload" + strFilePath + "" });
                            dt.Rows.Add(new object[] { "文件大小", postedFile.ContentLength });
                        }
                        else
                        {
                            dt.Rows.Add(new object[] { "False", "文件类型不认识！" });

                        }

                    }
                }
            }

            if (context.Request["WSID"] == null)
            {
                string strJSON = HZY.COM.Common.JsonHelper.CreateJsonParameters(dt);
                context.Response.Write(strJSON);
            }
        }
        #endregion

        #region CreateThumbnail 压缩图片
        /// <summary>
        /// 压缩图片
        /// </summary>
        /// <param name="lcFilename">文件名</param>
        /// <param name="lnWidth">宽</param>
        /// <param name="lnHeight">高</param>
        /// <returns></returns>
        public string CreateThumbnail(string lcFilename, int lnWidth, int lnHeight)
        {
            string strFileNameNew = lcFilename.Substring(0, lcFilename.Length - 4) + "small" + lcFilename.Substring(lcFilename.Length - 4);

            System.Drawing.Bitmap bmpOut = null;
            try
            {
                System.Drawing.Bitmap loBMP = new System.Drawing.Bitmap(lcFilename);
                System.Drawing.Imaging.ImageFormat loFormat = loBMP.RawFormat;

                decimal lnRatio;
                int lnNewWidth = 0;
                int lnNewHeight = 0;

                //*** If the image is smaller than a thumbnail just return it
                if (loBMP.Width < lnWidth && loBMP.Height < lnHeight)
                {
                    loBMP.Save(strFileNameNew);
                    return strFileNameNew;
                }
                if (loBMP.Width > loBMP.Height)
                {
                    lnRatio = (decimal)lnWidth / loBMP.Width;
                    lnNewWidth = lnWidth;
                    decimal lnTemp = loBMP.Height * lnRatio;
                    lnNewHeight = (int)lnTemp;
                }
                else
                {
                    lnRatio = (decimal)lnHeight / loBMP.Height;
                    lnNewHeight = lnHeight;
                    decimal lnTemp = loBMP.Width * lnRatio;
                    lnNewWidth = (int)lnTemp;
                }
                bmpOut = new System.Drawing.Bitmap(lnNewWidth, lnNewHeight);
                System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bmpOut);
                g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                g.FillRectangle(System.Drawing.Brushes.White, 0, 0, lnNewWidth, lnNewHeight);
                g.DrawImage(loBMP, 0, 0, lnNewWidth, lnNewHeight);

                loBMP.Dispose();
            }
            catch (Exception ex)
            {
                throw ex;
            }

            bmpOut.Save(strFileNameNew);
            return strFileNameNew;
        }
        #endregion

        #region GetFileType  获取文件类型
        /// <summary>
        /// 获取文件类型
        /// </summary>
        /// <param name="pstrFileName"></param>
        /// <returns></returns>
        public FileType GetFileType(string pstrFileName)
        {
            string strExt = "";
            if (pstrFileName.LastIndexOf(".") > -1)
            {
                strExt = pstrFileName.Substring(pstrFileName.LastIndexOf("."));
                if (strExt.Length > 1)
                {
                    strExt = strExt.Substring(1).ToUpper();
                }
            }
            FileType ft = FileType.Error;
            switch (strExt)
            {
                case "XLS":
                case "XLSX":
                    ft = FileType.Excel;
                    break;
                case "JPG":
                case "JPEP":
                case "PNG":
                case "GIF":
                case "BMP":
                    ft = FileType.Pic;
                    break;
            }
            return ft;
        }
        #endregion
    }

    #region 枚举(上传的文件类型)
    /// <summary>
    /// 枚举(上传的文件类型)
    /// </summary>
    public enum FileType
    {
        /// <summary>
        /// 图片
        /// </summary>
        Pic,

        Excel,

        /// <summary>
        /// 未知
        /// </summary>
        Error
    }
    #endregion
}
