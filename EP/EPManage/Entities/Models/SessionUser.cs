using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace EPManageWeb.Entities.Models
{
    public class SessionUser : BaseModel
    {
        [Key]
        public Guid Id { get; set; }
        [MaxLength(50)]
        public String SessionId { get; set; }
        public int UserId { get; set; }
        public DateTime LastActivityDT { get; set; }
        public DateTime LoginDT { get; set; }
        [MaxLength(50)]
        public String RemoteIP { get; set; }
        [MaxLength(50)]
        public String Status { get; set; }

        public User User { get; set; }

    }
}