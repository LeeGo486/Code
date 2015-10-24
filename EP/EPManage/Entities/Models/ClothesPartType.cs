using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace EPManageWeb.Entities.Models
{
    public class ClothesPartType
    {
        [Key]
        [XmlIgnore]
        public int Id { get; set; }
        [MaxLength(100)]
        public String Name { get; set; }
        [XmlIgnore]
        public int Order { get; set; }
        [XmlIgnore]
        public virtual ClothesPart ClothesPart { get; set; }
        [XmlIgnore]
        public virtual ClothesPartType Parent { get; set; }
        [XmlIgnore]
        public virtual List<ClothesPartType> Children { get; set; }
    }
}