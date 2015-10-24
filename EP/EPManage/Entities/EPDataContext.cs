using EPManageWeb.Entities.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Web;

namespace EPManageWeb.Entities
{
    public class EPDataContext : DbContext
    {
        public EPDataContext(){
            this.Configuration.LazyLoadingEnabled = true;
        }

        public DbSet<SessionUser> SessionUsers { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<ClothesType> ClothesTypes { get; set; }
        public DbSet<ClothesPart> ClothesParts { get; set; }
        public DbSet<Clothes> Clothes { get; set; }
        public DbSet<UploadFile> UploadFiles { get; set; }
        public DbSet<ClothesPartType> ClothesPartTypes { get; set; }
        public DbSet<OperationLog> OperationLogs { get; set; }
        public DbSet<Tag> Tags { get; set; }


    }
}