using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElegantWM.AutoMapper
{
    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Class, Inherited = true)]
    public class AutoMappingAttribute : Attribute
    {
        /// <summary>
        /// 是否忽略转换
        /// </summary>
        public bool Ignore { get; set; }
        /// <summary>
        /// 对应的Entity列名
        /// </summary>
        public string EntityColumn { get; set; }
    }
}
