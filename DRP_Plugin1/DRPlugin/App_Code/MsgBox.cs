using System;
using System.Collections.Generic;
using Ext.Net;
using System.Web;
 
    public class MsgBox
    {
        /// <summary>
        /// 提示框
        /// </summary>
        /// <param name="infos">提示信息</param>
        /// <param name="type">类型INFO,ERROR,QUESTION,WARNING</param>
        public static void MessageShow(string infos, string type)
        {
            MessageBoxConfig config = new MessageBoxConfig();
            config.Message = infos;
            config.Buttons = MessageBox.Button.OK;
            if (type == "INFO")
            {
                config.Title = "提示";
                config.Icon = MessageBox.Icon.INFO;

            }
            else if (type == "ERROR")
            {
                config.Title = "错误";
                config.Icon = MessageBox.Icon.ERROR;
            }
            else if (type == "QUESTION")
            {
                config.Title = "询问";
                config.Icon = MessageBox.Icon.QUESTION;
            }
            else if (type == "WARNING")
            {
                config.Title = "警告";
                config.Icon = MessageBox.Icon.WARNING;
            }
            X.MessageBox.Show(config);
        }

        /// <summary>
        /// 浮动提示框
        /// </summary>
        /// <param name="info">提示信息</param>
        /// <param name="type">类型ERROR，其他</param>
        public static void NotifiShow(string info, string type)
        {
            NotificationConfig config = new NotificationConfig();
            config.HideDelay = 2000;
            config.BodyStyle = "padding:5px;color:green;text-align:left;";
            config.Html = info;
            config.Icon = Icon.Information;
            if (type == "ERROR")
            {
                config.Title = "失败";
            }
            else
                config.Title = "成功";
            Notification.Show(config);
        }
    } 