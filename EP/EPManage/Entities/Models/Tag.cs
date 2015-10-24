using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace EPManageWeb.Entities.Models
{
    public class Tag : BaseModel
    {
        [Key]
        public int Id { get; set; }
        
        [MaxLength(10)]
        public String Type { get; set; }
        
        [MaxLength(20)]
        public String Value { get; set; }

        public int Order { get; set; }
    }
}