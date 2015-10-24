<%@ WebHandler Language="C#" Class="vip_Identify" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data.SqlClient;
using System.Data;
using Entity;
using System.Configuration;
using Newtonsoft.Json;

public class vip_Identify : IHttpHandler, IReadOnlySessionState
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string act = context.Request["act"].ToString();

        switch (act)
        {
            case "Set_IdentifyCode":
                Set_IdentifyCode(context);
                break;
            case "Chk_IdentifyCode":
                Chk_IdentifyCode(context);
                break;
            case "SendMobileMsg":
                SendMobileMsg(context);
                break;
            default:
                break;
        }
    }

    /// <summary>
    /// 插入验证码到表
    /// </summary>
    /// <param name="IndentifyId"></param>
    /// <param name="Indentifycode"></param>
    private void InsertIdentify(string IndentifyId, string Indentifycode)
    {
        string sql = @"merge vip_Identify as a 
                        using (select @IndentifyId as IndentifyId, @Indentifycode as Indentifycode,GETDATE() AS crdate) as b
                        on a.IndentifyId=b.IndentifyId               
                        when not matched then
                        insert (IndentifyId, Indentifycode,crdate)    
                        values(b.IndentifyId, b.Indentifycode,b.crdate)     
                        when matched then    
                        update set a.Indentifycode=b.Indentifycode,a.crdate=b.crdate; ";
        SqlParameter[] sp = new SqlParameter[] { 
            new SqlParameter("@IndentifyId",IndentifyId),
            new SqlParameter("@Indentifycode",Indentifycode)
        };
        app_cn.ExecuteSQL(sql, sp, CommandType.Text);
    }


    /// <summary>
    /// 删除验证码
    /// </summary>
    /// <param name="IndentifyId"></param>
    /// <param name="Indentifycode"></param>
    private void DelIdentify(string IndentifyId)
    {
        string sql = @"delete from vip_Identify where IndentifyId = @IndentifyId  OR crdate<GETDATE()-1  ";
        SqlParameter[] sp = new SqlParameter[] { 
            new SqlParameter("@IndentifyId",IndentifyId)
        };
        app_cn.ExecuteSQL(sql, sp, CommandType.Text);
    }

    /// <summary>
    /// 获取验证码
    /// </summary>
    /// <param name="IndentifyId"></param>
    /// <param name="Indentifycode"></param>
    private string GetIdentify(string IndentifyId)
    {
        //VIP验证短信有效时间
        int MsgValidity = Convert.ToInt32(app_fun.getCookie("MsgValidity", "60"));

        string sql = @"select DATEDIFF(ss, crdate  , GETDATE()) difftime ,Indentifycode 
                        from vip_Identify where IndentifyId = @IndentifyId   ";
        SqlParameter[] sp = new SqlParameter[] { 
            new SqlParameter("@IndentifyId",IndentifyId)
        };
        DataTable dt = app_cn.getTable(sql, sp, CommandType.Text);
        if (dt.Rows.Count == 0 || Convert.ToInt32(dt.Rows[0]["difftime"]) >= MsgValidity)
        {
            return "";
        }
        else
        {
            return dt.Rows[0]["Indentifycode"].ToString();
        }
    }

    /// <summary>
    /// 验证码判断
    /// </summary>
    /// <param name="IndentifyId"></param>
    /// <param name="Indentifycode"></param>
    /// <returns></returns>
    private bool ChkIdentify(string IndentifyId, string Indentifycode)
    {
        //通用验证码
        string syscode = get_universal_verifi().Trim();
        if (syscode == Indentifycode && Indentifycode != "")
        {
            return true;
        }

        //获取验证码
        string tbIndentifycode = GetIdentify(IndentifyId);

        if (tbIndentifycode.Trim() == "")
        {
            throw new Exception("验证码已失效，请重新获取！");
        }

        if (tbIndentifycode != Indentifycode)
        {
            throw new Exception("验证码输入不正确！");
        }

        return true;
    }



    /// <summary>
    /// 收银vip短信验证
    /// </summary>
    /// <param name="context"></param>
    private void Chk_IdentifyCode(HttpContext context)
    {
        AjaxResult ar = new AjaxResult(1);
        try
        {
            string vipcode = context.Request["vipcode"].ToString();
            string identifycode = context.Request["identifycode"].ToString();
            string method = context.Request["method"].ToString();
            string MyCook = "V" + vipcode;
            if (ChkIdentify(MyCook, identifycode))
            {
                DelIdentify(MyCook);
            }
        }
        catch (Exception ex)
        {
            ar.msg = ex.Message;
            ar.success = 0;
        }
        context.Response.Write(JsonConvert.SerializeObject(ar));
    }

    /// <summary>
    /// 发送验证码
    /// </summary>
    /// <param name="context"></param>
    private void SendMobileMsg(HttpContext context)
    {
        AjaxResult ar = new AjaxResult(1);
        try
        {
            bllmsg m = new bllmsg();
            string mobtel = context.Request["mobtel"].ToString();
            string vipcode = context.Request["vipcode"].ToString();
            if (mobtel.Length != 11) throw new Exception("手机号码传入错误！");
            string MyCook = "V" + vipcode;
            DelIdentify(MyCook);
            string randcode = RandomCode();

            string method=context.Request["method"].ToString() ;

            string msg="";
            if (method == "vipbirth")
            {
                msg = m.GetMsgTemplate("38020204");
            }
            else {
                msg = m.GetMsgTemplate("38020203");
            }
            
            msg = msg.Replace("$IdentifyCode", randcode);

            msg = m.ReplVar(msg, vipcode);
            
            m.InsertMsg(msg, mobtel);
            InsertIdentify("V" + vipcode, randcode);
        }
        catch (Exception ex)
        {
            ar.msg = ex.Message;
            ar.success = 0;
        }
        context.Response.Write(JsonConvert.SerializeObject(ar));
    }

    /// <summary>
    /// 获取手机号码
    /// </summary>
    /// <param name="context"></param>
    private void Set_IdentifyCode(HttpContext context)
    {
        AjaxResult ar = new AjaxResult(1);
        try
        {
            string vipcode = context.Request["vipcode"].ToString();
            string method = context.Request["method"].ToString();

            string mobtel = get_vip_mobile(vipcode);
            ar.msg = mobtel;
        }
        catch (Exception ex)
        {
            ar.msg = ex.Message;
            ar.success = 0;
        }
        context.Response.Write(JsonConvert.SerializeObject(ar));
    }


    /// <summary>
    ///生成动态密码
    /// </summary>
    /// <returns></returns>
    private string RandomCode()
    {
        Random rand = new Random();
        string randcode = rand.Next(0, 999999).ToString();
        if (randcode.Length != 6)
        {
            randcode = rand.Next(0, 999999).ToString();
            if (randcode.Length != 6)
                throw new Exception("获取验证码失败，请重试！");
        }
        return randcode;
    }

    /// <summary>
    /// 获取通用验证
    /// </summary>
    /// <returns></returns>
    private string get_universal_verifi()
    {
        string sql = "SELECT ISNULL(sysdefvalue,'') sysdefvalue FROM dbo.sys_system WHERE systemid=@systemid ";
        SqlParameter[] sp = new SqlParameter[] { 
            new SqlParameter("@systemid",2203)
        };
        DataTable dt = app_cn.getTable(sql, sp, CommandType.Text);

        if (dt.Rows.Count == 0)
            return "";
        else
            return dt.Rows[0]["sysdefvalue"].ToString();
    }



    /// <summary>
    /// 获取手机号码
    /// </summary>
    /// <param name="vipcode"></param>
    /// <returns></returns>
    private string get_vip_mobile(string vipcode)
    {
        string sql = @"SELECT ISNULL(mobtel,'') mobtel FROM dbo.vip_user WHERE vipcode=@vipcode ";
        SqlParameter[] sp = new SqlParameter[] { 
            new SqlParameter("@vipcode",vipcode)
        };
        DataTable dt = app_cn.getTable(sql, sp, CommandType.Text);
        if (dt.Rows.Count == 0) throw new Exception("vip卡" + vipcode + "不存在!");
        string mobtel = dt.Rows[0]["mobtel"].ToString(); ;
        if (mobtel.Length != 11) throw new Exception("vip卡" + vipcode + "手机号码不正确!");
        return mobtel;
    }

    /// <summary>
    /// 获取手机号码
    /// </summary>
    /// <param name="vipcode"></param>
    /// <returns></returns>
    private void GetVipMobile(HttpContext context)
    {
        AjaxResult ar = new AjaxResult(1);
        try
        {
            string vipcode = context.Request["vipcode"].ToString();
            string sql = @"SELECT ISNULL(mobtel,'') mobtel FROM dbo.vip_user WHERE vipcode=@vipcode ";
            SqlParameter[] sp = new SqlParameter[] { 
            new SqlParameter("@vipcode",vipcode)
        };
            DataTable dt = app_cn.getTable(sql, sp, CommandType.Text);
            if (dt.Rows.Count == 0) throw new Exception("vip卡" + vipcode + "不存在!");
            string mobtel = dt.Rows[0]["mobtel"].ToString(); ;
            if (mobtel.Length != 11) throw new Exception("vip卡" + vipcode + "手机号码不正确,请修改VIP资料!");
            ar.msg = mobtel;
        }
        catch (Exception ex)
        {
            ar.msg = ex.Message;
            ar.success = -1;
        }
        context.Response.Write(JsonConvert.SerializeObject(ar));
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
  

  

}