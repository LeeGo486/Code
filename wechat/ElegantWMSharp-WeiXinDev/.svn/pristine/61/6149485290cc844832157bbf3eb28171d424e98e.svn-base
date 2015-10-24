using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Data.Common;
using System.Collections;
using System.Reflection;
using System.Collections.Generic;
using System.Text;

namespace ElegantWM.Tools
{
    /// <summary>
    /// Json的摘要说明
    /// 1、生成[{},{},{}]形式。普通格式
    /// 2、生成{"total":5,"rows":[{},{}]}形式。easyui json格式
    /// 3、生成{"表名":[{},{}],"表名":[{},{}]}形式。
    /// </summary>
    public class Json
    {

        /// <summary>
        /// 对象转换为Json字符串
        /// </summary>
        /// <param name="jsonObject">对象</param>
        /// <returns>Json字符串</returns>
        public static string ToJson(object jsonObject)
        {
            string jsonString = "{";
            PropertyInfo[] propertyInfo = jsonObject.GetType().GetProperties();
            for (int i = 0; i < propertyInfo.Length; i++)
            {
                object objectValue = propertyInfo[i].GetGetMethod().Invoke(jsonObject, null);
                string value = string.Empty;
                if (objectValue is DateTime || objectValue is Guid || objectValue is TimeSpan)
                {
                    value = "'" + objectValue.ToString() + "'";
                }
                else if (objectValue is string)
                {
                    value = "'" + ToJson(objectValue.ToString()) + "'";
                }
                else if (objectValue is IEnumerable)
                {
                    value = ToJson((IEnumerable)objectValue);
                }
                else
                {
                    value = ToJson(objectValue.ToString());
                }
                jsonString += "\"" + ToJson(propertyInfo[i].Name) + "\":" + value + ",";
            }
            return Json.DeleteLast(jsonString) + "}";
        }


        /// <summary>
        /// 对象集合转换Json
        /// </summary>
        /// <param name="array">集合对象</param>
        /// <returns>Json字符串</returns>
        public static string ToJson(IEnumerable array)
        {
            string jsonString = "[";
            foreach (object item in array)
            {
                jsonString += Json.ToJson(item) + ",";
            }
            return Json.DeleteLast(jsonString) + "]";
        }


        /// <summary>
        /// 普通集合转换Json
        /// </summary>
        /// <param name="array">集合对象</param>
        /// <returns>Json字符串</returns>   
        public static string ToArrayString(IEnumerable array)
        {
            string jsonString = "[";
            foreach (object item in array)
            {
                jsonString = ToJson(item.ToString()) + ",";
            }
            return Json.DeleteLast(jsonString) + "]";
        }


        /// <summary>
        /// Datatable转换为Json
        /// </summary>
        /// <param name="table">Datatable对象</param>
        /// <returns>Json字符串</returns>
        public static string ToJson(DataTable table)
        {
            string jsonString = "[";
            DataRowCollection drc = table.Rows;
            for (int i = 0; i < drc.Count; i++)
            {
                jsonString += "{";
                foreach (DataColumn column in table.Columns)
                {
                    jsonString += "\"" + ToJson(column.ColumnName) + "\":";
                    if (column.DataType == typeof(DateTime) || column.DataType == typeof(string))
                    {
                        jsonString += "\"" + ToJson(drc[i][column.ColumnName].ToString()) + "\",";
                    }
                    else
                    {
                        jsonString += ToJson(drc[i][column.ColumnName].ToString()) + ",";
                    }
                }
                jsonString = DeleteLast(jsonString) + "},";
            }
            return DeleteLast(jsonString) + "]";
        }


        /// <summary>
        /// DataReader转换为Json
        /// </summary>
        /// <param name="dataReader">DataReader对象</param>
        /// <returns>Json字符串</returns>
        public static string ToJson(DbDataReader dataReader)
        {
            string jsonString = "[";
            while (dataReader.Read())
            {
                jsonString += "{";

                for (int i = 0; i < dataReader.FieldCount; i++)
                {
                    jsonString += "\"" + ToJson(dataReader.GetName(i)) + "\":";
                    if (dataReader.GetFieldType(i) == typeof(DateTime) || dataReader.GetFieldType(i) == typeof(string))
                    {
                        jsonString += "\"" + ToJson(dataReader[i].ToString()) + "\",";
                    }
                    else
                    {
                        jsonString += ToJson(dataReader[i].ToString()) + ",";
                    }
                }
                jsonString = DeleteLast(jsonString) + "}";
            }
            dataReader.Close();
            return DeleteLast(jsonString) + "]";
        }


        /// <summary>
        /// DataSet转换为Json
        /// </summary>
        /// <param name="dataSet">DataSet对象</param>
        /// <returns>Json字符串</returns>
        public static string ToJson(DataSet dataSet)
        {
            string jsonString = "{";
            foreach (DataTable table in dataSet.Tables)
            {
                jsonString += "\"" + ToJson(table.TableName) + "\":" + ToJson(table) + ",";
            }
            return jsonString = DeleteLast(jsonString) + "}";
        }


        /// <summary>
        /// 删除结尾字符","
        /// </summary>
        /// <param name="str">需要删除的字符</param>
        /// <returns>完成后的字符串</returns>
        private static string DeleteLast(string str)
        {
            if (str.Length > 1)
            {
                return str.Substring(0, str.Length - 1);
            }
            return str;
        }


        /// <summary>
        /// String转换为Json
        /// </summary>
        /// <param name="value">String对象</param>
        /// <returns>Json字符串</returns>
        public static string ToJson(string value)
        {
            if (string.IsNullOrEmpty(value))
            {
                return string.Empty;
            }

            string temstr;
            temstr = value;
            temstr = temstr.Replace("{", "｛").Replace("}", "｝").Replace(":", "：").Replace(",", "，").Replace("[", "【").Replace("]", "】").Replace(";", "；").Replace("\n", "<br/>").Replace("\r", "");
            temstr = temstr.Replace("\t", "   ");
            temstr = temstr.Replace("'", "\'");
            temstr = temstr.Replace(@"\", @"\\");
            temstr = temstr.Replace("\"", "\"\"");
            return temstr;
        }
    }



    /// <summary>
    /// JsonHelper类
    /// </summary>
    public class JsonHelper
    {

        /// <summary>
        /// List转成json
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="jsonName"></param>
        /// <param name="list"></param>
        /// <returns></returns>
        public static string ListToJson<T>(IList<T> list, string jsonName)
        {
            StringBuilder Json = new StringBuilder();
            if (string.IsNullOrEmpty(jsonName))
                jsonName = list[0].GetType().Name;
            Json.Append("{\"" + jsonName + "\":[");
            if (list.Count > 0)
            {
                for (int i = 0; i < list.Count; i++)
                {
                    T obj = Activator.CreateInstance<T>();
                    PropertyInfo[] pi = obj.GetType().GetProperties();
                    Json.Append("{");
                    for (int j = 0; j < pi.Length; j++)
                    {
                        Type type = pi[j].GetValue(list[i], null).GetType();
                        Json.Append("\"" + pi[j].Name.ToString() + "\":" + StringFormat(pi[j].GetValue(list[i], null).ToString(), type));

                        if (j < pi.Length - 1)
                        {
                            Json.Append(",");
                        }
                    }
                    Json.Append("}");
                    if (i < list.Count - 1)
                    {
                        Json.Append(",");
                    }
                }
            }
            Json.Append("]}");
            return Json.ToString();
        }

        /// <summary>
        /// List转成json
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="list"></param>
        /// <returns></returns>
        public static string ListToJson<T>(IList<T> list)
        {
            object obj = list[0];
            return ListToJson<T>(list, obj.GetType().Name);
        }

        /// <summary>
        /// 对象[dui xiang]转换[zhuan huan]为Json字符[zi fu]串[zi fu chuan]
        /// </summary>
        /// <param name="jsonObject">对象[dui xiang]</param>
        /// <returns>Json字符[zi fu]串[zi fu chuan]</returns>
        public static string ToJson(object jsonObject)
        {
            string jsonString = "{";
            PropertyInfo[] propertyInfo = jsonObject.GetType().GetProperties();
            for (int i = 0; i < propertyInfo.Length; i++)
            {
                object objectValue = propertyInfo[i].GetGetMethod().Invoke(jsonObject, null);
                string value = string.Empty;
                if (objectValue is DateTime || objectValue is Guid || objectValue is TimeSpan)
                {
                    value = "'" + objectValue.ToString() + "'";
                }
                else if (objectValue is string)
                {
                    value = "'" + ToJson(objectValue.ToString()) + "'";
                }
                else if (objectValue is IEnumerable)
                {
                    value = ToJson((IEnumerable)objectValue);
                }
                else
                {
                    value = ToJson(objectValue.ToString());
                }
                jsonString += "\"" + ToJson(propertyInfo[i].Name) + "\":" + value + ",";
            }
            jsonString.Remove(jsonString.Length - 1, jsonString.Length);
            return jsonString + "}";
        }

        /// <summary>
        /// 对象[dui xiang]集合转换[zhuan huan]Json
        /// </summary>
        /// <param name="array">集合对象[dui xiang]</param>
        /// <returns>Json字符[zi fu]串[zi fu chuan]</returns>
        public static string ToJson(IEnumerable array)
        {
            string jsonString = "[";
            foreach (object item in array)
            {
                jsonString += ToJson(item) + ",";
            }
            jsonString.Remove(jsonString.Length - 1, jsonString.Length);
            return jsonString + "]";
        }

        public static List<Dictionary<string, object>> Dt2Json(DataTable dt)
        {
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, object> result = new Dictionary<string, object>();
                foreach (DataColumn dc in dt.Columns)
                {
                    result.Add(dc.ColumnName, dr[dc].ToString());
                }
                list.Add(result);
            }
            return list;
        }
        /// <summary>
        /// Datatable转换[zhuan huan]为Json
        /// </summary>
        /// <param name="table">Datatable对象[dui xiang]</param>
        /// <returns>Json字符[zi fu]串[zi fu chuan]</returns>
        public static string ToJson(DataTable dt)
        {
            StringBuilder jsonString = new StringBuilder();
            jsonString.Append("[");
            DataRowCollection drc = dt.Rows;
            for (int i = 0; i < drc.Count; i++)
            {
                jsonString.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    string strKey = dt.Columns[j].ColumnName;
                    string strValue = drc[i][j].ToString();
                    Type type = dt.Columns[j].DataType;
                    jsonString.Append("\"" + strKey + "\":");
                    strValue = StringFormat(strValue, type);
                    if (j < dt.Columns.Count - 1)
                    {
                        jsonString.Append(strValue + ",");
                    }
                    else
                    {
                        jsonString.Append(strValue);
                    }
                }
                jsonString.Append("},");
            }
            jsonString.Remove(jsonString.Length - 1, 1);
            jsonString.Append("]");
            return jsonString.ToString();
        }

        /// <summary>
        /// DataTable转成Json
        /// </summary>
        /// <param name="jsonName"></param>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static string ToJson(DataTable dt, string jsonName)
        {
            StringBuilder Json = new StringBuilder();
            if (string.IsNullOrEmpty(jsonName))
                jsonName = dt.TableName;
            Json.Append("{\"" + jsonName + "\":[");
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Json.Append("{");
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        Type type = dt.Rows[i][j].GetType();
                        Json.Append("\"" + dt.Columns[j].ColumnName.ToString() + "\":" + StringFormat(dt.Rows[i][j].ToString(), type));
                        if (j < dt.Columns.Count - 1)
                        {
                            Json.Append(",");
                        }
                    }
                    Json.Append("}");
                    if (i < dt.Rows.Count - 1)
                    {
                        Json.Append(",");
                    }
                }
            }
            Json.Append("]}");
            return Json.ToString();
        }

        /// <summary>
        /// DataTable转成Json
        /// </summary>
        /// <param name="jsonName"></param>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static string ToJsonEasyUi(DataTable dt, string jsonName)
        {
            StringBuilder Json = new StringBuilder();
            if (string.IsNullOrEmpty(jsonName))
                jsonName = dt.TableName;
         //   Json.Append("{\"" + jsonName + "\":[");
            Json.Append("{\"total\":" +dt.Rows.Count  + ",\"rows\":[");
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Json.Append("{");
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        Type type = dt.Rows[i][j].GetType();
                        if (dt.Columns[j].ColumnName.ToString() != "content")
                        {
                            Json.Append("\"" + dt.Columns[j].ColumnName.ToString() + "\":" + StringFormat(dt.Rows[i][j].ToString(), type));
                       
                        if (j < dt.Columns.Count - 1)
                        {
                            Json.Append(",");
                        } }
                    }
                    Json.Append("}");
                    if (i < dt.Rows.Count - 1)
                    {
                        Json.Append(",");
                    }
                }
            }
            Json.Append("]}");
            return Json.ToString();
        }

        /// <summary>
        /// DataReader转换[zhuan huan]为Json
        /// </summary>
        /// <param name="dataReader">DataReader对象[dui xiang]</param>
        /// <returns>Json字符[zi fu]串[zi fu chuan]</returns>
        public static string ToJson(DbDataReader dataReader)
        {
            StringBuilder jsonString = new StringBuilder();
            jsonString.Append("[");
            while (dataReader.Read())
            {
                jsonString.Append("{");
                for (int i = 0; i < dataReader.FieldCount; i++)
                {
                    Type type = dataReader.GetFieldType(i);
                    string strKey = dataReader.GetName(i);
                    string strValue = dataReader[i].ToString();
                    jsonString.Append("\"" + strKey + "\":");
                    strValue = StringFormat(strValue, type);
                    if (i < dataReader.FieldCount - 1)
                    {
                        jsonString.Append(strValue + ",");
                    }
                    else
                    {
                        jsonString.Append(strValue);
                    }
                }
                jsonString.Append("},");
            }
            dataReader.Close();
            jsonString.Remove(jsonString.Length - 1, 1);
            jsonString.Append("]");
            return jsonString.ToString();
        }

        /// <summary>
        /// DataSet转换[zhuan huan]为Json
        /// </summary>
        /// <param name="dataSet">DataSet对象[dui xiang]</param>
        /// <returns>Json字符[zi fu]串[zi fu chuan]</returns>
        public static string ToJson(DataSet dataSet)
        {
            string jsonString = "{";
            foreach (DataTable table in dataSet.Tables)
            {
                jsonString += "\"" + table.TableName + "\":" + ToJson(table) + ",";
            }
            jsonString = jsonString.TrimEnd(',');
            return jsonString + "}";
        }

        /// <summary>
        /// 普通集合转换[zhuan huan]Json
        /// </summary>
        /// <param name="array">集合对象[dui xiang]</param>
        /// <returns>Json字符[zi fu]串[zi fu chuan]</returns>
        public static string ToArrayString(IEnumerable array)
        {
            string jsonString = "[";
            foreach (object item in array)
            {
                jsonString = ToJson(item.ToString()) + ",";
            }
            jsonString.Remove(jsonString.Length - 1, jsonString.Length);
            return jsonString + "]";
        }

        /// <summary>
        /// 过滤[guo lv]特殊字符[zi fu][te shu zi fu]
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        private static string String2Json(String s)
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < s.Length; i++)
            {
                char c = s.ToCharArray()[i];
                switch (c)
                {
                    case '\"':
                        sb.Append("\""); break;
                    case '\\':
                        sb.Append("\\\\"); break;
                    case '/':
                        sb.Append("\\/"); break;
                    case '\b':
                        sb.Append("\\b"); break;
                    case '\f':
                        sb.Append("\\f"); break;
                    case '\n':
                        sb.Append("\\n"); break;
                    case '\r':
                        sb.Append("\\r"); break;
                    case '\t':
                        sb.Append("\\t"); break;
                    default:
                        sb.Append(c); break;
                }
            }
            return sb.ToString();
        }

        /// <summary>
        /// 格式化[ge shi hua]字符[zi fu]型、日期型、布尔型
        /// </summary>
        /// <param name="str"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        private static string StringFormat(string str, Type type)
        {
            if (type == typeof(string))
            {
                str = String2Json(str);
                str = "\"" + str + "\"";
            }
            else if (type == typeof(DateTime))
            {
                str = "\"" + str + "\"";
            }
            else if (type == typeof(bool))
            {
                str = str.ToLower();
            }
            return str;
        }
    }

}

