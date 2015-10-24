using System;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using System.Data;

namespace ElegantWM.Tools
{
    /// <summary>
    ///ModelConvertHelper 的摘要说明
    ///把dt转换List<T>类型
    ///实体转换辅助类
    ///使用方法:
    ///  IList<PersonContact> pContacts = DataTableToList<PersonContact>.ConvertToModel(dt);
    ///        try
    ///        {
    ///            foreach (PersonContact single in pContacts)
    ///           {
    ///                PersonContactAdd(pPartnerId, pDomain, single);
    ///            }
    ///        }
    /// </summary>
    public class ModelConvertHelper<T> where T : new()
    {
        public static IList<T> ConvertToModel(DataTable dt)
        {
            // 定义集合
            IList<T> ts = new List<T>();

            // 获得此模型的类型
            Type type = typeof(T);

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
                            pi.SetValue(t, value, null);
                    }
                }

                ts.Add(t);
            }
            return ts;

        }
    }
}
