using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ElegantWM.Tools;
using System.Net;
using System.IO;
using ElegantWM.WeiXin.SimulatorEntity;
using LitJson;
using ElegantWM.Factory;
using ElegantWM.EntityModel;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using System.Drawing;

/*
 * 模拟器
 * 功能：模拟登陆微信公众平台，获取用户fake_id，发送点对点消息，突破群发限制
 * 2014-07-20
 * jackchain
 * v1.0
 * 
 */

namespace ElegantWM.WeiXin
{
    public class Simulator
    {
        /*hack URL*/
        private string url_login = "https://mp.weixin.qq.com/cgi-bin/login?lang=zh_CN&username={0}&pwd={1}&imgcode=&f=json";
        private string url_contact = "https://mp.weixin.qq.com/cgi-bin/contactmanage?t=user/index&pagesize={1}&pageidx=0&type=0&groupid=0&token={0}&lang=zh_CN";
        private string url_contactDetail = "https://mp.weixin.qq.com/cgi-bin/getcontactinfo?ajax=1&f=json&lang=zh_CN&t=ajax-getcontactinfo&lang=zh_CN&fakeid={0}&token={1}";
        private string url_headImg = "https://mp.weixin.qq.com/misc/getheadimg?fakeid={0}&token={1}&lang=zh_CN";
        /// <summary>
        /// 获取Cookie
        /// </summary>
        /// <param name="aid"></param>
        /// <returns></returns>
        public WxCookie GetWxCookie(Guid aid)
        {
            if(SessionHelper.Get("HackerWx_" + aid.ToString())==null)
            {
                WX_Account account = WMFactory.WXAccount.GetById(aid.ToString());
                if (!Login(aid, account.LoginEmail, account.LoginPwd))
                {
                    throw new Exception("模拟登陆微信平台失败！");
                }
            }
            return (WxCookie)SessionHelper.Get("HackerWx_" + aid.ToString());
        }

        /// <summary>
        /// 登陆微信公众平台
        /// </summary>
        /// <param name="wxEmail">用户名</param>
        /// <param name="pwd">密码</param>
        /// <returns>是否成功</returns>
        public bool Login(Guid aid,string wxEmail, string pwd)
        {
            string url = string.Format(url_login, wxEmail, DEncrypt.MD5Security(pwd));

            CookieContainer cc = new CookieContainer();//接收缓存
            HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(url);  //新建一个WebRequest对象用来请求或者响应url
            webRequest.CookieContainer = cc;                                      //保存cookie  
            webRequest.Method = "POST";                                          //请求方式是POST
            webRequest.ContentType = "application/x-www-form-urlencoded; charset=UTF-8";       //请求的内容格式为application/x-www-form-urlencoded
            webRequest.Referer = "https://mp.weixin.qq.com/";
            webRequest.UserAgent="Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36";
            HttpWebResponse response = (HttpWebResponse)webRequest.GetResponse();
            StreamReader sr = new StreamReader(response.GetResponseStream(), Encoding.Default);
            string responseText = sr.ReadToEnd();
            WXResponse wxRsp = JsonConvert.DeserializeObject<WXResponse>(responseText);
            if (wxRsp.base_resp.err_msg.Length > 0 && wxRsp.base_resp.err_msg.Contains("ok"))
            {
                WxCookie cookie = new WxCookie();
                cookie.TokenId = wxRsp.redirect_url.Substring(wxRsp.redirect_url.LastIndexOf('=') + 1);
                cookie.Cookie = cc;
                //保存cookie
                SessionHelper.Add("HackerWx_" + aid.ToString(), cookie);
                return true;
            }
            return false;
        }

        /// <summary>
        /// 获取微信的所有联系人
        /// </summary>
        /// <param name="aid"></param>
        public List<Contact> GetWxContacts(Guid aid)
        {
            WxCookie cookie = GetWxCookie(aid);
            HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(string.Format(url_contact,cookie.TokenId,10));//Url为获取用户信息的链接
            webRequest.CookieContainer = cookie.Cookie;
            webRequest.ContentType = "text/html; charset=UTF-8";
            webRequest.Method = "GET";
            webRequest.UserAgent = "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36";
            webRequest.ContentType = "application/x-www-form-urlencoded";
            HttpWebResponse response = (HttpWebResponse)webRequest.GetResponse();
            StreamReader sr = new StreamReader(response.GetResponseStream(), Encoding.GetEncoding("UTF-8"));
            string text = sr.ReadToEnd();
            MatchCollection mcGroup;
            //获取总数
            Regex GroupRex = new Regex(@"(?<=totalCount : ').*(?=' \* 1)");
            mcGroup = GroupRex.Matches(text);
            if (mcGroup.Count != 0)
            {
                //获取总的微信用户数
                int totalCount = int.Parse(mcGroup[0].Value);
                return GetContactList(aid, totalCount);
            }
            return null;
        }

        /// <summary>
        /// 获取联系人信息
        /// </summary>
        /// <param name="aid"></param>
        /// <param name="totalCount"></param>
        /// <returns></returns>
        private List<Contact> GetContactList(Guid aid,int totalCount)
        {
            WxCookie cookie = GetWxCookie(aid);
            HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(string.Format(url_contact, cookie.TokenId, totalCount));//Url为获取用户信息的链接
            webRequest.CookieContainer = cookie.Cookie;
            webRequest.ContentType = "text/html; charset=UTF-8";
            webRequest.Method = "GET";
            webRequest.UserAgent = "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36";
            webRequest.ContentType = "application/x-www-form-urlencoded";
            HttpWebResponse response = (HttpWebResponse)webRequest.GetResponse();
            StreamReader sr = new StreamReader(response.GetResponseStream(), Encoding.GetEncoding("UTF-8"));
            string text = sr.ReadToEnd();
            MatchCollection jsonData;
            //获取总用户数
            Regex GroupRex = new Regex(@"(?<=friendsList : \({""contacts"":).*(?=}\).contacts)");
            jsonData = GroupRex.Matches(text);
            if (jsonData.Count != 0)
            {
                string friends = jsonData[0].Value.ToString();
                List<Contact> list = JsonConvert.DeserializeObject<List<Contact>>(friends);
                //foreach (Contact cnt in list)
                //{
                //    GetContactDetail(cookie, cnt);
                //}
                return list;
            }
            return null;
        }

        /// <summary>
        /// 获取详细信息
        /// </summary>
        /// <param name="cookie"></param>
        /// <param name="cnt"></param>
        public Contact GetContactDetail(Guid aid,long fakeId)
        {
            WxCookie cookie = GetWxCookie(aid);
            HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(string.Format(url_contactDetail, fakeId, cookie.TokenId));
            webRequest.CookieContainer = cookie.Cookie;
            webRequest.Method = "POST";
            webRequest.UserAgent = "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36";
            webRequest.ContentType = "application/x-www-form-urlencoded; charset=UTF-8";
            webRequest.Referer = "https://mp.weixin.qq.com/";

            HttpWebResponse response = (HttpWebResponse)webRequest.GetResponse();
            StreamReader sr = new StreamReader(response.GetResponseStream(), Encoding.GetEncoding("UTF-8"));
            string rspTxt = sr.ReadToEnd();
            WXResponse wxRsp = JsonConvert.DeserializeObject<WXResponse>(rspTxt);
            return wxRsp.contact_info; 
        }

        /// <summary>
        /// 获取图片
        /// </summary>
        /// <param name="aid"></param>
        /// <param name="fakeId"></param>
        /// <returns></returns>
        public Stream GetHeadImg(Guid aid,long fakeId)
        {
            WxCookie cookie = GetWxCookie(aid);
            HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(string.Format(url_headImg, fakeId, cookie.TokenId));
            webRequest.CookieContainer = cookie.Cookie;
            webRequest.Method = "GET";
            webRequest.Accept = "image/png,image/*;q=0.8,*/*;q=0.5";
            webRequest.UserAgent = "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36";
            //webRequest.ContentType = "application/x-www-form-urlencoded; charset=UTF-8";
            webRequest.Referer = "https://mp.weixin.qq.com/";

            HttpWebResponse response = (HttpWebResponse)webRequest.GetResponse();
            return response.GetResponseStream();
        }

        /// <summary>
        /// 发送点对点消息
        /// </summary>
        /// <param name="aid">微信ID</param>
        /// <param name="fakeId">fakeId</param>
        /// <returns>成功失败</returns>
        public bool SendMsg(Guid aid, long fakeId,string msg,int type=0)
        {
            WxCookie cookie = GetWxCookie(aid);
            string padata = "type=1&content=" + msg + "&tofakeid=" + fakeId.ToString() + "&imgcode=&token=" + cookie.TokenId + "&lang=zh_CN&random=0.4486911059357226&t=ajax-response";
           
            if (type == 1)//发送图文
            {
                padata = "type=10&app_id=" + msg + "&tofakeid=" + fakeId.ToString() + "&appmsgid=" + msg + "&imgcode=&token=" + cookie.TokenId + "&lang=zh_CN&random=0.22518408996984363&f=json&ajax=1&t=ajax-response";
            }
            string url = "https://mp.weixin.qq.com/cgi-bin/singlesend";

            byte[] byteArray = Encoding.UTF8.GetBytes(padata);
            HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(url);

            webRequest.CookieContainer = cookie.Cookie; //登录时得到的缓存

            webRequest.Referer = "https://mp.weixin.qq.com/cgi-bin/singlesendpage?t=message/send&action=index&tofakeid=" + fakeId.ToString() + "&token=" + cookie.TokenId + "&lang=zh_CN";
            webRequest.Method = "POST";
            webRequest.UserAgent = "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36";
            webRequest.ContentType = "application/x-www-form-urlencoded";
            webRequest.ContentLength = byteArray.Length;
            Stream sr = webRequest.GetRequestStream();
            sr.Write(byteArray, 0, byteArray.Length);
            sr.Close();
            HttpWebResponse resp = (HttpWebResponse)webRequest.GetResponse();
            StreamReader srst = new StreamReader(resp.GetResponseStream(), Encoding.GetEncoding("UTF-8"));
            string respTxt = srst.ReadToEnd();
            if (respTxt.Contains("ok"))
            {
                return true;
            }
            return false;
        }
    }
}
