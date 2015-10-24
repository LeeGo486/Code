using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace EPManageWeb.Entities.Models
{
    public class OperationLog : BaseModel
    {
        [Key]
        public int Id { get; set; }

        public string OperationType { get; set; }

        public virtual User User { get; set; }

        public virtual Clothes Clothes { get; set; }

    }

    public enum OperationType
    {
        DownLoadFile,
        AddClothes,
        DelClothes,
        EditClothes,
        ViewClothes
    }
}