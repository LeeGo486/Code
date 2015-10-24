using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Net.Mail;
using System.Net;

namespace ElegantWM.Tools
{
    /// <summary>
    /// 发送邮件
    /// </summary>
    public class MailHelper
    {
        #region 私有变量

        private string _mailTo;            //接收方
        private string _mailFrom;          //发送方 
        private string _subject;           //标题
        private string _body;              //内容
        private string _username;          //邮件用户
        private string _pwd;               //密码
        private string _smtpclient;        //smtp服务器名字
        private string _youname;           //关联姓名
        private bool _bodyhtml = false;    //正文是否为html格式
        private List<string> _listCc = new List<string>();//抄送
        //编码暂硬性规定为GB2312 
        private Encoding _encoding = Encoding.GetEncoding(936);

        #endregion

        #region 私有属性

        /// <summary>
        /// smtp服务器
        /// </summary>
        private string SmtpClient
        {
            set
            {
                //格式如smtp.sina.com
                Regex regex = new Regex(@"^smtp(\.([a-zA-Z0-9])+){2}$");
                if (regex.IsMatch(value))
                    this._smtpclient = value;
                else
                    throw new ArgumentException("smtp服务器设置失败");
            }
        }

        /// <summary>
        /// 发送方
        /// </summary>
        private string MailTo
        {
            set
            {
                if (IsValidEMail(value))
                    this._mailTo = value;
                else
                    throw new ArgumentException("发送方设置错误");
            }
        }

        /// <summary>
        /// 用户名
        /// </summary>
        private string UserName
        {
            set
            {
                if (string.IsNullOrEmpty(value))
                    throw new ArgumentException("用户名不能为空");
                if (!this._mailFrom.StartsWith(value))
                    throw new ArgumentException("用户名设置和发送方不匹配");
                this._username = value;
            }
        }

        /// <summary>
        /// 密码
        /// </summary>
        private string Pwd
        {
            set
            {
                if (string.IsNullOrEmpty(value))
                    throw new ArgumentException("密码不能为空");
                this._pwd = value;
            }
        }

        /// <summary>
        /// 发送给
        /// </summary>
        private string MailFrom
        {
            set
            {
                if (IsValidEMail(value))
                    this._mailFrom = value;
                else
                    throw new ArgumentException("接收方设置错误");
            }
        }

        /// <summary>
        /// 关联姓名
        /// </summary>
        private string YouName
        {
            set
            {
                if (string.IsNullOrEmpty(value))
                    this._youname = this._username;
                else
                    this._youname = value;
            }
        }

        #endregion

        #region 私有方法

        /// <summary>
        /// 检测email格式
        /// </summary>
        /// <param name="email">email</param>
        /// <returns>true为正确</returns>
        private bool IsValidEMail(string email)
        {
            Regex regex = new Regex(@"\w+([-+.]\w+)*\w{2,}@\w+([-.]\w+)*\.\w+([-.]\w+)*");
            if (regex.IsMatch(email))
                return true;
            else
                return false;
        }

        #endregion

        #region 公共属性

        /// <summary>
        /// 标题
        /// </summary>
        public string Subject
        {
            set
            {
                if (string.IsNullOrEmpty(value))
                    throw new ArgumentException("标题不能为空");
                this._subject = value;
            }
        }

        /// <summary>
        /// 正文
        /// </summary>
        public string Body
        {
            set
            {
                if (string.IsNullOrEmpty(value))
                    throw new ArgumentException("正文不能为空");
                this._body = value;
            }
        }

        #endregion

        #region 公共方法

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="smtpclient">smtp服务器,格式如"smtp.sina.com"</param>
        /// <param name="mailFrom">发送方,格式如"mymail@sina.com"</param>
        /// <param name="username">登入名,必填,注意和发送方匹配</param>
        /// <param name="pwd">密码,必填</param>
        /// <param name="mailTo">接收方,格式如"youmail@sina.com"</param>
        /// <param name="subject">标题,最好别为空</param>
        /// <param name="body">正文,必填</param>
        /// <param name="bodyhtml">正文是否为html格式</param>
        /// <param name="youName">关联姓名, 选填</param>
        public MailHelper(string smtpclient, string mailFrom,
            string username, string pwd, string mailTo,
            string subject, string body,
            bool bodyhtml, string youName)
        {
            this.SmtpClient = smtpclient;
            this.MailFrom = mailFrom;
            this.UserName = username;
            this.Pwd = pwd;
            this.MailTo = mailTo;
            this.Subject = subject;
            this.Body = body;
            this.YouName = youName;
            this._bodyhtml = bodyhtml;
        }

        /// <summary>
        /// 添加抄送邮箱, 可多次调用
        /// </summary>
        /// <param name="mailCc">抄送的email</param>
        public void AddMmailCc(string mailCc)
        {
            if (IsValidEMail(mailCc))
                this._listCc.Add(mailCc);
            else
                throw new ArgumentException("抄送'" + mailCc + "'地址错误");
        }

        /// <summary>
        /// 发送邮件
        /// </summary>
        /// <returns>true-发送成功</returns>
        public void DoSend()
        {
            Encoding encoding = this._encoding;

            MailMessage Message = new MailMessage(
            new MailAddress(this._mailFrom, this._youname, this._encoding),
            new MailAddress(this._mailTo));

            Message.SubjectEncoding = this._encoding;
            Message.Subject = this._subject;
            Message.BodyEncoding = this._encoding;
            Message.Body = this._body;
            Message.IsBodyHtml = this._bodyhtml;
            foreach (string strCc in _listCc)
            {
                Message.CC.Add(new MailAddress(strCc));
            }
            SmtpClient smtpClient = new SmtpClient(this._smtpclient);
            smtpClient.Credentials = new NetworkCredential(this._username, this._pwd);

            smtpClient.Timeout = 999999;
            smtpClient.Send(Message);

            //异步调用, 避免阻塞
            //Timeout 属性对 SendAsync 调用没有影响
            //smtpClient.SendAsync(Message, null);
        }

        #endregion
    }
}
