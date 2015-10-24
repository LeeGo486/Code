using System;
/**
 * 作者：陈杰
 * 时间：2012-08-10 00:25
 * 功能：公共字段接口
 **/
namespace ElegantWM.EntityModel
{
    public interface IEntity
    {
        Guid Id { get; set; }

        string CreateUser { get; set; }
        DateTime CreateTime { get; set; }
        string ModifyUser { get; set; }
        DateTime? ModifyTime { get; set; }
        Byte[] RowVersion { get; set; }
    }
}