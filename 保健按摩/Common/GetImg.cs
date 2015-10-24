using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace EPReper.Common
{

    public class GetImg
    {
        //返回新闻中的所有图片，用|隔开
        public string MyGetImgUrl(string text)
        {
            Regex regObj = new Regex("<img.+?>", RegexOptions.Compiled | RegexOptions.IgnoreCase);
            string imgs = "";
            foreach (Match matchItem in regObj.Matches(text))
            {
                string pic = GetImgUrl(matchItem.Value).ToString().Replace("\"", "");
                if (pic.Length > 0)
                    imgs += pic + "|";
            }
            return imgs.TrimEnd('|');
        }
        public string GetImgUrl(string imgTagStr)
        {
            string str = "";
            Regex reg = new Regex(@"<img\b[^<>]*?\bsrc[\s\t\r\n]*=[\s\t\r\n]*[""']?[\s\t\r\n]*(?<imgUrl>[^\s\t\r\n""'<>]*)[^<>]*?/?[\s\t\r\n]*>", RegexOptions.IgnoreCase);
            MatchCollection mc = reg.Matches(imgTagStr);
            foreach (Match match in mc)
            {
                if (match.Groups["imgUrl"].Value.Substring(match.Groups["imgUrl"].Value.LastIndexOf(".") + 1).ToLower() == "jpg")
                    str = match.Groups["imgUrl"].Value;
            }
            return str;
        }
    }

}
