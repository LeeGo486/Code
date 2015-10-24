using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElegantWM.WeiXin.MsgEntity
{
    public class Article
    {
        public string Title{get;set;}
        public string Description{get;set;}
        public string PicUrl{get;set;}
        public string Url{get;set;}
    }

    public class WxNewsMsg : WxMsg
    {
        /// <summary>
        /// 文章数量
        /// </summary>
        public int ArticleCount { get; set; }

        public List<Article> Articles { get; set; }

    }
}
