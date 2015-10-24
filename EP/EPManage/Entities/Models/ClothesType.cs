using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace EPManageWeb.Entities.Models
{
    public class ClothesType : BaseModel
    {
        [Key]
        [XmlIgnore]
        public int Id { get; set; }
        [MaxLength(20)]
        public String Name { get; set; }

        public virtual ClothesType Parent { get; set; }

        public virtual List<ClothesType> Children { get; set; }

        public virtual List<ClothesPart> ClothesParts { get; set; }

        public virtual List<Clothes> Clothes { get; set; }
    }
}