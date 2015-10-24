using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.Tools;
using ElegantWM.WeiXin.MsgEntity;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;

namespace ElegantWM.WeiXin
{
    public class MessageRouter
    {
        public static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        /// <summary>
        /// 分析微信POST到本服务器的XML数据
        /// </summary>
        /// <param name="xmlStream"></param>
        /// <returns></returns>
        public static string AnalyzeXmlFromWeiXin(string sid, string xml)
        {
            //获取MsgType
            //log.Info(xml);
            string msgType = XmlHelper.ReadXmlStr(xml, "/xml/MsgType", "");
            //log.Info(msgType);
            switch (msgType)
            {
                case "event":
                    //log.Info(xml);
                    return EventRouter(sid, xml);
                case "text":
                    return OnReceiveTextMsg(sid, xml);
                default:
                    {
                        return null;
                    }
            }
        }

        /// <summary>
        /// 响应文本消息
        /// </summary>
        /// <param name="xml"></param>
        /// <returns></returns>
        private static string OnReceiveTextMsg(string sid, string xml)
        {
            WxTextMsg msg = XmlEntityExchange<WxTextMsg>.ConvertXml2Entity(xml);
            //返回消息，互换收发用户
            string toUser = msg.FromUserName;
            msg.FromUserName = msg.ToUserName;
            msg.ToUserName = toUser;
            msg.CreateTime = DateTime.Now.Ticks;
            //到KeyWord表里查找对应关键字
            Guid aid = Guid.Parse(sid);
            string keyword = msg.Content.Trim();//这里为了解决853 20140506此类情况，需要处理
            keyword = keyword.Split(' ')[0];
            IEnumerable<WX_KeyWord> kwList = WMFactory.WXKeyWord.FindByConditions(o => o.OrderBy(x => x.CreateTime), f => f.AccountId == aid && f.IsUsing == 0 && f.KwList.Contains(keyword + ","));
            if (kwList != null && kwList.Count() > 0)
            {
                WX_KeyWord kw = kwList.First();
                return KeyWordRouter(sid, kw.RespType, msg, kw.Id, msg.Content);
            }
            //没有配置
            return "";
        }

        /// <summary>
        /// 配置关键字响应，菜单响应
        /// </summary>
        /// <param name="sid">公众账号ID</param>
        /// <param name="type">类型，text，news，svrtext，svrnews</param>
        /// <param name="msg">消息</param>
        /// <param name="kid">关键字ID</param>
        /// <param name="keyword">用户输入的值需要传递过来</param>
        /// <returns></returns>
        private static string KeyWordRouter(string sid, string type, WxTextMsg msg, Guid kid, string keyword = "")
        {
            if (type == "text" || type == "svrtext" || type == "svrnews")
            {
                IEnumerable<WX_RespImgTxt> rspList = WMFactory.WXRespImgTxt.FindByConditions(null, f => f.KwId == kid);
                if (rspList == null || rspList.Count() <= 0)
                    return null;
                WX_RespImgTxt resp = rspList.FirstOrDefault();

                if (type == "text")
                {
                    //替换关键字
                    msg.MsgType = "text";
                    msg.Content = resp.Content.Replace("{SID}", sid).Replace("{OID}", msg.ToUserName).Replace("{KID}", kid.ToString());
                    return XmlEntityExchange<WxTextMsg>.ConvertEntity2Xml(msg);
                }
                else if (type == "svrnews")
                {

                    resp.AbsUrl += resp.AbsUrl.Contains("?") ? "&" : "?" + "sid=" + sid + "&oid=" + msg.ToUserName + "&mid=" + kid + "&kw=" + HttpUtility.UrlEncode(keyword);
                    string svrRst = Tools.HttpCrossDomain.Post(resp.AbsUrl, resp.Content);
                    string template = @"<xml>
                                            <ToUserName><![CDATA[{0}]]></ToUserName>
                                            <FromUserName><![CDATA[{1}]]></FromUserName>
                                            <CreateTime>{2}</CreateTime>
                                            <MsgType><![CDATA[news]]></MsgType><ArticleCount>{4}</ArticleCount>{3}</xml>";

                    //获取记录条数Regex.Matches(svrXml, "<item>").Count
                    return string.Format(template, msg.ToUserName, msg.FromUserName, msg.CreateTime, svrRst, Regex.Matches(svrRst, "<item>").Count);
                }
                else if (type == "svrtext")
                {
                    resp.AbsUrl += resp.AbsUrl.Contains("?") ? "&" : "?" + "sid=" + sid + "&oid=" + msg.ToUserName + "&mid=" + kid + "&kw=" + HttpUtility.UrlEncode(keyword);
                    string svrRst = Tools.HttpCrossDomain.Post(resp.AbsUrl, resp.Content);
                    msg.MsgType = "text";
                    msg.Content = svrRst.Replace("{SID}", sid).Replace("{OID}", msg.ToUserName).Replace("{KID}", kid.ToString());
                    return XmlEntityExchange<WxTextMsg>.ConvertEntity2Xml(msg);
                }
            }
            else if (type == "news")
            {
                int total = 0;
                //随机
                //IEnumerable<WX_RespImgTxt> rspNewsList = WMFactory.WXRespImgTxt.FindByPage(0, 10, out total, o => o.OrderBy(n => Guid.NewGuid()), f => f.KwId == kid && f.IsShow == 0);

                //不随机
                IEnumerable<WX_RespImgTxt> rspNewsList = WMFactory.WXRespImgTxt.FindByPage(0, 10, out total, o => o.OrderByDescending(a => a.IsMain).ThenBy(x => x.OrderIndex), f => f.KwId == kid && f.IsShow == 0);

                if (rspNewsList != null && rspNewsList.Count() > 0)
                {
                    string dns = "http://" + HttpContext.Current.Request.Url.Authority;
                    WxNewsMsg newsMsg = new WxNewsMsg();
                    newsMsg.MsgType = "news";
                    newsMsg.ToUserName = msg.ToUserName;
                    newsMsg.FromUserName = msg.FromUserName;
                    newsMsg.CreateTime = DateTime.Now.Ticks;
                    newsMsg.Articles = new List<Article>();

                    //newsMsg.ArticleCount = 1;
                    //WX_RespImgTxt rsp = rspNewsList.FirstOrDefault();
                    //Article art = new Article();
                    //art.Description = rsp.Description;
                    //art.Title = rsp.Title;
                    //if (rsp.AbsUrl == "NULL")
                    //    art.Url = "";
                    //else
                    //    art.Url = (string.IsNullOrEmpty(rsp.AbsUrl) ? dns + "/WeiXin/Article/Index/" + rsp.Id.ToString() : rsp.AbsUrl.Trim());
                    ////将当前服务号和当前用户openid传到url里
                    //string prms = art.Url.Contains("?") ? "&" : "?";
                    //art.Url += prms + "sid=" + sid + "&oid=" + msg.ToUserName + "&kid=" + kid.ToString();
                    //art.PicUrl = (string.IsNullOrEmpty(rsp.ImageUrl)) ? "" : dns + "/Content/Uploads/" + rsp.ImageUrl;
                    //newsMsg.Articles.Add(art);

                    newsMsg.ArticleCount = rspNewsList.Count();//图文数量
                    foreach (WX_RespImgTxt rsp in rspNewsList)
                    {
                        Article art = new Article();
                        art.Description = rsp.Description;
                        art.Title = rsp.Title;
                        if (rsp.AbsUrl == "NULL")
                            art.Url = "";
                        else
                            art.Url = (string.IsNullOrEmpty(rsp.AbsUrl) ? dns + "/WeiXin/Article/Index/" + rsp.Id.ToString() : rsp.AbsUrl.Trim());
                        //将当前服务号和当前用户openid传到url里
                        string prms = art.Url.Contains("?") ? "&" : "?";
                        art.Url += prms + "sid=" + sid + "&oid=" + msg.ToUserName + "&kid=" + kid.ToString();
                        art.PicUrl = (string.IsNullOrEmpty(rsp.ImageUrl)) ? "" : dns + "/Content/Uploads/" + rsp.ImageUrl;
                        newsMsg.Articles.Add(art);
                    }


                    return XmlEntityExchange<WxNewsMsg>.ConvertEntity2Xml(newsMsg);
                }
            }
            return null;
        }

        /// <summary>
        /// 响应事件
        /// </summary>
        /// <param name="xml"></param>
        private static string EventRouter(string sid, string xml)
        {
            WxEvent wxevent = XmlEntityExchange<WxEvent>.ConvertXml2Entity(xml);
            WxTextMsg msg = new WxTextMsg();
            msg.ToUserName = wxevent.FromUserName;
            msg.FromUserName = wxevent.ToUserName;
            msg.CreateTime = DateTime.Now.Ticks;
            string strScene_ID; //场景号
            Guid guidAccountid = Guid.Parse(sid);
            WX_Account account = (WX_Account)CacheHelper.CacheValue(sid);

            //如果是关注，则发送欢迎消息
            switch (wxevent.Event)
            {
                #region 关注
                case "subscribe":   //关注
                    {
                        if (wxevent.EventKey.Contains("qrscene") == true)//关注如果包含二维码扫描参数
                        {
                            strScene_ID = wxevent.EventKey.Substring(8, wxevent.EventKey.Length - 8) + ",";
                            IEnumerable<WX_KeyWord> KeyWordFirst = WMFactory.WXKeyWord.FindByConditions(null, f => f.AccountId == guidAccountid
                                                                                                        && f.KwList == strScene_ID, null);
                            if (KeyWordFirst == null)
                            {
                                msg.MsgType = "text";
                                msg.Content = account.WelcomeWord;
                                AddFans(wxevent, account);
                                break;
                            }
                            else
                            {
                                AddFans(wxevent, account);
                                AddSCANWxEvent(wxevent, account, true);
                                return KeyWordRouter(sid, KeyWordFirst.First().RespType, msg, KeyWordFirst.First().Id);
                            }
                        }
                        else
                        {
                            msg.Content = account.WelcomeWord;
                            if (account.WelcomeWord.Contains("首次关注图文"))
                            {
                                msg.Content = "首次关注图文";

                                IEnumerable<WX_KeyWord> KeyWordFirst = WMFactory.WXKeyWord.FindByConditions(null, f => f.AccountId == guidAccountid && "首次关注图文,".Contains(f.KwList), null);
                                if (KeyWordFirst == null)
                                {
                                    msg.MsgType = "text";
                                    msg.Content = account.WelcomeWord;
                                    AddFans(wxevent, account);
                                    break;
                                }
                                else
                                {
                                    AddFans(wxevent, account);
                                    return KeyWordRouter(sid, KeyWordFirst.First().RespType, msg, KeyWordFirst.First().Id);
                                }
                            }
                            else
                            {
                                msg.MsgType = "text";
                                msg.Content = account.WelcomeWord;
                                AddFans(wxevent, account);
                                break;
                            }
                        }
                    }
                case "unsubscribe": //取消关注
                    msg.MsgType = "text";
                    RemoveFans(wxevent, Guid.Parse(sid));
                    break;

                #endregion

                #region 单击

                case "CLICK":
                    //单击菜单的时候，获取菜单ID，找到该菜单的类型，找到对应的文本
                    WX_Menu menu = WMFactory.WXMenu.GetById(wxevent.EventKey);
                    if (menu == null)
                    {
                        msg.MsgType = "text";
                        msg.Content = "暂无事件设定！";
                        break;
                    }
                    return KeyWordRouter(sid, menu.RespType, msg, menu.Id);

                #endregion

                #region 扫描二维码

                case "SCAN":


                    //strScene_ID = int.Parse(wxevent.EventKey.Substring(8, wxevent.EventKey.Length - 8));
                    string iEventKey = wxevent.EventKey + ",";
                    //WX_QR_Code WX_QR_CodeListQR = WMFactory.WX_QR_Code.FindByConditions(null, f => f.AccountId == AccountidSCAN && f.Scene_ID == iEventKey, null).First();
                    //string KwListQR = WX_QR_CodeListQR.Scene_ID.ToString() + ",";
                    //string KwListQR = "1000,";
                    //IEnumerable<WX_KeyWord> KeyWordFirstQR = WMFactory.WXKeyWord.FindByConditions(null, f => f.AccountId == AccountidSCAN && f.KwList == KwListQR, null);
                    WX_KeyWord KeyWordFirstQR = WMFactory.WXKeyWord.FindByConditions(null, f => f.AccountId == guidAccountid && f.KwList == iEventKey, null).First();

                    if (KeyWordFirstQR == null)
                    {
                        break;
                    }
                    else
                    {
                        AddSCANWxEvent(wxevent, account, false);
                        return KeyWordRouter(sid, KeyWordFirstQR.RespType, msg, KeyWordFirstQR.Id);
                    }

                #endregion

                default:
                    msg.MsgType = "text";
                    msg.Content = "暂未处理的事件：Event" + wxevent.Event + ";EventKey:" + wxevent.EventKey;
                    break;
            }
            string rst = XmlEntityExchange<WxTextMsg>.ConvertEntity2Xml(msg);
            return rst;
        }

        /// <summary>
        /// 添加粉丝
        /// </summary>
        /// <param name="wxevent">事件</param>
        /// <param name="account">账号</param>
        private static void AddFans(WxEvent wxevent, WX_Account account)
        {
            string openId = wxevent.FromUserName;
            Guid sid = account.Id;
            IEnumerable<WX_Fans> fans = WMFactory.WXFans.FindByConditions(null, f => f.OpenId == openId && f.AccountId == sid, null);
            WX_Fans fan = new WX_Fans();
            if (fans != null && fans.Count() > 0)
            {
                fan = fans.FirstOrDefault();
                fan.ModifyUser = "Matrix";
            }
            fan.OpenId = wxevent.FromUserName;
            fan.AccountId = account.Id;
            fan.CreateUser = "Matrix";
            fan.IsUsed = 0;
            //将关注者插入到数据库
            if (account.IsAuthed == 1)
            {
                WxFans wxfan = Common.GetFanInfo(account.Id.ToString(), openId);
                if (wxfan != null)
                {
                    fan.NickName = wxfan.nickname;
                    fan.Avatar = wxfan.headimgurl;
                    fan.City = wxfan.city;
                    fan.Country = wxfan.country;
                    fan.Province = wxfan.province;
                    fan.Sex = wxfan.sex;
                }
            }
            if (fans != null && fans.Count() > 0)
                WMFactory.WXFans.Update(fan);
            else
                WMFactory.WXFans.Insert(fan);
        }

        /// <summary>
        /// 添加扫描二维码
        /// </summary>
        /// <param name="wxevent">事件</param>
        /// <param name="account">账号</param>
        private static void AddSCANWxEvent(WxEvent wxevent, WX_Account account, bool ISFirst)
        {
            string openId = wxevent.FromUserName;
            int iEventKey;
            if (ISFirst == true)
            {
                iEventKey = int.Parse(wxevent.EventKey.Substring(8, wxevent.EventKey.Length - 8));
            }
            else
            {
                iEventKey = int.Parse(wxevent.EventKey);
            }

            IEnumerable<WX_QR_CodeScanFans> ScanFans = WMFactory.WX_QR_CodeScanFans.FindByConditions(null, f => f.Oid == openId && f.AccountId == account.Id
                                                                                                     && f.Scene_ID == iEventKey, null);
            WX_QR_CodeScanFans ScanFan = new WX_QR_CodeScanFans();

            if (ScanFans != null && ScanFans.Count() > 0)
            {
                ScanFan = ScanFans.FirstOrDefault();
                ScanFan.ModifyUser = "gqq";
                WMFactory.WX_QR_CodeScanFans.Update(ScanFan);
            }
            else
            {
                WX_QR_Code WX_QR_CodeListQR = WMFactory.WX_QR_Code.FindByConditions(null, f => f.AccountId == account.Id && f.Scene_ID == iEventKey, null).First();
                ScanFan.AccountId = account.Id;
                ScanFan.Oid = openId;
                ScanFan.Scene_ID = WX_QR_CodeListQR.Scene_ID;
                ScanFan.Scene_Key = WX_QR_CodeListQR.Scene_Key;
                ScanFan.Scene_Name = WX_QR_CodeListQR.Scene_Name;
                ScanFan.Scene_Param1 = WX_QR_CodeListQR.Scene_Param1;
                ScanFan.Scene_Param2 = wxevent.EventKey;
                ScanFan.CreateTime = System.DateTime.Now;
                ScanFan.CreateUser = "gqq";
                WMFactory.WX_QR_CodeScanFans.Insert(ScanFan);
            }
        }

        /// <summary>
        /// 取消关注
        /// </summary>
        /// <param name="wxevent">事件</param>
        /// <param name="account">账号</param>
        private static void RemoveFans(WxEvent wxevent, Guid sid)
        {
            string openId = wxevent.FromUserName;
            IEnumerable<WX_Fans> fans = WMFactory.WXFans.FindByConditions(null, f => f.OpenId == openId && f.AccountId == sid, null);
            WX_Fans fan = new WX_Fans();
            if (fans != null && fans.Count() > 0)
            {
                fan = fans.FirstOrDefault();
                fan.ModifyUser = "TheOne";
                fan.IsUsed = 1;
                WMFactory.WXFans.Update(fan);
            }
        }
    }
}

