using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace EPManageWeb.Entities.Models
{
    public class Clothes : BaseModel
    {
        [Key]
        public int Id { get; set; }
        [MaxLength(50)]
        [Display(Name = "样板编号")]
        public string SampleNO { get; set; }
        [MaxLength(50)]
        [Display(Name = "大货编号")]
        public string ProductNO { get; set; }
        [Display(Name = "生产总数")]
        public int ProductedCount { get; set; }
        [Display(Name = "销售总数")]
        public int SaledCount { get; set; }
        [Display(Name = "工艺简述")]
        public String Comment { get; set; }
        [MaxLength(100)]
        [Display(Name = "辅料卡文件")]
        public String AssessoriesFile { get; set; }
        [MaxLength(500)]
        [Display(Name = "成衣图片")]
        public String ClothesPics { get; set; }
        [MaxLength(500)]
        [Display(Name = "版型图")]
        public String ModelVersionPics { get; set; }
        [MaxLength(100)]
        [Display(Name = "样板文件")]
        public String SampleFile { get; set; }
        [MaxLength(500)]
        [Display(Name = "款式图")]
        public String StylePics { get; set; }
        [MaxLength(100)]
        [Display(Name = "工艺单文件")]
        public String TechnologyFile { get; set; }
        [MaxLength(1000)]
        [Display(Name = "尺寸表")]
        public String ClothesSize { get; set; }
        [MaxLength(1000)]
        public String Tags { get; set; }
        //[Display(Name = "拥有者的ID")]
        //public String Owner_Id { get; set; }

        public int ViewCount { get; set; }

        public String PingLei { get; set; }

        public virtual User Owner { get; set; }

        public virtual ClothesType ClothesType { get; set; }

        public virtual List<OperationLog> Logs { get; set; }
    }
}