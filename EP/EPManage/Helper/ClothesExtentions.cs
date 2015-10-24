using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPManageWeb.Entities.Models;

namespace EPManageWeb.Helper
{
    public static class ClothesExtentions
    {
        public static String FirstClothesPic(this Clothes clothes)
        {
            return ClothesPicFiles(clothes)[0];
        }

        public static List<String> ClothesPicFiles(this Clothes clothes)
        {
            return ExtractPics(clothes.ClothesPics);
        }

        public static String FirstModelVersionPic(this Clothes clothes)
        {
            return ModelVersionPicFiles(clothes)[0];
        }

        public static List<String> ModelVersionPicFiles(this Clothes clothes)
        {
            return ExtractPics(clothes.ModelVersionPics);
        }

        public static String FirstStylePic(this Clothes clothes)
        {
            return StylePicFiles(clothes)[0];
        }

        public static List<String> StylePicFiles(this Clothes clothes)
        {
            return ExtractPics(clothes.StylePics);
        }

        private static List<String> ExtractPics(string picUrls)
        {
            var pics = new List<String>();

            if (!String.IsNullOrEmpty(picUrls))
            {
                var t = picUrls.Split(new char[] { ',' });
                for (int i = 0; i < t.Length; i++)
                {
                    if (!String.IsNullOrEmpty(t[i]))
                        pics.Add(t[i]);
                }
            }
            else
            {
                pics.Add("~/Images/nopic.jpg");
            }
            return pics;
        }


        public static List<ClothesSize> ClothesSize(this Clothes clothes)
        {
            List<ClothesSize> sizes = new List<ClothesSize>();
            if (!String.IsNullOrEmpty(clothes.ClothesSize))
            {
                var pairs = clothes.ClothesSize.Split(new char[] { ',' });
                foreach (var t in pairs)
                {
                    sizes.Add(new ClothesSize() { Key = t.Substring(0, t.IndexOf('=')), Value = t.Substring(t.IndexOf('=') + 1) });
                }
            }
            return sizes;
        }

        public static int Count(this Clothes clothes, OperationType logType, DateTime startDT, DateTime endDT)
        {
            var type = logType.ToString();
            return clothes.Logs.Count(t => t.OperationType == type && t.CreateDT > startDT && t.CreateDT < endDT);
        }
    }

    public class ClothesSize
    {
        public String Key { get; set; }
        public String Value { get; set; }
    }
}