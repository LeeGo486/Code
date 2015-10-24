using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.Tools;
using ElegantWM.WeiXin.MsgEntity;
using LitJson;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Security;

namespace ElegantWM.WeiXin
{
    public class Common
    {
        public static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// 获取Token
        /// </summary>
        /// <param name="sid"></param>
        /// <returns></returns>
        public static string GetTokenId(string sid)
        {
            if (CacheHelper.CacheValue("accesstoken_" + sid) == null)
            {
                WX_Account account = WMFactory.WXAccount.GetById(sid);
                string url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid={0}&secret={1}";
                url = string.Format(url, account.AppId, account.AppSecret);
                string rst = HttpCrossDomain.Get(url);
                if (rst.Contains("errcode"))
                {
                    throw new Exception(rst);
                }
                else
                {
                    WxToken token = JsonMapper.ToObject<WxToken>(rst);
                    CacheHelper.CacheInsertAddMinutes("accesstoken_" + sid, token.access_token, 90);
                    return token.access_token;
                }
            }
            else
                return CacheHelper.CacheValue("accesstoken_" + sid).ToString();

        }

        /// <summary>
        /// 获取微信菜单
        /// </summary>
        /// <param name="sid"></param>
        /// <returns></returns>
        public static string GetMenu(string sid)
        {
            string url = "https://api.weixin.qq.com/cgi-bin/menu/get?access_token=" + GetTokenId(sid);
            return HttpCrossDomain.Get(url);
        }

        /// <summary>
        /// 获取JS ticket
        /// </summary>
        /// <param name="sid"></param>
        /// <returns></returns>
        public static string GetTicket(string sid)
        {
            if (CacheHelper.CacheValue("ticket_" + sid) == null)
            {
                string url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + GetTokenId(sid) + "&type=jsapi";
                string rst = HttpCrossDomain.Get(url);

                WxTicket ticket = JsonMapper.ToObject<WxTicket>(rst);
                if (ticket.errcode != 0)
                {
                    throw new Exception(rst);
                }
                else
                {
                    CacheHelper.CacheInsertAddMinutes("ticket_" + sid, ticket.ticket, 90);
                    return ticket.ticket;
                }
            }
            else
                return CacheHelper.CacheValue("ticket_" + sid).ToString();
        }

        /// <summary>
        /// 获取JS signature
        /// </summary>
        /// <param name="sid"></param>
        /// <returns></returns>
        public static string GetSignature(string sid, string nonceStr, string timestamp, string url)
        {
            string ticket = GetTicket(sid);
            string[] ArrTmp = { "jsapi_ticket=" + ticket, "noncestr=" + nonceStr, "timestamp=" + timestamp, "url=" + url };
            Array.Sort(ArrTmp);     //字典排序
            string tmpStr = string.Join("&", ArrTmp);
            tmpStr = FormsAuthentication.HashPasswordForStoringInConfigFile(tmpStr, "SHA1");
            tmpStr = tmpStr.ToLower();

            if (tmpStr == null)
            {
                return null;
            }
            else
            {
                return tmpStr;
            }
        }

        /// <summary>
        /// 更新微信菜单
        /// </summary>
        /// <param name="sid"></param>
        /// <param name="menuJson"></param>
        /// <returns></returns>
        public static string SaveMenu(string sid, string menuJson)
        {
            string url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=" + GetTokenId(sid);
            return HttpCrossDomain.Post(url, menuJson);
        }

        /// <summary>
        /// 删除微信菜单
        /// </summary>
        /// <param name="sid"></param>
        /// <param name="menuJson"></param>
        /// <returns></returns>
        public static string RemoveMenu(string sid)
        {
            string url = "https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=" + GetTokenId(sid);
            return HttpCrossDomain.Get(url);
        }

        /// <summary>
        /// 获取微信粉丝的信息
        /// </summary>
        /// <param name="sid"></param>
        /// <param name="openId"></param>
        /// <returns></returns>
        public static WxFans GetFanInfo(string sid, string openId)
        {
            string url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=" + GetTokenId(sid) + "&openid=" + openId + "&lang=zh_CN";
            string rst = HttpCrossDomain.Get(url);
            if (rst.Contains("errcode"))
            {
                return null;
            }
            WxFans fan = JsonMapper.ToObject<WxFans>(rst);
            if (fan.subscribe == 0)
            {
                return null;
            }
            else
            {
                return fan;
            }

        }

        /// <summary>
        /// 微信OAuth页面
        /// </summary>
        /// <param name="sid">微信的ID</param>
        /// <param name="returnUrl">跳转回来的url</param>
        /// <param name="needAgree">是否需要弹出授权界面</param>
        /// <returns></returns>
        public static string GetOAuthUrl(string sid, string returnUrl, bool needAgree = false)
        {
            string url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid={0}&redirect_uri={1}&response_type=code&scope=snsapi_base&state=matrix#wechat_redirect";
            if (needAgree)
                url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid={0}&redirect_uri={1}&response_type=code&scope=snsapi_userinfo&state=matrix#wechat_redirect";
            if (CacheHelper.CacheValue(sid) == null)
            {
                CacheHelper.CacheInsertFromMinutes(sid, WMFactory.WXAccount.GetById(sid), 120);
            }
            WX_Account account = (WX_Account)CacheHelper.CacheValue(sid);
            url = string.Format(url, account.AppId, returnUrl);
            return url;
        }

        /// <summary>
        /// 高级接口，获取用户的OpenId
        /// </summary>
        /// <param name="sid"></param>
        /// <returns></returns>
        public static string GetFanOpenId(string sid, string code)
        {
            if (CacheHelper.CacheValue(sid) == null)
            {
                CacheHelper.CacheInsertFromMinutes(sid, WMFactory.WXAccount.GetById(sid), 120);
            }
            WX_Account account = (WX_Account)CacheHelper.CacheValue(sid);
            string url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid={0}&secret={1}&code={2}&grant_type=authorization_code";
            url = string.Format(url, account.AppId, account.AppSecret, code);
            string rst = HttpCrossDomain.Get(url);
            if (rst.Contains("errcode"))
            {
                log.Error("OAuth认证失败，无法获取OpenId：" + rst + ";sid=" + sid + ";code=" + code + ";URL=" + url);
                //throw new Exception("OAuth认证失败，无法获取OpenId：" + rst);
                return null;
            }
            WxSnsapiBase snsapi = JsonMapper.ToObject<WxSnsapiBase>(rst);
            return snsapi.openid;
        }

        /// <summary>
        /// 获取用户基本信息（包括未关注的情况）
        /// </summary>
        /// <param name="sid">微信账号ID</param>
        /// <param name="code">Code</param>
        /// <returns></returns>
        public static string GetFanUserInfo(string sid, string code)
        {
            if (CacheHelper.CacheValue(sid) == null)
            {
                CacheHelper.CacheInsertFromMinutes(sid, WMFactory.WXAccount.GetById(sid), 120);
            }
            WX_Account account = (WX_Account)CacheHelper.CacheValue(sid);
            string url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid={0}&secret={1}&code={2}&grant_type=authorization_code";
            url = string.Format(url, account.AppId, account.AppSecret, code);
            string rst = HttpCrossDomain.Get(url);
            if (rst.Contains("errcode"))
            {
                throw new Exception("OAuth认证失败，无法获取OpenId：" + rst);
            }
            WxSnsapiBase snsapi = JsonMapper.ToObject<WxSnsapiBase>(rst);
            //然后在去获取用户基本信息
            url = "https://api.weixin.qq.com/sns/userinfo?access_token={0}&openid={1}&lang=zh_CN";
            url = string.Format(url, snsapi.access_token, snsapi.openid);
            rst = HttpCrossDomain.Get(url);
            if (rst.Contains("errcode"))
            {
                throw new Exception("获取微信用户信息失败：" + rst);
            }
            return rst;
            //WxSnsapiUserinfo userinfo = JsonMapper.ToObject<WxSnsapiUserinfo>(rst);
            //return userinfo;
        }

        /// <summary>
        /// 发送服务通知
        /// </summary>
        /// <param name="sid"></param>
        /// <param name="menuJson"></param>
        /// <returns></returns>
        public static bool SendServiceNotice(string sid, WxServiceNotice notice)
        {
            string url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" + GetTokenId(sid);
            string json = "{\"touser\":\"" + notice.touser + "\","
                         + "\"template_id\":\"" + notice.template_id + "\","
                         + "\"url\":\"" + notice.url + "\","
                         + "\"topcolor\":\"" + notice.topcolor + "\","
                         + "\"data\":" + notice.data + "}";
            string rst = HttpCrossDomain.Post(url, json);
            if (rst.Contains("\"errcode\":0"))
                return true;
            else
                throw new Exception("发送通知服务失败：" + rst + ",JSON=" + json);
        }

        /// <summary>
        /// 获取关注者列表
        /// </summary>
        /// <param name="sid"></param>
        public static WxOpenIds GetFanList(string sid, string nextOpenId)
        {
            string url = "https://api.weixin.qq.com/cgi-bin/user/get?access_token=" + GetTokenId(sid) + (string.IsNullOrEmpty(nextOpenId) ? "" : "&next_openid=" + nextOpenId);
            string rst = HttpCrossDomain.Get(url);
            if (rst.Contains("errcode"))
            {
                throw new Exception(rst);
            }
            else
            {
                WxOpenIds openids = JsonMapper.ToObject<WxOpenIds>(rst);
                return openids;
            }
        }

        /// <summary>
        /// 发送客服消息，48小时内,{"errcode":45015,"errmsg":"response out of time limit"},{"errcode":40003,"errmsg":"invalid openid"}
        /// </summary>
        /// <param name="sid">微信号ID</param>
        /// <param name="text">文本内容</param>
        /// <param name="oid">接收人</param>
        /// <param name="type">消息类型</param>
        /// <param name="json">该消息类型的内容</param>
        /// <returns></returns>
        public static bool SendCustomerService(string sid, string oid, string type, string json)
        {
            string url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=" + GetTokenId(sid);
            string data = "{\"touser\":\"" + oid + "\",\"msgtype\":\"" + type + "\","
                       + "\"" + type + "\":" + json + "}";
            string rst = HttpCrossDomain.Post(url, data);
            if (rst.Contains("\"errcode\":0"))
                return true;
            else
                throw new Exception(rst);
        }


        /// <summary>
        /// 获取素材列表
        /// </summary>
        /// <param name="sid"></param>
        /// <param name="mediaJson"></param>
        /// <returns></returns>
        public static WxNews GetMediaList(string sid, string mediaJson)
        {
            string url = "https://api.weixin.qq.com/cgi-bin/material/batchget_material?access_token=" + GetTokenId(sid);
            string rst = HttpCrossDomain.Post(url, mediaJson);
            if (rst.Contains("errcode"))
            {
                throw new Exception(rst);
            }
            else
            {
                WxNews news = JsonMapper.ToObject<WxNews>(rst);
                return news;
            }
        }

        /// <summary>
        /// 获取素材
        /// </summary>
        /// <param name="sid"></param>
        /// <param name="mediaJson"></param>
        /// <returns></returns>
        public static void DownloadImage(string sid, string mediaJson, string path)
        {
            string url = "https://api.weixin.qq.com/cgi-bin/material/get_material?access_token=" + GetTokenId(sid);
            HttpCrossDomain.DownloadImage(url, mediaJson, path);
        }

        /// <summary>
        /// 获取临时素材
        /// </summary>
        /// <param name="sid"></param>
        /// <param name="mediaJson"></param>
        /// <returns></returns>
        public static WxItemContent GetMedia(string sid, string mediaJson)
        {
            string url = "https://api.weixin.qq.com/cgi-bin/material/get_material?access_token=" + GetTokenId(sid);
            string rst = HttpCrossDomain.Post(url, mediaJson);
            if (rst.Contains("errcode"))
            {
                throw new Exception(rst);
            }
            else
            {
                WxItemContent item = JsonMapper.ToObject<WxItemContent>(rst);
                return item;
            }
        }

        /// <summary>
        /// 永久二维码
        /// </summary>
        /// <param name="sid"></param>
        /// <param name="mediaJson"></param> 
        /// <param name="path"></param>
        public static string Qr_limit_scene(string sid, string sceneJson, int iScene_id)
        {
            string url = "https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=" + GetTokenId(sid);
            string rst = HttpCrossDomain.Post(url, sceneJson);
            if (rst.Contains("errcode"))
            {
                throw new Exception(rst);
            }
            else
            {
                WxTicket ticket = JsonMapper.ToObject<WxTicket>(rst);
                url = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=" + ticket.ticket;

                Guid QRSid = Guid.Parse(sid);
                IEnumerable<WX_QR_Code> ScanCodes = WMFactory.WX_QR_Code.FindByConditions(null, f => f.AccountId == QRSid && f.Scene_ID == iScene_id, null);
                WX_QR_Code Scan = new WX_QR_Code();
                Scan = ScanCodes.FirstOrDefault();
                Scan.ModifyTime = System.DateTime.Now;
                Scan.Url = url;
                WMFactory.WX_QR_Code.Update(Scan);
                return url;
            }
        }
    }
}