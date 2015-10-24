using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace EPManageWeb.Entities.Models
{
    public abstract class BaseModel
    {
        protected BaseModel()
        {
            IsDeleted = false;
            CreateDT = DateTime.Now;
            ModifiedDT = DateTime.Now;
        }

        [XmlIgnore]
        public DateTime CreateDT { get; set; }
        [XmlIgnore]
        public DateTime ModifiedDT { get; set; }
        [XmlIgnore]
        public bool IsDeleted { get; set; }
    }
}