using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/**
 * 作者：WebMisSharp
 * 时间：2014/7/28 15:38:04
 * 功能：WX_RespImgTxt ORM
 **/

namespace ElegantWM.EntityModel
{
    public class WX_RespImgTxt : Entity
    {
        public WX_RespImgTxt() { }

		/// <summary>
		/// 关键字
		/// </summary>
		public Guid KwId { get; set; }
		
		/// <summary>
		/// 标题
		/// </summary>
		public string Title { get; set; }
		
		/// <summary>
		/// 图片
		/// </summary>
		public string ImageUrl { get; set; }

        /// <summary>
        /// 链接地址
        /// </summary>
        public string AbsUrl { get; set; }


        /// <summary>
        /// 描述
        /// </summary>
        public string Description { get; set; }

		/// <summary>
		/// 内容
		/// </summary>
		public string Content { get; set; }
		
		/// <summary>
		/// 是否显示
		/// </summary>
		public int IsShow { get; set; }
		
		/// <summary>
		/// 是否主图
		/// </summary>
		public int IsMain { get; set; }

        /// <summary>
        /// 排序
        /// </summary>
        public int OrderIndex { get; set; }
        
        /// <summary>
        /// 访问量
        /// </summary>
        public int Hits { get; set; }

        /// <summary>
        /// 点赞量
        /// </summary>
        public int Praise { get; set; }

    }
}
