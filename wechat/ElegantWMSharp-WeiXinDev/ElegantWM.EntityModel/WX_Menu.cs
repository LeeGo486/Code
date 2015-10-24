using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/15 22:29:50
 * 功能：WX_Menu ORM
 **/

namespace ElegantWM.EntityModel
{
    public class WX_Menu : Entity
    {
        public WX_Menu() { }

        /// <summary>
        /// 微信ID
        /// </summary>
        public Guid AccountId { get; set; }

        /// <summary>
        /// 菜单名
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// 类型
        /// </summary>
        public string Type { get; set; }

        /// <summary>
        /// 响应类型
        /// </summary>
        public string RespType { get; set; }

        /// <summary>
        /// 关键字
        /// </summary>
        public string KeyUrl { get; set; }

        /// <summary>
        /// 排序
        /// </summary>
        public int OrderIndex { get; set; }

        /// <summary>
        /// 父节点
        /// </summary>
        public Guid FatherId { get; set; }



    }
}
