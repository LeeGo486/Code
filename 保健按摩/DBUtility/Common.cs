using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Reflection;


/**

 * 说明：DataTable与Model转换类
 */
namespace DBUtility
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
            Type type = obj.GetType();
            PropertyInfo[] pis = type.GetProperties();
            for (int i = 0; i < pis.Length; i++)
            {
                //默认model层的实体类时间采用String格式
                if (dt.Rows[0][pis[i].Name.ToString()].GetType().Name.ToString().ToLower() == "datetime")
                    pis[i].SetValue(obj, dt.Rows[0][pis[i].Name.ToString()].ToString(), null);
                else if (dt.Rows[0][pis[i].Name.ToString()].ToString() == "")
                    continue;
                else if (dt.Rows[0][pis[i].Name.ToString()].GetType().Name.ToString() == "DBNull")
                    pis[i].SetValue(obj, "", null);
                else
                    pis[i].SetValue(obj, dt.Rows[0][pis[i].Name.ToString()], null);
            }
            return (T)obj;
        }

        /// <summary>
        /// 将DataTable转换成IList
        /// </summary>
        /// <param name="dt">要转换的DataTable</param>
        /// <returns>返回IList</returns>
        public static IList<T> Dt2List(DataTable dt)
        {
            IList<T> list = new List<T>();
            Type type = typeof(T);
            foreach (DataRow dr in dt.Rows)
            {
                T t = new T();
                PropertyInfo[] propertys = t.GetType().GetProperties();
                foreach (PropertyInfo pi in propertys)
                {
                    object value = dr[pi.Name];
                    if (value != DBNull.Value)
                    {
                        if(dr[pi.Name].GetType().Name.ToString().ToLower()=="datetime")
                            pi.SetValue(t, value.ToString(), null);
                        else
                            pi.SetValue(t, value, null);
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
