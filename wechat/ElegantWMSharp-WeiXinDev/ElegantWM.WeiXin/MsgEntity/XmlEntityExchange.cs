using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;
using System.Xml;

namespace ElegantWM.WeiXin.MsgEntity
{
    public class XmlEntityExchange<T> where T : new()
    {
        public static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        /// <summary>
        /// 将XML转换为对象
        /// </summary>
        /// <param name="xml"></param>
        /// <returns></returns>
        public static T ConvertXml2Entity(string xml)
        {
            try
            {
                XmlDocument doc = new XmlDocument();
                PropertyInfo[] propinfos = null;
                doc.LoadXml(xml);
                XmlNodeList nodelist = doc.SelectNodes("/xml");
                T entity = new T();
                foreach (XmlNode node in nodelist)
                {
                    //初始化propertyinfo
                    if (propinfos == null)
                    {
                        Type objtype = entity.GetType();
                        propinfos = objtype.GetProperties();
                    }
                    //填充entity类的属性
                    foreach (PropertyInfo pi in propinfos)
                    {
                        XmlNode cnode = node.SelectSingleNode(pi.Name);
                        if (cnode != null)
                            pi.SetValue(entity, Convert.ChangeType(cnode.InnerText, pi.PropertyType), null);
                    }
                }
                return entity;
            }
            catch (Exception error)
            {
                log.Error("扑捉到不能转换的XML=" + xml);
                throw error;
            }
        }

        /// <summary>
        /// 构造微信消息
        /// </summary>
        /// <param name="t">对象实体</param>
        /// <returns>返回微信消息xml格式</returns>
        public static string ConvertEntity2Xml(T t)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("<xml>");
            Type objtype = t.GetType();
            //填充entity类的属性
            foreach (PropertyInfo pi in objtype.GetProperties())
            {
                object obj = pi.GetValue(t);
                string value = obj == null ? "" : obj.ToString();
                if (pi.PropertyType.Name.ToLower() == "int64" || pi.PropertyType.Name.ToLower() == "int32")
                    builder.Append("<" + pi.Name + ">" + value + "</" + pi.Name + ">");
                else if (pi.Name == "Articles" && pi.PropertyType.Name == "List`1")
                {
                    value = ConvertNewMsg(obj);
                    builder.Append("<Articles>" + value + "</Articles>");
                }
                else
                    builder.Append("<" + pi.Name + "><![CDATA[" + value + "]]></" + pi.Name + ">");
            }
            builder.Append("</xml>");
            return builder.ToString();

        }

        public static string ConvertNewMsg(object t)
        {
            StringBuilder builder = new StringBuilder();
            List<Article> items = (List<Article>)t;
            foreach (Article atl in items)
            {
                Type objtype = atl.GetType();
                builder.Append("<item>");
                //填充entity类的属性
                foreach (PropertyInfo pi in objtype.GetProperties())
                {
                    object obj = pi.GetValue(atl);
                    string value = obj == null ? "" : obj.ToString();
                    builder.Append("<" + pi.Name + "><![CDATA[" + value + "]]></" + pi.Name + ">");
                }
                builder.Append("</item>");
            }
            return builder.ToString();
        }
    }
}