using ElegantWM.AutoMapper;
using System;
using System.Collections;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
/**
 * 作者：陈杰
 * 时间：2012-08-10 00:25
 * 功能：公共字段接口实现类
 **/
namespace ElegantWM.EntityModel
{
    public class Entity : IEntity
    {
        [AutoMapping(Ignore = true)]
        [Key]
        public Guid Id { get; set; }
        [AutoMapping(Ignore = true)]
        public string CreateUser { get; set; }

        [AutoMapping(Ignore = true)]
        [Column(TypeName = "datetime")]
        public DateTime CreateTime { get; set; }

        [AutoMapping(Ignore = true)]
        public string ModifyUser { get; set; }

        [AutoMapping(Ignore = true)]
        [Column(TypeName = "datetime")]
        public DateTime? ModifyTime { get; set; }

        [AutoMapping(Ignore = true)]
        [Timestamp]
        public Byte[] RowVersion { get; set; }
    }
}
