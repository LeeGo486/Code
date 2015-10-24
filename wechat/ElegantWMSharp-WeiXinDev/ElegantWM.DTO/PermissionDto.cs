using System;
using System.Collections;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

/**
 * 作者：陈杰
 * QQ  : 710782046
 * Email:ovenjackchain@gmail.com
 * Web :http://www.ChinaCloudTech.com
 */
namespace ElegantWM.DTO
{
    public class PermissionDto
    {
        public PermissionDto() { }
		
        #region 属性

        public string Id { get; set; }

        /// <summary>
        /// 模块名称
        /// </summary>
        public string ModuleName { get; set; }

        /// <summary>
        /// 模块地址
        /// </summary>
        public string ModuleUrl { get; set; }

        /// <summary>
        /// 快捷键
        /// </summary>
        public string ModuleKey { get; set; }
        
        /// <summary>
        /// Controller
        /// </summary>
        public string ModuleController { get; set; }

        /// <summary>
        /// Action
        /// </summary>
        public string ModuleAction { get; set; }

        /// <summary>
        /// 请求参数
        /// </summary>
        public string ModuleParam { get; set; }

        /// <summary>
        /// 排序
        /// </summary>
        public int ModuleIndex { get; set; }

        /// <summary>
        /// 描述
        /// </summary>
        public string ModuleDesc { get; set; }

        /// <summary>
        /// 类型
        /// </summary>
        public string ModuleType { get; set; }

        /// <summary>
        /// 是否展开
        /// </summary>
        public bool ModuleExpanded { get; set; }

        /// <summary>
        /// 父节点
        /// </summary>
        public string ModuleParent { get; set; }

        /// <summary>
        /// 系统ID
        /// </summary>
        public string SysId { get; set; }

        #endregion
    }
}
