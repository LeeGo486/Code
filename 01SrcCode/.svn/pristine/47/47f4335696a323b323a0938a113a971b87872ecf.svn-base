#pragma checksum "E:\02日常工作\DRP00002.DRP小插件\DRP_Plugin\DRPlugin\App_Code\DBHelper\Common.cs" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "1D1772F54EA30A8157DFF1A5E32AE4CFA9A55B64"

#line 1 "E:\02日常工作\DRP00002.DRP小插件\DRP_Plugin\DRPlugin\App_Code\DBHelper\Common.cs"
using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Reflection;


/**
 * 作者：陈杰
 * QQ  : 710782046
 * Email:ovenjackchain@gmail.com
 * 说明：DataTable与Model转换类
 */
namespace DBHelper
{
    public class Common<T> where T : new()
    {
        /// <summary>
        /// 将DataTable转换成Model实体
        /// </summary>
        /// <param name="obj">Model名称</param>
        /// <param name="dt">DataTable</param>
        /// <returns></returns>
        public static T Dt2Model(T obj, DataTable dt)
        {
            if (dt.Rows.Count <= 0) return (T)obj;
            T t = new T();
            string tempName = "";
            PropertyInfo[] pis = t.GetType().GetProperties();
            foreach (PropertyInfo pi in pis)
            {
                tempName = pi.Name;
                if (dt.Columns.Contains(tempName))
                {
                    // 判断此属性是否有Setter
                    if (!pi.CanWrite) continue;
                    object value = dt.Rows[0][tempName];
                    if (value != DBNull.Value)
                    {
                        if (dt.Rows[0][pi.Name].GetType().Name.ToString().ToLower() == "datetime")
                            pi.SetValue(t, value.ToString(), null);
                        else
                            pi.SetValue(t, value, null);
                    }
                }
            }
            return t;
        }

        /// <summary>
        /// 将DataTable转换成IList
        /// </summary>
        /// <param name="dt">要转换的DataTable</param>
        /// <returns>返回IList</returns>
        public static IList<T> Dt2List(DataTable dt)
        {
            IList<T> list = new List<T>();
            string tempName = "";
            foreach (DataRow dr in dt.Rows)
            {
                T t = new T();
                // 获得此模型的公共属性
                PropertyInfo[] propertys = t.GetType().GetProperties();
                foreach (PropertyInfo pi in propertys)
                {
                    tempName = pi.Name;
                    // 检查DataTable是否包含此列
                    if (dt.Columns.Contains(tempName))
                    {
                        // 判断此属性是否有Setter
                        if (!pi.CanWrite) continue;
                        object value = dr[tempName];
                        if (value != DBNull.Value)
                        {
                            if (dr[pi.Name].GetType().Name.ToString().ToLower() == "datetime")
                                pi.SetValue(t, value.ToString(), null);
                            else
                                pi.SetValue(t, value, null);
                        }
                    }
                }
                list.Add(t);
            }
            return list;
        }

        /// <summary>
        /// 通过反射获得对象名称和自动增长ID
        /// </summary>
        /// <param name="obj">对象</param>
        /// <returns>返回string[0]类名，string[1]自增ID</returns>
        public static string[] GetModelInfo(T obj)
        {
            string[] str = new string[2];
            Type T = obj.GetType();
            MethodInfo method = T.GetMethod("ReturnAutoID",
                                        BindingFlags.NonPublic
                                        | BindingFlags.Instance,
                                        null, new Type[] { }, null);
            //通过反射执行ReturnAutoID方法，返回AutoID值
            string AutoID = method.Invoke(obj, null).ToString();
            str[0] = T.Name.ToString();
            str[1] = AutoID;
            //返回该Obj的名称以及ReturnAutoID的值
            return str;
        }
    }
}


#line default
#line hidden
