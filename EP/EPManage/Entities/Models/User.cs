using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace EPManageWeb.Entities.Models
{
    public class User : BaseModel
    {
        public int Id { get; set; }
        public String UserName { get; set; }
        public String Password { get; set; }
        public String RealName { get; set; }
        public String UserType { get; set; }
        public String Department { get; set; }

        public virtual DbSet<Clothes> CreatedClothes { get; set; }

        public DbSet<SessionUser> Sessions { get; set; }

        public virtual DbSet<OperationLog> Logs { get; set; }

    }

    public enum UserType
    {
        Admin,
        User
    }
}