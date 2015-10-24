using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Text.RegularExpressions;

namespace Talent.Common
{
    public sealed class Constants
    {
        public const int PageSize = 20;  //分页大小
        public const string  FileName = "Excel" ;
        public const int OK = 1;
        public const int ERR = 0;
        public const int TIMEOUT = -1;
        

        public static string getGuid()
        {
            return Guid.NewGuid().ToString("N");
        }
        public static int GetPageItems(ref int pagesize, int index, int totalItems)
        {
            pagesize = (pagesize <= 0 ? Common.Constants.PageSize : pagesize);  //客户化pagesize大小
            index = (index <= 0 ? 1 : index); //index 小于0的时候 查第一页
            int pagetotal = index * pagesize;
            int itempager = pagesize;
            if (pagetotal > totalItems)
                itempager = totalItems - ((index - 1) * pagesize);
            if (itempager <= 0) return 0;
            return itempager;
        }

        public static string getReqValue(HttpRequest Request,string name)
        {
            string tmp = Request[name];
            if (tmp == null) return "";
            return tmp.ToString().Trim();
        }

        public static string getFormValue(HttpRequest Request, string name)
        {
            string tmp = Request.Form[name];
            if (tmp == null) return "";
            return tmp.ToString().Trim();
        }

        public static string GetFileExt(string FullPath)
        {
            if (FullPath != "") return FullPath.Substring(FullPath.LastIndexOf('.') + 1).ToLower();
            else return "";
        }

        public static bool isImgExt(string ext)
        {
            if (ext == "jpg" || ext == "gif" || ext == "png" || ext=="bmp")
            {
                return true;
            }
            return false;
        }

        //获取省市链表
        public static string getArr(string name)
        {
            StringBuilder sb = new StringBuilder();
            var placestr = Maticsoft.DBUtility.PubConstant.PlaceStr;
            if (placestr != null && placestr != "")
            {
                var arr = placestr.Split(',');
                foreach(var obj in arr)
                {
                    string seldisplay = "";
                    if (obj == "") continue;
                   // if(obj)
                    if (obj == name) seldisplay = " selected=selected ";
                    sb.Append("<option value='" + obj + "' " + seldisplay + ">");
                    sb.Append(obj);
                    sb.Append("</option>");
                }
            }
            return sb.ToString();
        }

        //获取省市链表
        public static string getArrDialog(string name)
        {
            StringBuilder sb = new StringBuilder();
            var placestr = Maticsoft.DBUtility.PubConstant.PlaceStr;
            name = getNullToString(name);
            if (placestr != null && placestr != "")
            {
                var arr = placestr.Split(',');
                foreach (var obj in arr)
                {
                    if (obj == "") continue;
                    if (name != "")
                    {
                        if (name.IndexOf("," + obj + ",") >= 0)
                        {
                            sb.Append("<option value='" + obj + "' >");
                            sb.Append(obj);
                            sb.Append("</option>");
                        }
                    }
                    else 
                    {
                        sb.Append("<option value='" + obj + "' >");
                        sb.Append(obj);
                        sb.Append("</option>");
                    } 
                }
            }
            return sb.ToString();
        }

        //获取省市checkbox
        public static string getCheckbox(string ProvinceList)
        {
            StringBuilder sb = new StringBuilder();
            var placestr = Maticsoft.DBUtility.PubConstant.PlaceStr;
            if (placestr != null && placestr != "")
            {
                var arr = placestr.Split(',');
                foreach (var obj in arr)
                {
                    string seldisplay = "";
                    if (obj == "") continue;
                    // if(obj)
                    if (ProvinceList.IndexOf("," + obj + ",") >= 0) seldisplay = " checked=checked ";
                    sb.Append("<label><input type='checkbox' name='PM_Province' value='" + obj + "' " + seldisplay + " />");
                    sb.Append(obj);
                    sb.Append("</label>");
                }
            }
            return sb.ToString();
        }

        public static string getQueryStr(string Province)
        {
            if (Province == null || Province == "") return "";
            var tmp = GetString(Province,",");
            if (tmp != "")
            {
                tmp = tmp.Replace(",", "','");
                tmp = " and  CB_Province in ('" + tmp + "') ";
            }
            return tmp;
        }

        public static string getNullToString(string str)
        {
            return (str == null ? "" : str);
        }

        ///<summary> 
        /// 截前后字符(串) 
        ///</summary> 
        ///<param name="val">原字符串</param> 
        ///<param name="str">要截掉的字符串</param>
        ///<param name="all">是否贪婪</param> 
        ///<returns></returns>        
        private static string GetString(string val,string str,bool all = false)        
        {            
            return Regex.Replace(val, @"(^(" + str + ")" + (all ? "*" : "") + "|(" + str + ")"+(all ? "*" : "") + "$)", "");        
        }
    }
}
