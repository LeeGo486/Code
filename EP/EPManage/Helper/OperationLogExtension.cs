using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPManageWeb.Entities.Models;

namespace EPManageWeb.Helper
{
    public static class OperationLogExtension
    {
        public static String OperationTypeToString(this OperationLog log)
        {
            switch (log.OperationType)
            {
                case "DownLoadFile": return "下载";
                case "AddClothes": return "上传";
                case "ViewClothes": return "查看";
                case "DelClothes": return "删除";
                case "EditClothes": return "编辑";
                default: return "";
            }
        }
    }
}