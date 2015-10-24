using EPManageWeb.Entities.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace EPManageWeb.Models
{
    public class ClothesEditModel
    {
        [Display(Name = "样板编号")]
        public String SampleNO { get; set; }
        [Display(Name = "大货编号")]
        public String ProductNO { get; set; }

        [Display(Name = "款式图")]
        public String StylePics { get; set; }
        [Display(Name = "成衣图片")]
        public String ClothesPics { get; set; }
        [Display(Name = "版型图")]
        public String ModelVersionPics { get; set; }

        [Display(Name = "生产总数")]
        public int ProductedCount { get; set; }
        [Display(Name = "销售总数")]
        public int SaledCount { get; set; }

        [Display(Name = "工艺简述")]
        public String Comment { get; set; }
        [Display(Name = "工艺单文件")]
        public String TechnologyFile { get; set; }
        [Display(Name = "辅料卡文件")]
        public string AccessoriesFile { get; set; }

        [Display(Name = "样板文件")]
        public string SampleFile { get; set; }

        [Display(Name = "尺寸表")]
        public string ClothSize { get; set; }

        public string ClothesTags { get; set; }

        public int ClothesTypeId { get; set; }
    }
}