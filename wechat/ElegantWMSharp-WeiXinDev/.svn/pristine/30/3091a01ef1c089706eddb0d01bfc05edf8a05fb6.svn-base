using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using System.Linq;

namespace ElegantWM.AutoMapper
{
    public class AutoMapper<T1,T2> where T1:new() where T2:new()
    {
        /// <summary>
        /// DTO 转换为 Entity
        /// </summary>
        /// <typeparam name="T1">DTO</typeparam>
        /// <typeparam name="T2">Entity</typeparam>
        /// <param name="t1">Dto</param>
        /// <param name="t2">Entity</param>
        /// <returns></returns>
        public static T2 Convert(T1 t1, T2 t2)
        {
            var dtoProperList = t1.GetType().GetProperties().Where(p => p.PropertyType.IsPublic == true).ToList();
            var entityProperList = t2.GetType().GetProperties().Where(p => p.PropertyType.IsPublic == true).ToList();
            foreach (System.Reflection.PropertyInfo pi in dtoProperList)
            {
                string realName=pi.Name;
                //首先判断列是否ignore？,是否含有Column
                object[] cusAttrs = pi.GetCustomAttributes(typeof(AutoMappingAttribute), true);
                if (cusAttrs.Length > 0)
                {
                    AutoMappingAttribute attr = cusAttrs[0] as AutoMappingAttribute;
                    if (attr.Ignore)
                        continue;
                    if (!string.IsNullOrEmpty(attr.EntityColumn))
                        realName = attr.EntityColumn;
                }
                var entityPi = entityProperList.Single(p => p.Name == realName);
                if (entityPi == null)//TO 如果不相等，判断是否自定义Column
                    continue;
                object value = pi.GetValue(t1, null);
                //if (value == null)
                //    continue;
                entityPi.SetValue(t2, value, null);                
            }
            return t2;
        }
    }
}
