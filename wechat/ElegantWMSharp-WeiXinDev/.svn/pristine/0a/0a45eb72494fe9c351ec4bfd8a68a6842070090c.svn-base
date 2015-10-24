using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Xml;

namespace ElegantWM.Tools
{
    /// <summary>
    /// XmlHelper 的摘要说明
    /// </summary>
    public class XmlHelper 
    {
        /// <summary>
        /// 读取数据
        /// </summary>
        /// <param name="path">路径</param>
        /// <param name="node">节点</param>
        /// <param name="attribute">属性名，非空时返回该属性值，否则返回串联值</param>
        /// <returns>string</returns>
        /**************************************************
         * 使用示列:
         * XmlHelper.Read(path, "/Node", "")
         * XmlHelper.Read(path, "/Node/Element[@Attribute='Name']", "Attribute")
         ************************************************/
        public static string Read(string path, string node, string attribute)
        {
            string value = "";
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(path);
                XmlNode xn = doc.SelectSingleNode(node);
                value = (attribute.Equals("") ? xn.InnerText : xn.Attributes[attribute].Value);
            }
            catch { }
            return value;
        }

        /// <summary>
        /// 读取XML String
        /// </summary>
        /// <param name="xmlstr"></param>
        /// <param name="node"></param>
        /// <param name="attribute"></param>
        /// <returns></returns>
        public static string ReadXmlStr(string xmlstr, string node, string attribute)
        {
            string value = "";
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.LoadXml(xmlstr);
                XmlNode xn = doc.SelectSingleNode(node);
                value = (attribute.Equals("") ? xn.InnerText : xn.Attributes[attribute].Value);
            }
            catch { return value; }
            return value;
        }
        /// <summary>
        /// 插入数据
        /// </summary>
        /// <param name="path">路径</param>
        /// <param name="node">节点</param>
        /// <param name="element">元素名，非空时插入新元素，否则在该元素中插入属性</param>
        /// <param name="attribute">属性名，非空时插入该元素属性值，否则插入元素值</param>
        /// <param name="value">值</param>
        /// <returns></returns>
        /**************************************************
         * 使用示列:
         * XmlHelper.Insert(path, "/Node", "Element", "", "Value")
         * XmlHelper.Insert(path, "/Node", "Element", "Attribute", "Value")
         * XmlHelper.Insert(path, "/Node", "", "Attribute", "Value")
         ************************************************/
        public static void Insert(string path, string node, string element, string attribute, string value)
        {
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(path);
                XmlNode xn = doc.SelectSingleNode(node);
                if (element.Equals(""))
                {
                    if (!attribute.Equals(""))
                    {
                        XmlElement xe = (XmlElement)xn;
                        xe.SetAttribute(attribute, value);
                    }
                }
                else
                {
                    XmlElement xe = doc.CreateElement(element);
                    if (attribute.Equals(""))
                        xe.InnerText = value;
                    else
                        xe.SetAttribute(attribute, value);
                    xn.AppendChild(xe);
                }
                doc.Save(path);
            }
            catch { }
        }

        /// <summary>
        /// 修改数据
        /// </summary>
        /// <param name="path">路径</param>
        /// <param name="node">节点</param>
        /// <param name="attribute">属性名，非空时修改该节点属性值，否则修改节点值</param>
        /// <param name="value">值</param>
        /// <returns></returns>
        /**************************************************
         * 使用示列:
         * XmlHelper.Insert(path, "/Node", "", "Value")
         * XmlHelper.Insert(path, "/Node", "Attribute", "Value")
         ************************************************/
        public static void Update(string path, string node, string attribute, string value)
        {
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(path);
                XmlNode xn = doc.SelectSingleNode(node);
                XmlElement xe = (XmlElement)xn;
                if (attribute.Equals(""))
                    xe.InnerText = value;
                else
                    xe.SetAttribute(attribute, value);
                doc.Save(path);
            }
            catch { }
        }

        /// <summary>
        /// 删除数据
        /// </summary>
        /// <param name="path">路径</param>
        /// <param name="node">节点</param>
        /// <param name="attribute">属性名，非空时删除该节点属性值，否则删除节点值</param>
        /// <param name="value">值</param>
        /// <returns></returns>
        /**************************************************
         * 使用示列:
         * XmlHelper.Delete(path, "/Node", "")
         * XmlHelper.Delete(path, "/Node", "Attribute")
         ************************************************/
        public static void Delete(string path, string node, string attribute)
        {
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(path);
                XmlNode xn = doc.SelectSingleNode(node);
                XmlElement xe = (XmlElement)xn;
                if (attribute.Equals(""))
                    xn.ParentNode.RemoveChild(xn);
                else
                    xe.RemoveAttribute(attribute);
                doc.Save(path);
            }
            catch { }
        }

        //==================================================
        //XmlFile.xml：
        //<?xml version="1.0" encoding="utf-8"?>
        //<Root />

        //==================================================
        //使用方法：
        //string xml = Server.MapPath("XmlFile.xml");
        //插入元素
        //XmlHelper.Insert(xml, "/Root", "Studio", "", "");
        //插入元素/属性
        //XmlHelper.Insert(xml, "/Root/Studio", "Site", "Name", "小路工作室");
        //XmlHelper.Insert(xml, "/Root/Studio", "Site", "Name", "丁香鱼工作室");
        //XmlHelper.Insert(xml, "/Root/Studio", "Site", "Name", "谱天城工作室");
        //XmlHelper.Insert(xml, "/Root/Studio/Site[@Name='谱天城工作室']", "Master", "", "红尘静思");
        //插入属性
        //XmlHelper.Insert(xml, "/Root/Studio/Site[@Name='小路工作室']", "", "Url", "http://www.wzlu.com/");
        //XmlHelper.Insert(xml, "/Root/Studio/Site[@Name='丁香鱼工作室']", "", "Url", "http://www.luckfish.net/");
        //XmlHelper.Insert(xml, "/Root/Studio/Site[@Name='谱天城工作室']", "", "Url", "http://www.putiancheng.com/");
        //修改元素值
        //XmlHelper.Update(xml, "/Root/Studio/Site[@Name='谱天城工作室']/Master", "", "RedDust");
        //修改属性值
        //XmlHelper.Update(xml, "/Root/Studio/Site[@Name='谱天城工作室']", "Url", "http://www.putiancheng.net/");
        //XmlHelper.Update(xml, "/Root/Studio/Site[@Name='谱天城工作室']", "Name", "PuTianCheng Studio");
        //读取元素值
        //Response.Write("<div>" + XmlHelper.Read(xml, "/Root/Studio/Site/Master", "") + "</div>");
        //读取属性值
        //Response.Write("<div>" + XmlHelper.Read(xml, "/Root/Studio/Site", "Url") + "</div>");
        //读取特定属性值
        //Response.Write("<div>" + XmlHelper.Read(xml, "/Root/Studio/Site[@Name='丁香鱼工作室']", "Url") + "</div>");
        //删除属性
        //XmlHelper.Delete(xml, "/Root/Studio/Site[@Name='小路工作室']", "Url");
        //删除元素
        //XmlHelper.Delete(xml, "/Root/Studio", "");


        #region WSRRXML辅助解析

        /// <summary>
        /// 对XML语句进行转义
        /// </summary>
        /// <param name="strXML">待反转义的XML</param>
        /// <returns></returns>
        private static string EscapeXML(string strXML)
        {
            strXML = strXML.Replace("《", "_x300A_");
            strXML = strXML.Replace("》", "_x300B_");
            strXML = strXML.Replace("(", "_x0028_");
            strXML = strXML.Replace(")", "_x0029_");
            return strXML;
        }

        /// <summary>
        /// 对XML语句进行反转义
        /// </summary>
        /// <param name="strXML">待反转义的XML</param>
        /// <returns></returns>
        private static string UescapeXML(string strXML)
        {
            strXML = strXML.Replace("_x300A_", "《");
            strXML = strXML.Replace("_x300B_", "》");
            strXML = strXML.Replace("_x0028_", "(");
            strXML = strXML.Replace("_x0029_", ")");
            return strXML;
        }

        public static DataSet GetDSByExcelXML(string strXML, bool pbContainOptypeTable, bool bpUnescape)
        {
            DataSet ds = new DataSet();
            //strXML = @"<ROOT><OPTYPE>DELETE</OPTYPE><LIST><ROW><Request_Code>SR20130609001</Request_Code><Requst_UserName>马卫清</Requst_UserName><Request_Type>Windows</Request_Type><Prod>正式</Prod></ROW><ROW><Request_Code>SR20130609002</Request_Code><Requst_UserName>王秀宝</Requst_UserName><Request_Type>DB</Request_Type><Prod>正式</Prod></ROW></LIST></ROOT>";

            DataTable dt_OPTYPE = new DataTable("OPTYPE");
            dt_OPTYPE.Columns.Add("OPTYPE");
            if (pbContainOptypeTable)
            {
                ds.Tables.Add(dt_OPTYPE);
            }
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(EscapeXML(strXML));

            XmlNode xml = xmlDoc.DocumentElement;

            int nListIndex = 0;

            foreach (XmlNode xmlRoot in xml.ChildNodes)
            {
                if (xmlRoot.Name.ToUpper() == "OPTYPE")
                {
                    dt_OPTYPE.Rows.Add(new object[] { UescapeXML(xmlRoot.InnerText) });
                    //nListIndex++;
                }
                else if (xmlRoot.Name.ToUpper() == "LIST")
                {
                    //bool bCreateTable = true;
                    DataTable dt_List = new DataTable();

                    if (xmlRoot.Attributes["TBName"] != null
                        && xmlRoot.Attributes["TBName"].Value != "")
                    {
                        dt_List.TableName = xmlRoot.Attributes["TBName"].Value;
                    }
                    else
                    {
                        if (nListIndex == 0)
                        {
                            dt_List.TableName = "LIST";
                        }
                        else
                        {
                            dt_List.TableName = "LIST" + (nListIndex).ToString(); ;
                        }
                        nListIndex++;
                    }

                    foreach (XmlNode xmlRow in xmlRoot.ChildNodes)
                    {
                        DataRow dr = dt_List.NewRow();
                        foreach (XmlNode xmlColumn in xmlRow.ChildNodes)
                        {
                            string strColumnName = UescapeXML(xmlColumn.Name);

                            if (!dt_List.Columns.Contains(strColumnName))
                            {
                                dt_List.Columns.Add(strColumnName);
                            }

                            if (bpUnescape)
                            {
                                dr[strColumnName] = UescapeXML(xmlColumn.InnerXml);
                            }
                            else
                            {
                                dr[strColumnName] = UescapeXML(xmlColumn.InnerXml);
                            }
                        }
                        dt_List.Rows.Add(dr);

                    }
                    ds.Tables.Add(dt_List);
                }
            }

            return ds;
        }
        #endregion
    }

}
