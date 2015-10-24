using EPManageWeb.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace EPManageWeb.Entities.Models
{
    public class UploadFile : BaseModel
    {
        [Key]
        public int Id { get; set; }
        [MaxLength(50)]
        public String Type { get; set; }
        [MaxLength(100)]
        public String Path { get; set; }

        public Clothes Clothes { get; set; }
    }
    
}