using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;

namespace ElegantWM.Tools
{
    public class ConvertExtSearch2Linq
    {
        public static Expression<Func<T, bool>> Convert<T>(string[] columns, string query)
        {
            Expression<Func<T, bool>> Conditions = PredicateExtensions.False<T>();
            ParameterExpression param = Expression.Parameter(typeof(T), "t");
            foreach (string col in columns)
            {
                //Expression left = Expression.Property(param, typeof(T).GetProperty(col));
                //Expression filter = Expression.Equal(left, right);
                PropertyInfo propertyInfo = typeof(T).GetProperty(col);
                if (propertyInfo == null) continue;
                //构造左右表达式
                Expression left = Expression.Property(param,propertyInfo);
                Expression right = Expression.Constant(query);
                Expression filter;
                if (propertyInfo.PropertyType.Name == "Guid")
                {
                    Guid Id;
                    if (!Guid.TryParse(query, out Id)) continue;
                    filter = Expression.Equal(left, Expression.Constant(Id));
                }
                else
                {
                    filter = Expression.Call(left,
                                                   typeof(string).GetMethod("Contains", new Type[] { typeof(string) }),
                                                   right);
                }
                if (filter == null) continue;
                Expression<Func<T, bool>> lambda = Expression.Lambda<Func<T, bool>>(filter, param);
                Conditions = Conditions.Or<T>(lambda);
            }
            return Conditions;
        }
    }
}
