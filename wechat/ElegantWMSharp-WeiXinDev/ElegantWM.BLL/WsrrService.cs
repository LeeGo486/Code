using ElegantWM.DAL;
using ElegantWM.IBLL;
using ElegantWM.IDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ElegantWM.Tools;
using ElegantWM.DTO;

namespace ElegantWM.BLL
{
    public class WsrrService : IWsrrService
    {
        private IWsrrDAL dal = new WsrrDAL();

        #region 短信验证码通用调用的WSRR
        /// <summary>
        /// 发送短信验证码
        /// </summary>
        /// <param name="tel"></param>
        /// <returns></returns>
        public DataTable SendSmsAnyTelCommonInterface(string phone, string system, string com)
        {
            DataSet ds = dal.ExcuteWsrr("5a7b9005-f3a3-4543-b7b2-3adb705220d2", @"<XML><ROOT><OPTYPE>GetAuthCode</OPTYPE><LIST><ROW>
                 <AuthType>signup</AuthType>
                 <Phone>" + phone + @"</Phone>
                 <System>" + system + @"</System>
                 <Com>" + com + @"</Com>
                 </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }
        /// <summary>
        /// 短信验证码通用
        /// </summary>
        /// <param name="VipTel"></param>
        /// <param name="AuthCode"></param>
        /// <returns></returns>
        public DataTable CheckAuthCodeCommonInterface(string phone, string AuthCode)
        {
            DataSet ds = dal.ExcuteWsrr("5a7b9005-f3a3-4543-b7b2-3adb705220d22", @"<XML><ROOT><OPTYPE>CheckAuthCode</OPTYPE><LIST><ROW>
                <Phone>" + phone + @"</Phone>
                <AuthCode>" + AuthCode + @"</AuthCode>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        #endregion

        #region MDM省市店铺获取通用WSRR
        /// <summary>
        /// 省
        /// </summary>
        /// <param name="tel"></param>
        /// <returns></returns>
        public DataTable GetProvinceCommonInterface()
        {
            DataSet ds = dal.ExcuteWsrr("d970a005-34a1-49ea-8ef4-ae5f7dee5d79", @"<XML><ROOT><OPTYPE>GetProvince</OPTYPE><LIST><ROW>
                 </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 市
        /// </summary>
        /// <param name="tel"></param>
        /// <returns></returns>
        public DataTable GetCiteCommonInterface(string Where)
        {
            DataSet ds = dal.ExcuteWsrr("d970a005-34a1-49ea-8ef4-ae5f7dee5d79", @"<XML><ROOT><OPTYPE>GetCity</OPTYPE><LIST><ROW>
                 <Where>" + Where + @"</Where>
                 </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }
        /// <summary>
        /// 区
        /// </summary>
        /// <param name="tel"></param>
        /// <returns></returns>
        public DataTable GetCountyCommonInterface(string Where)
        {
            DataSet ds = dal.ExcuteWsrr("d970a005-34a1-49ea-8ef4-ae5f7dee5d79", @"<XML><ROOT><OPTYPE>GetCounty</OPTYPE><LIST><ROW>
                 <Where>" + Where + @"</Where>
                 </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }
        /// <summary>
        /// 店铺
        /// </summary>
        /// <param name="tel"></param>
        /// <returns></returns>
        public DataTable GetMDMDepot(string Where)
        {
            DataSet ds = dal.ExcuteWsrr("d970a005-34a1-49ea-8ef4-ae5f7dee5d79", @"<XML><ROOT><OPTYPE>GetDepotInfo</OPTYPE><LIST><ROW>
                 <Where>" + Where + @"</Where>
                 </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        #endregion

        #region VIP通用接口（CRUD）

        /// <summary>
        /// VIP查询（积分等）消费记录
        /// </summary>
        /// <param name="tel"></param>
        /// <returns></returns>
        public DataTable GetCustomerInfoCommonInterface(string pstrType, string pstrCOM, string pstrWXID, string pstrCODE, string pstrPHONE, string pstrVIPCODE, string pstrVIPID)
        {
            DataSet ds = dal.ExcuteWsrr("2e1b3b86-ad94-496e-a795-b895a542a51f", @"<XML><ROOT><OPTYPE>GetCustomerInfo</OPTYPE><LIST><ROW>
                        <Type>" + pstrType + @"</Type>  
                        <COM>" + pstrCOM + @"</COM>  
                        <WXID>" + pstrWXID + @"</WXID>                 
                        <CODE>" + pstrCODE + @"</CODE>                 
                        <PHONE>" + pstrPHONE + @"</PHONE>                 
                        <VIPCODE>" + pstrVIPCODE + @"</VIPCODE>                 
                        <VIPID>" + pstrVIPID + @"</VIPID>                 
                        </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// VIP新增
        /// Type 1 微信 2 官网
        /// </summary>
        /// <param name="tel"></param>
        /// <returns></returns>
        public DataTable AddCustomerInfoCommonInterface(string pstrType, string pstrCOM, string pstrNAME, string pstrPHONE, string pstrWXID, string pstrCODE, string pstrSEX
            , string pstrEMAIL, string pstrBIRTHDAY, string pstrPROVINCE, string pstrCITY, string pstrCOUNTY, string pstrOCCUPATION, string pstrWXNICK, string pstrVIPADD)
        {
            DataSet ds = dal.ExcuteWsrr("2e1b3b86-ad94-496e-a795-b895a542a51f", @"<XML><ROOT><OPTYPE>AddCustomerInfo</OPTYPE><LIST><ROW>
                        <Type>" + pstrType + @"</Type>  
                        <COM>" + pstrCOM + @"</COM>  
                        <NAME>" + pstrNAME + @"</NAME>                 
                        <PHONE>" + pstrPHONE + @"</PHONE>                 
                        <WXID>" + pstrWXID + @"</WXID>                 
                        <CODE>" + pstrCODE + @"</CODE>                 
                        <SEX>" + pstrSEX + @"</SEX>                 
                        <EMAIL>" + pstrEMAIL + @"</EMAIL>                 
                        <BIRTHDAY>" + pstrBIRTHDAY + @"</BIRTHDAY>                 
                        <PROVINCE>" + pstrPROVINCE + @"</PROVINCE>                 
                        <CITY>" + pstrCITY + @"</CITY>                 
                        <COUNTY>" + pstrCOUNTY + @"</COUNTY>                 
                        <OCCUPATION>" + pstrOCCUPATION + @"</OCCUPATION>                 
                        <WXNICK>" + pstrWXNICK + @"</WXNICK>                 
                        <VIPADD>" + pstrVIPADD + @"</VIPADD>                 
                        </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// VIP修改
        /// </summary>
        /// Type 1 微信 2 官网
        /// <param name="tel"></param>
        /// <returns></returns>
        public DataTable UpdateCustomerInfoCommonInterface(string pstrType, string pstrCOM, string pstrNAME, string pstrPHONE, string pstrWXID, string pstrCODE, string pstrSEX, string pstrEMAIL, string pstrBIRTHDAY, string pstrPROVINCE, string pstrCITY, string pstrCOUNTY, string pstrOCCUPATION, string pstrWXNICK, string pstrVIPADD)
        {
            DataSet ds = dal.ExcuteWsrr("2e1b3b86-ad94-496e-a795-b895a542a51f", @"<XML><ROOT><OPTYPE>UpdateCustomerInfo</OPTYPE><LIST><ROW>
                        <Type>" + pstrType + @"</Type>  
                        <COM>" + pstrCOM + @"</COM>  
                        <NAME>" + pstrNAME + @"</NAME>                 
                        <PHONE>" + pstrPHONE + @"</PHONE>                 
                        <WXID>" + pstrWXID + @"</WXID>                 
                        <CODE>" + pstrCODE + @"</CODE>                 
                        <SEX>" + pstrSEX + @"</SEX>                 
                        <EMAIL>" + pstrEMAIL + @"</EMAIL>                 
                        <BIRTHDAY>" + pstrBIRTHDAY + @"</BIRTHDAY>                 
                        <PROVINCE>" + pstrPROVINCE + @"</PROVINCE>                 
                        <CITY>" + pstrCITY + @"</CITY>                 
                        <COUNTY>" + pstrCOUNTY + @"</COUNTY>                 
                        <OCCUPATION>" + pstrOCCUPATION + @"</OCCUPATION>                 
                        <WXNICK>" + pstrWXNICK + @"</WXNICK>  
                        <VIPADD>" + pstrVIPADD + @"</VIPADD>                              
                        </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// VIP消费记录
        /// </summary>
        /// <param name="pstrCOM">EP GL DL GL NP JL</param>
        /// <param name="pstrConditionID">1	WeiXinid	2	OnlineVipid	3	Mobtel	4	Vipcode	5	vipid</param>
        /// <param name="pstrConditionValue">1	WeiXinid	2	OnlineVipid	3	Mobtel	4	Vipcode	5	vipid</param>
        /// <returns></returns>
        public DataTable GetCustomerRetailInfoCommonInterface(string pstrCOM, string pstrConditionID, string pstrConditionValue)
        {
            DataSet ds = dal.ExcuteWsrr("2e1b3b86-ad94-496e-a795-b895a542a51f", @"<XML><ROOT><OPTYPE>GetCustomerRetail</OPTYPE><LIST><ROW>
                        <COM>" + pstrCOM + @"</COM>  
                        <ConditionID>" + pstrConditionID + @"</ConditionID>                 
                        <ConditionValue>" + pstrConditionValue + @"</ConditionValue>                 
                        </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }
        #endregion

        #region 券通用接口（券查询新增积分兑换送券）

        /// <summary>
        /// 券查询
        /// </summary>
        /// <param name="pstrCOM">EP GL DL GL NP JL</param>
        /// <param name="pstrConditionID">1	WeiXinid	2	OnlineVipid	3	Mobtel	4	Vipcode	5	vipid</param>
        /// <param name="pstrConditionValue">1	WeiXinid	2	OnlineVipid	3	Mobtel	4	Vipcode	5	vipid</param>
        /// <returns></returns>
        public DataTable GetCustomerTicketInfoCommonInterface(string pstrCOM, string pstrConditionID, string pstrConditionValue)
        {
            DataSet ds = dal.ExcuteWsrr("b1cd458d-43fc-440f-a9b8-6493b4a8fe1a", @"<XML><ROOT><OPTYPE>GetCustomerTicketInfo</OPTYPE><LIST><ROW>
                        <COM>" + pstrCOM + @"</COM>  
                        <ConditionID>" + pstrConditionID + @"</ConditionID>                 
                        <ConditionValue>" + pstrConditionValue + @"</ConditionValue>                 
                        </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 送券
        /// </summary>
        /// <param name="pstrCOM">EP GL DL GL NP JL</param>
        /// <param name="pstrConditionID">1	WeiXinid	2	OnlineVipid	3	Mobtel	4	Vipcode	5	vipid</param>
        /// <param name="pstrConditionValue">1	WeiXinid	2	OnlineVipid	3	Mobtel	4	Vipcode	5	vipid</param>
        /// <param name="pstrEffectiveWay">生效方式 0 有效天数;1 截止日期;2 日期段	INT	PS:日期段方式 结束日期那天券就失效</param>
        /// <param name="pstrType">券类型 0 抵值券; 1 现金券; 2 打折券	INT</param>
        /// <param name="pstrTicketName">券名称显示在前台的名称啦</param>
        /// <param name="pstrTicketTypeNumber">券类型编号需在DRP系统存在，并且使用每个公司自己的 </param>
        /// <param name="pstrParType">面值类型1 代表面值88块钱</param>
        /// <param name="pstrDay">EffectiveWay 为0 Day必须传</param>
        /// <param name="pstrUpToTime">为1 UpToTime必须传</param>
        /// <param name="pstrBeginDate">为2 BeginDate EndDate必须传</param>
        /// <param name="pstrEndDate">为2 BeginDate EndDate必须传</param>
        /// <returns></returns>
        public DataTable AddCustomerTicketInfoCommonInterface(string pstrCOM, string pstrConditionID, string pstrConditionValue, string pstrEffectiveWay,
                                                              string pstrType, string pstrTicketName, string pstrTicketTypeNumber, string pstrParType,
                                                              string pstrDay, string pstrUpToTime, string pstrBeginDate, string pstrEndDate)
        {
            DataSet ds = dal.ExcuteWsrr("b1cd458d-43fc-440f-a9b8-6493b4a8fe1a", @"<XML><ROOT><OPTYPE>AddTicket</OPTYPE><LIST><ROW>
                        <COM>" + pstrCOM + @"</COM>
                        <ConditionID>" + pstrConditionID + @"</ConditionID>
                        <ConditionValue>" + pstrConditionValue + @"</ConditionValue> 
                        <EffectiveWay>" + pstrEffectiveWay + @"</EffectiveWay> 
                        <Type>" + pstrType + @"</Type>
                        <TicketName>" + pstrTicketName + @"</TicketName> 
                        <TicketTypeNumber>" + pstrTicketTypeNumber + @"</TicketTypeNumber>
                        <ParType>" + pstrParType + @"</ParType>
                        <Day>" + pstrDay + @"</Day>
                        <UpToTime>" + pstrUpToTime + @"</UpToTime>
                        <BeginDate>" + pstrBeginDate + @"</BeginDate> 
                        <EndDate>" + pstrEndDate + @"</EndDate>  
                        </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 送券
        /// </summary>
        /// <param name="pstrCOM">EP GL DL GL NP JL</param>
        /// <param name="pstrConditionID">1	WeiXinid	2	OnlineVipid	3	Mobtel	4	Vipcode	5	vipid</param>
        /// <param name="pstrConditionValue">1	WeiXinid	2	OnlineVipid	3	Mobtel	4	Vipcode	5	vipid</param>
        /// <param name="pstrEffectiveWay">生效方式 0 有效天数;1 截止日期;2 日期段	INT	PS:日期段方式 结束日期那天券就失效</param>
        /// <param name="pstrType">券类型 0 抵值券; 1 现金券; 2 打折券	INT</param>
        /// <param name="pstrTicketName">券名称显示在前台的名称啦</param>
        /// <param name="pstrTicketTypeNumber">券类型编号需在DRP系统存在，并且使用每个公司自己的 </param>
        /// <param name="pstrDeductionIntegralType">扣减积分 1代表5000分 2代表10000分 </param>
        /// <param name="pstrParType">面值类型1 代表面值88块钱</param>
        /// <param name="pstrDay">EffectiveWay 为0 Day必须传</param>
        /// <param name="pstrUpToTime">为1 UpToTime必须传</param>
        /// <param name="pstrBeginDate">为2 BeginDate EndDate必须传</param>
        /// <param name="pstrEndDate">为2 BeginDate EndDate必须传</param>
        /// <returns></returns>
        public DataTable AddTicketByExchangeIntegralCommonInterface(string pstrCOM, string pstrConditionID, string pstrConditionValue, string pstrEffectiveWay,
                                                              string pstrType, string pstrTicketName, string pstrTicketTypeNumber, string pstrDeductionIntegralType,
                                                              string pstrParType, string pstrDay, string pstrUpToTime, string pstrBeginDate, string pstrEndDate)
        {
            DataSet ds = dal.ExcuteWsrr("b1cd458d-43fc-440f-a9b8-6493b4a8fe1a", @"<XML><ROOT><OPTYPE>AddTicketByExchangeIntegral</OPTYPE><LIST><ROW>
                        <COM>" + pstrCOM + @"</COM>  
                        <ConditionID>" + pstrConditionID + @"</ConditionID>
                        <ConditionValue>" + pstrConditionValue + @"</ConditionValue> 
                        <EffectiveWay>" + pstrEffectiveWay + @"</EffectiveWay> 
                        <Type>" + pstrType + @"</Type>
                        <TicketName>" + pstrTicketName + @"</TicketName> 
                        <TicketTypeNumber>" + pstrTicketTypeNumber + @"</TicketTypeNumber>
                        <DeductionIntegralType>" + pstrDeductionIntegralType + @"</DeductionIntegralType>
                        <ParType>" + pstrParType + @"</ParType>
                        <Day>" + pstrDay + @"</Day>
                        <UpToTime>" + pstrUpToTime + @"</UpToTime>
                        <BeginDate>" + pstrBeginDate + @"</BeginDate> 
                        <EndDate>" + pstrEndDate + @"</EndDate>  
                        </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        #endregion

        #region VIP积分

        /// <summary>
        ///  VIP积分
        /// </summary>
        /// <param name="pstrCOM">EP GL DL GL NP JL</param>
        /// <param name="pstrConditionID">1	WeiXinid	2	OnlineVipid	3	Mobtel	4	Vipcode	5	vipid</param>
        /// <param name="pstrConditionValue">1	WeiXinid	2	OnlineVipid	3	Mobtel	4	Vipcode	5	vipid</param>
        /// <param name="pstrType">Add 增加积分	；Decrease 减少积分	</param>
        /// <param name="pstrIntegral">积分兑换券 必须传入，且不允许小于等于零	</param>
        /// <returns></returns>
        public DataTable CustomerJFchangeCommonInterface(string pstrCOM, string pstrConditionID, string pstrConditionValue, string pstrType, string pstrIntegral, string pstrRemarks)
        {
            DataSet ds = dal.ExcuteWsrr("3e556821-74be-4180-840f-892975977aec", @"<XML><ROOT><OPTYPE>CustomerJFchange</OPTYPE><LIST><ROW>
                        <COM>" + pstrCOM + @"</COM>  
                        <ConditionID>" + pstrConditionID + @"</ConditionID>                 
                        <ConditionValue>" + pstrConditionValue + @"</ConditionValue>                 
                        <Type>" + pstrType + @"</Type>                 
                        <Integral>" + pstrIntegral + @"</Integral>                 
                        <Remarks>" + pstrRemarks + @"</Remarks>                 
                        </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }
        #endregion

        #region 3S调用的WSRR
        /// <summary>
        /// 根据手机获取vip名称和消费金额
        /// </summary>
        /// <param name="tel"></param>
        /// <returns></returns>
        public string GetVipInfo(string tel)
        {
            DataSet ds = dal.GetData("f783dfa4-a987-44b6-a1a8-9da100f6d42a", "【操作类型,GET】【CONO,HYFG】【DIVI,D01】【项目,3S】【实体,tc_account】【手机号码," + tel.Replace("'", "").Replace("】", "").Replace("【", "") + "】");
            DataTable dt = ds.Tables[1];
            return JsonHelper.ToJson(dt);
        }

        /// <summary>
        /// 校验产品是否存在
        /// </summary>
        /// <param name="skc"></param>
        /// <returns></returns>
        public DataTable CheckSKC(string skc)
        {
            DataSet ds = dal.GetData("f783dfa4-a987-44b6-a1a8-9da100f6d42a", "【操作类型,GET】【CONO,HYFG】【DIVI,D01】【项目,3S】【实体,J_CLOTHING】【SKU," + skc.Replace("'", "").Replace("】", "").Replace("【", "") + "】");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 根据当前登录账号获取店铺信息
        /// </summary>
        /// <param name="depotid"></param>
        /// <returns></returns>
        public DataTable GetUserDeptInfo(string depotid)
        {
            DataSet ds = dal.GetData("f783dfa4-a987-44b6-a1a8-9da100f6d42a", "【操作类型,GET】【CONO,HYFG】【DIVI,D01】【项目,3S】【实体,J_DEPOT】【店铺编号," + depotid.Replace("'", "").Replace("】", "").Replace("【", "") + "】");
            DataTable dt = ds.Tables[1];
            return dt;
        }


        /// <summary>
        /// 发送短信验证码
        /// </summary>
        /// <param name="tel"></param>
        /// <returns></returns>
        public DataTable SendSMS(string tel)
        {
            DataSet ds = dal.ExcuteWsrr("33c7b95c-790c-4841-a738-b7994fb0f932", "<XML><ROOT><OPTYPE>GetAuthCode</OPTYPE><LIST><ROW><AuthType>signup</AuthType><Phone>" + tel + "</Phone></ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// S3用户注册
        /// </summary>
        /// <param name="tel"></param>
        /// <param name="oid"></param>
        /// <param name="pwd"></param>
        /// <param name="code"></param>
        /// <returns></returns>
        public DataTable Register3S(string tel, string oid, string pwd, string code)
        {
            DataSet ds = dal.ExcuteWsrr("711bb78a-4190-4568-809b-45c94dc54fb3", "<XML><ROOT><OPTYPE>SignUp</OPTYPE><LIST><ROW><LoginUser>" + tel + "</LoginUser><PassWord>" + pwd + "</PassWord><AccreditationType>3SWeChat</AccreditationType><BindUser>" + oid + "</BindUser><BindPassWord></BindPassWord><AuthCode>" + code + "</AuthCode></ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }


        /// <summary>
        /// wsrr判断是否离职，绑定，获取店铺名称，编号等基本信息
        /// </summary>
        /// <param name="oid"></param>
        /// <returns></returns>
        public DataTable CheckS3UserBind(string oid)
        {
            string xml = @"<XML><ROOT><OPTYPE>GetEmployeeInfoBy3SWeChat</OPTYPE><LIST><ROW><S3WeChatID>{0}</S3WeChatID></ROW></LIST></ROOT></XML>";
            xml = string.Format(xml, oid);
            DataSet ds = dal.ExcuteWsrr("fb82083d-23f3-432d-a612-676cad04c01f", xml);
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 绑定EHR和POS
        /// </summary>
        /// <param name="tel"></param>
        /// <param name="ehrName"></param>
        /// <param name="idCode"></param>
        /// <param name="posCode"></param>
        /// <returns></returns>
        public DataTable BindEhrDrp(string tel, string ehrName, string idCode, string posCode, bool isRePos = false)
        {
            if (!isRePos)
            {
                string ehrXML = @"<XML><ROOT><OPTYPE>Bind</OPTYPE><LIST>
                                <ROW>
	                                <LoginUser>{0}</LoginUser>
	                                <PassWord></PassWord>
	                                <AccreditationType>EHRCARD</AccreditationType>
	                                <BindUser>{1}</BindUser>
	                                <BindPassWord>{2}</BindPassWord>
                                </ROW>
                                </LIST></ROOT></XML>";

                DataSet ds = dal.ExcuteWsrr("711bb78a-4190-4568-809b-45c94dc54fb3", string.Format(ehrXML, tel, ehrName, idCode));
                DataTable dt = ds.Tables[1];
                if (dt.Rows[0][0].ToString().ToLower() != "true")
                {
                    throw new Exception(dt.Rows[0][1].ToString());
                }
            }
            string posXML = @"<XML><ROOT><OPTYPE>Bind</OPTYPE><LIST>
                                <ROW>
	                                <LoginUser>{0}</LoginUser>
	                                <PassWord></PassWord>
	                                <AccreditationType>POSEmployee</AccreditationType>
	                                <BindUser>{1}</BindUser>
	                                <BindPassWord></BindPassWord>
                                </ROW>
                                </LIST></ROOT></XML>";
            DataSet ds2 = dal.ExcuteWsrr("711bb78a-4190-4568-809b-45c94dc54fb3", string.Format(posXML, tel, posCode));
            DataTable dt2 = ds2.Tables[1];
            return dt2;
        }

        #endregion

        #region Npaia调用的WSRR
        /// <summary>
        /// NPaia手机验证码验证
        /// </summary>
        /// <param name="VipTel"></param>
        /// <param name="AuthCode"></param>
        /// <returns></returns>
        public DataTable CheckAuthCode(string VipTel, string AuthCode)
        {
            DataSet ds = dal.ExcuteWsrr("9a7f4f2b-e6b1-4840-b92d-ccf06120c8f2", @"<XML><ROOT><OPTYPE>CheckAuthCode</OPTYPE><LIST><ROW>
                <Phone>" + VipTel + @"</Phone>
                <AuthCode>" + AuthCode + @"</AuthCode>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// NPaia发送短信验证码
        /// </summary>
        /// <param name="tel"></param>
        /// <returns></returns>
        public DataTable SendSmsAnyTel(string tel)
        {
            DataSet ds = dal.ExcuteWsrr("9a7f4f2b-e6b1-4840-b92d-ccf06120c8f2", @"<XML><ROOT><OPTYPE>GetAuthCode</OPTYPE><LIST><ROW>
                 <AuthType>signup</AuthType><Phone>" + tel + @"</Phone>
                 </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// NPaia雅根据当前登录手机号码获取VIP积分和判断是否存在会员
        /// </summary>
        /// <param name="viptel"></param>
        /// <returns></returns>
        public DataTable GetUserCentumInfo(string viptel)
        {
            DataSet ds = dal.ExcuteWsrr("95cc444d-8376-4305-8385-b7b0e00309cb", @"<XML><ROOT><OPTYPE>GETVIPINTEGRAL</OPTYPE><LIST><ROW>
                      <Phone>" + viptel + @"</Phone>
                      </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 新增XYdrp会员信息和DRP VIP信息
        /// </summary>
        /// <param name="viptel"></param>
        /// <returns></returns>
        public DataTable VipUserForC3(string VipTel, string VipSex, string VipName)
        {
            DataSet ds = dal.ExcuteWsrr("95cc444d-8376-4305-8385-b7b0e00309cb", @"<XML><ROOT><OPTYPE>EDITVIPPersonnel</OPTYPE><LIST>
                        <ROW><Phone>" + VipTel + @"</Phone>
                        <vipname>" + VipName + @"</vipname>
                        <vipsex>" + VipSex + @"</vipsex>
                        </ROW> </LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 查询款式信息
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable GetStyleInfo(string where)
        {
            DataSet ds = dal.ExcuteWsrr("df8dc27e-703a-4f79-ac01-f9efe6dfad1f", @"<XML><ROOT><OPTYPE>GetStyleInfo</OPTYPE></ROOT></XML>
                                        <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 查询款式SKU信息
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable GetStyleSKU(string where)
        {
            DataSet ds = dal.ExcuteWsrr("df8dc27e-703a-4f79-ac01-f9efe6dfad1f", @"<XML><ROOT><OPTYPE>GetStyleSKU</OPTYPE></ROOT></XML>
                                        <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 添加购物车信息
        /// </summary>
        /// <param name="oid"></param>
        /// <returns></returns>
        public DataTable AddShoppingCart(string oid, string skuid, string number, string price, string sellprice, string name)
        {
            DataSet ds = dal.ExcuteWsrr("1284d288-da3f-4ce0-893f-8d96cf2ec2cd", @"<XML><ROOT><OPTYPE>AddShoppingCart</OPTYPE>
                                        <LIST><ROW><WeiXinID>" + oid + "</WeiXinID><STL2_ID>" + skuid + "</STL2_ID><Number>" + number + "</Number><Price>" + price + "</Price><SellPrice>" + sellprice + "</SellPrice><RgUser>" + name + "</RgUser></ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 查询购物车信息
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable GetShoppingCart(string where)
        {
            DataSet ds = dal.ExcuteWsrr("1284d288-da3f-4ce0-893f-8d96cf2ec2cd", @"<XML><ROOT><OPTYPE>GetShoppingCart</OPTYPE></ROOT></XML>
                                        <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 删除购物车信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public DataTable DelShoppingCart(string id)
        {
            DataSet ds = dal.ExcuteWsrr("1284d288-da3f-4ce0-893f-8d96cf2ec2cd", @"<XML><ROOT><OPTYPE>DelShoppingCart</OPTYPE><LIST><ROW><ID>" + id + "</ID></ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 添加订单信息
        /// </summary>
        /// <param name="oid"></param>
        /// <param name="head"></param>
        /// <returns></returns>
        public DataTable AddOrder(string oid, OrderHeadDto head)
        {
            string s = "<XML><ROOT><OPTYPE>AddCustomerOrder</OPTYPE><LIST><ROW><WeiXinID>" + oid + "</WeiXinID><DeliveryDate>" + head.Deliverydate + "</DeliveryDate><Amount>" + head.Amount + "</Amount><DEPT_ID>" + head.Depotid + "</DEPT_ID><Desp>" + head.Desp + "</Desp><RgUser>" + head.RgUser + "</RgUser><Phone>" + head.Tel + "</Phone></ROW></LIST>";

            s = s + "<LIST>";
            for (int i = 0; i < head.Detail.Count; i++)
            {
                s = s + "<ROW><ID>" + head.Detail[i].id + "</ID><STL2_ID>" + head.Detail[i].Stlid + "</STL2_ID><DeliveryDate>" + head.Detail[i].Deliverydate + "</DeliveryDate><Number>" + head.Detail[i].Number + "</Number><Price>" + head.Detail[i].Price + "</Price><SellPrice>" + head.Detail[i].SellPrice + "</SellPrice><Amount>" + head.Detail[i].Amount + "</Amount></ROW>";
            }
            s = s + "</LIST>";
            s = s + "</ROOT></XML>";

            DataSet ds = dal.ExcuteWsrr("150fb7e6-111a-4752-a7c5-546ad9d169a4", s);
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 根据主题查询款式SKU信息
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable GetStyleSKUByTheme(string where)
        {
            DataSet ds = dal.ExcuteWsrr("eb226fa0-fdb3-4ce5-8e88-90d8bc73cf79", @"<XML><ROOT><OPTYPE>GetStyleByTheme</OPTYPE><List><Rows></Rows></List></ROOT></XML>
                                        <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 查询订单信息
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable GetOrder(string where)
        {
            DataSet ds = dal.ExcuteWsrr("150fb7e6-111a-4752-a7c5-546ad9d169a4", @"<XML><ROOT><OPTYPE>GetCustomerOrder</OPTYPE></ROOT></XML>
                                        <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 查询省份信息
        /// </summary>
        /// <returns></returns>
        public DataTable GetProvince()
        {
            DataSet ds = dal.ExcuteWsrr("8501f40e-134f-4f6d-b604-b37705c986d1", @"<XML><ROOT><OPTYPE>GetDepot</OPTYPE></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 查询市信息
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable GetCity(string where)
        {
            DataSet ds = dal.ExcuteWsrr("8501f40e-134f-4f6d-b604-b37705c986d1", @"<XML><ROOT><OPTYPE>GetDepot</OPTYPE></ROOT></XML>
                                        <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 查询市信息
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable GetDepot(string where)
        {
            DataSet ds = dal.ExcuteWsrr("8501f40e-134f-4f6d-b604-b37705c986d1", @"<XML><ROOT><OPTYPE>GetDepot</OPTYPE></ROOT></XML>
                                        <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }
        #endregion

        #region 雅斓微站WSRR

        /// <summary>
        /// 查询款式信息
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable GLGetStyleInfo(string where)
        {
            DataSet ds = dal.ExcuteWsrr("A844D50D-9B2B-4ADA-81AC-070B1BD474AC", @"<XML><ROOT><OPTYPE>GetStyleInfo</OPTYPE></ROOT></XML>
                                        <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 查询款式SKU信息
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable GLGetStyleSKU(string where)
        {
            DataSet ds = dal.ExcuteWsrr("A844D50D-9B2B-4ADA-81AC-070B1BD474AC", @"<XML><ROOT><OPTYPE>GetStyleSKU</OPTYPE></ROOT></XML>
                                        <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 添加购物车信息//等等没有做
        /// </summary>
        /// <param name="oid"></param>
        /// <returns></returns>
        public DataTable GLAddShoppingCart(string oid, string skuid, string number, string price, string sellprice, string name)
        {
            DataSet ds = dal.ExcuteWsrr("", @"<XML><ROOT><OPTYPE>AddShoppingCart</OPTYPE>
                                        <LIST><ROW><WeiXinID>" + oid + "</WeiXinID><STL2_ID>" + skuid + "</STL2_ID><Number>" + number + "</Number><Price>" + price + "</Price><SellPrice>" + sellprice + "</SellPrice><RgUser>" + name + "</RgUser></ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 查询购物车信息
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable GLGetShoppingCart(string where)
        {
            DataSet ds = dal.ExcuteWsrr("", @"<XML><ROOT><OPTYPE>GetShoppingCart</OPTYPE></ROOT></XML>
                                        <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 删除购物车信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public DataTable GLDelShoppingCart(string id)
        {
            DataSet ds = dal.ExcuteWsrr("", @"<XML><ROOT><OPTYPE>DelShoppingCart</OPTYPE><LIST><ROW><ID>" + id + "</ID></ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 添加订单信息
        /// </summary>
        /// <param name="oid"></param>
        /// <param name="head"></param>
        /// <returns></returns>
        public DataTable GLAddOrder(string oid, OrderHeadDto head)
        {
            string s = "<XML><ROOT><OPTYPE>AddCustomerOrder</OPTYPE><LIST><ROW><WeiXinID>" + oid + "</WeiXinID><DeliveryDate>" + head.Deliverydate + "</DeliveryDate><Amount>" + head.Amount + "</Amount><DEPT_ID>" + head.Depotid + "</DEPT_ID><Desp>" + head.Desp + "</Desp><RgUser>" + head.RgUser + "</RgUser><Phone>" + head.Tel + "</Phone></ROW></LIST>";

            s = s + "<LIST>";
            for (int i = 0; i < head.Detail.Count; i++)
            {
                s = s + "<ROW><ID>" + head.Detail[i].id + "</ID><STL2_ID>" + head.Detail[i].Stlid + "</STL2_ID><DeliveryDate>" + head.Detail[i].Deliverydate + "</DeliveryDate><Number>" + head.Detail[i].Number + "</Number><Price>" + head.Detail[i].Price + "</Price><SellPrice>" + head.Detail[i].SellPrice + "</SellPrice><Amount>" + head.Detail[i].Amount + "</Amount></ROW>";
            }
            s = s + "</LIST>";
            s = s + "</ROOT></XML>";

            DataSet ds = dal.ExcuteWsrr("02C175F2-5D31-4A4A-BD1C-D22BAE37FC63", s);
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 查询订单信息
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable GLGetOrder(string where)
        {
            DataSet ds = dal.ExcuteWsrr("02C175F2-5D31-4A4A-BD1C-D22BAE37FC63", @"<XML><ROOT><OPTYPE>GetCustomerOrder</OPTYPE></ROOT></XML>
                                        <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 查询主题weizuo 
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable GLGetTheme(string where)
        {
            DataSet ds = dal.ExcuteWsrr("1dd5ef1b-774e-49f7-934a-bf201b732b0a", @"<XML><ROOT><OPTYPE>GetTheme</OPTYPE><List><Rows></Rows></List></ROOT></XML>
                                        <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        #endregion

        #region 贝爱微站WSRR

        /// <summary>
        /// 查询款式信息
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable DLGetStyleInfo(string where)
        {
            DataSet ds = dal.ExcuteWsrr("A3E6429A-23EA-4D04-ABBD-0C1204A3E875", @"<XML><ROOT><OPTYPE>GetStyleInfo</OPTYPE></ROOT></XML>
                                        <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 查询款式SKU信息
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable DLGetStyleSKU(string where)
        {
            DataSet ds = dal.ExcuteWsrr("A3E6429A-23EA-4D04-ABBD-0C1204A3E875", @"<XML><ROOT><OPTYPE>GetStyleSKU</OPTYPE></ROOT></XML>
                                        <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 添加购物车信息//等等没有做
        /// </summary>
        /// <param name="oid"></param>
        /// <returns></returns>
        public DataTable DLAddShoppingCart(string oid, string skuid, string number, string price, string sellprice, string name)
        {
            DataSet ds = dal.ExcuteWsrr("359db2ae-11eb-4b59-ade6-ae4e49a4ab6b", @"<XML><ROOT><OPTYPE>AddShoppingCart</OPTYPE>
                                        <LIST><ROW><WeiXinID>" + oid + "</WeiXinID><STL2_ID>" + skuid + "</STL2_ID><Number>" + number + "</Number><Price>" + price + "</Price><SellPrice>" + sellprice + "</SellPrice><RgUser>" + name + "</RgUser></ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 查询购物车信息
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable DLGetShoppingCart(string where)
        {
            DataSet ds = dal.ExcuteWsrr("359db2ae-11eb-4b59-ade6-ae4e49a4ab6b", @"<XML><ROOT><OPTYPE>GetShoppingCart</OPTYPE></ROOT></XML>
                                        <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 删除购物车信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public DataTable DLDelShoppingCart(string id)
        {
            DataSet ds = dal.ExcuteWsrr("359db2ae-11eb-4b59-ade6-ae4e49a4ab6b", @"<XML><ROOT><OPTYPE>DelShoppingCart</OPTYPE><LIST><ROW><ID>" + id + "</ID></ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 添加订单信息
        /// </summary>
        /// <param name="oid"></param>
        /// <param name="head"></param>
        /// <returns></returns>
        public DataTable DLAddOrder(string oid, OrderHeadDto head)
        {
            string s = "<XML><ROOT><OPTYPE>AddCustomerOrder</OPTYPE><LIST><ROW><WeiXinID>" + oid + "</WeiXinID><DeliveryDate>" + head.Deliverydate + "</DeliveryDate><Amount>" + head.Amount + "</Amount><DEPT_ID>" + head.Depotid + "</DEPT_ID><Desp>" + head.Desp + "</Desp><RgUser>" + head.RgUser + "</RgUser><Phone>" + head.Tel + "</Phone></ROW></LIST>";

            s = s + "<LIST>";
            for (int i = 0; i < head.Detail.Count; i++)
            {
                s = s + "<ROW><ID>" + head.Detail[i].id + "</ID><STL2_ID>" + head.Detail[i].Stlid + "</STL2_ID><DeliveryDate>" + head.Detail[i].Deliverydate + "</DeliveryDate><Number>" + head.Detail[i].Number + "</Number><Price>" + head.Detail[i].Price + "</Price><SellPrice>" + head.Detail[i].SellPrice + "</SellPrice><Amount>" + head.Detail[i].Amount + "</Amount></ROW>";
            }
            s = s + "</LIST>";
            s = s + "</ROOT></XML>";

            DataSet ds = dal.ExcuteWsrr("4d66af4f-8153-4d4a-ae25-b10d99b2b84d", s);
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 查询订单信息
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable DLGetOrder(string where)
        {
            DataSet ds = dal.ExcuteWsrr("4d66af4f-8153-4d4a-ae25-b10d99b2b84d", @"<XML><ROOT><OPTYPE>GetCustomerOrder</OPTYPE></ROOT></XML>
                                        <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 删除订单信息
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable DLDelCustomerOrder(string id)
        {
            DataSet ds = dal.ExcuteWsrr("4d66af4f-8153-4d4a-ae25-b10d99b2b84d", @"<XML><ROOT><OPTYPE>DelCustomerOrder</OPTYPE><LIST><ROW><ID>" + id + "</ID></ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }



        /// <summary>
        /// 获取主题
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable DLGetTheme()
        {
            DataSet ds = dal.ExcuteWsrr("d788154f-7eea-49f4-812d-c93096da288f", @"<XML><ROOT><OPTYPE>GetTmemeWX</OPTYPE></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 获取公告
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable DLGetNotice()
        {
            DataSet ds = dal.ExcuteWsrr("d788154f-7eea-49f4-812d-c93096da288f", @"<XML><ROOT><OPTYPE>GetNotice</OPTYPE></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 获取特权
        /// </summary>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable DLGetVIPPrivilege()
        {
            DataSet ds = dal.ExcuteWsrr("d788154f-7eea-49f4-812d-c93096da288f", @"<XML><ROOT><OPTYPE>GetVIPPrivilege</OPTYPE></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        #endregion

        #region VexSSO手机号登录相关方法
        /// <summary>
        /// 注册并绑定AM
        /// </summary>
        /// <param name="tel">手机</param>
        /// <returns></returns>
        public DataTable VexSSORegAndBindAM(string tel, string pwd, string amuser, string ampwd, string code, bool reged)
        {
            if (reged) //已注册用户直接绑定
                return VexSSOBind(tel, pwd, "AM", amuser, ampwd);
            DataSet ds = dal.ExcuteWsrr("711bb78a-4190-4568-809b-45c94dc54fb3", "<XML><ROOT><OPTYPE>SignUp</OPTYPE><LIST><ROW><LoginUser>" + tel + "</LoginUser><PassWord>" + pwd + "</PassWord><AccreditationType>AM</AccreditationType><BindUser>" + amuser + "</BindUser><BindPassWord>" + ampwd + "</BindPassWord><AuthCode>" + code + "</AuthCode></ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }
        /// <summary>
        /// 用户绑定，系统用户和手机号绑定
        /// </summary>
        /// <param name="tel"></param>
        /// <param name="pwd"></param>
        /// <param name="type"></param>
        /// <param name="destuser"></param>
        /// <param name="destpwd"></param>
        /// <returns></returns>
        public DataTable VexSSOBind(string tel, string pwd, string type, string destuser, string destpwd)
        {
            DataSet ds = dal.ExcuteWsrr("711bb78a-4190-4568-809b-45c94dc54fb3", "<XML><ROOT><OPTYPE>Bind</OPTYPE><LIST><ROW><LoginUser>" + tel + "</LoginUser><PassWord>" + pwd + "</PassWord><AccreditationType>" + type + "</AccreditationType><BindUser>" + destuser + "</BindUser><BindPassWord>" + destpwd + "</BindPassWord></ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 获取验证码，用于找回密码
        /// </summary>
        /// <param name="tel"></param>
        /// <returns></returns>
        public DataTable VexSSOGetPwdCode(string tel)
        {
            DataSet ds = dal.ExcuteWsrr("33c7b95c-790c-4841-a738-b7994fb0f932", "<XML><ROOT><OPTYPE>GetAuthCode</OPTYPE><LIST><ROW><AuthType>getPassword</AuthType><Phone>" + tel + "</Phone></ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 将密码发送到手机
        /// </summary>
        /// <param name="tel"></param>
        /// <param name="code"></param>
        /// <returns></returns>
        public DataTable VexSSOSendPwd2Phone(string tel, string code)
        {
            DataSet ds = dal.ExcuteWsrr("711bb78a-4190-4568-809b-45c94dc54fb3", "<XML><ROOT><OPTYPE>GetPassWord</OPTYPE><LIST><ROW><LoginUser>" + tel + "</LoginUser><AuthCode>" + code + "</AuthCode></ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 立即更新C3AM的用户名和密码
        /// </summary>
        /// <param name="amuser"></param>
        /// <param name="tel"></param>
        /// <param name="pwd"></param>
        public void UpdateC3AMUser(string amuser, string tel, string pwd)
        {
            dal.UpdateC3AMUser(amuser, tel, pwd);
        }
        #endregion

        #region CMT调用的WSRR
        public DataTable GetTaskView(string where)
        {
            DataSet ds = dal.GetData("f50694ed-b48c-4949-ba32-72e003fca76a", where);
            DataTable dt = ds.Tables[1];
            return dt;
        }

        public DataTable GetCustomerInfo(string where)
        {
            DataSet ds = dal.ExcuteWsrr("0078b5a7-2209-4d82-90a1-907ee84c5c03", @"<XML><ROOT><OPTYPE>GetCustomerInfo</OPTYPE></ROOT></XML>
                                            <WHERE>" + where + "</WHERE>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        public DataSet GetTaskDetail(string aml)
        {
            string strRst = dal.ExcuteWsrrAML("f50694ed-b48c-4949-ba32-72e003fca76a", aml);
            DataSet ds = XmlHelper.GetDSByExcelXML(strRst, false, false);
            string strRstTemp = ds.Tables[0].Rows[0][0].ToString();
            DataSet dsRst = XmlHelper.GetDSByExcelXML(strRstTemp, false, false);
            return dsRst;
        }

        public DataTable GetFruit(string where)
        {
            DataSet ds = dal.ExcuteWsrr("0078b5a7-2209-4d82-90a1-907ee84c5c03", @"<XML><ROOT><OPTYPE>GetFruit</OPTYPE><LIST>
                                            <ROWS><Type>" + where + "</Type></ROWS></LIST></ROOT></XML>");

            DataTable dt = ds.Tables[1];
            return dt;
        }

        public DataTable Refuse(string where)
        {
            DataSet ds = dal.ExcuteWsrr("0078b5a7-2209-4d82-90a1-907ee84c5c03", @"<XML><ROOT><OPTYPE>Refuse</OPTYPE>
                                            <LIST><ROWS><Type>" + where + "</Type></ROWS></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        public DataTable FBSumbit(string xml)
        {
            DataSet ds = dal.ExcuteWsrr("0078b5a7-2209-4d82-90a1-907ee84c5c03", @"<XML><ROOT><OPTYPE>Submit</OPTYPE>
                                            <LIST><ROWS>" + xml + "</ROWS></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        public DataTable FeedBackSumbitArrival(string xml)
        {
            DataSet ds = dal.ExcuteWsrr("0078b5a7-2209-4d82-90a1-907ee84c5c03", @"<XML><ROOT><OPTYPE>SubmitArrival</OPTYPE>
                                            <LIST><ROWS>" + xml + "</ROWS></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// 获取导购列表
        /// </summary>
        /// <param name="Depotid"></param>
        /// <returns></returns>
        public DataTable SellerList(string Depotid)
        {
            DataSet ds = dal.ExcuteWsrr("70f9ed84-b972-48f3-b427-69f106581848", @"<XML><ROOT><OPTYPE>GETEMPLOYEEBASE</OPTYPE>
                                            <LIST><ROWS><depotid>" + Depotid + "</depotid></ROWS></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];

            return dt;
        }

        #endregion

        #region 3S薪资条调用的WSRR
        /// <summary>
        ///3S薪资条调用的WSRR
        /// </summary>
        ///
        /// <param name="身份证号"></param>
        /// <returns></returns>
        public DataTable GetShopPay(string IdentityCard, string year, string month)
        {
            DataSet ds = dal.ExcuteWsrr("cd7fbadc-0629-4756-8b0d-3f89e4fb3fbf", @"<XML><ROOT><OPTYPE>EHRForShopPay</OPTYPE><LIST><ROW>
                <IdentityCard>" + IdentityCard + @"</IdentityCard>
                <year>" + year + @"</year>
                <month>" + month + @"</month>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///根据微信号获取身份证
        /// </summary>
        /// <param name="oid"></param>
        /// <returns></returns>
        public DataTable GetIdentityCardInfo(string oid)
        {
            DataSet ds = dal.ExcuteWsrr("eeb77f75-5902-4d0f-b99a-57ef20c21d2b", @"<XML><ROOT><OPTYPE>GetIdentityCardInfo</OPTYPE><LIST><ROW>
                <oid>" + oid + @"</oid>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        #endregion

        #region EHR考勤
        /// <summary>
        /// EHR考勤验证登入信息
        /// </summary>
        /// <param name="UserName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public DataTable CheckLogin(string UserName, string password)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>CheckDologin</OPTYPE><LIST><ROW>
                <name>" + UserName + @"</name>
                <password>" + password + @"</password>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        /// EHR公告信息
        /// </summary>
        /// <returns></returns>
        public DataTable GetNotic()
        {
            DataSet ds = dal.ExcuteWsrr("f1a2f406-c0ae-4fef-a62d-3be8c522d0a0", @"<XML><ROOT><OPTYPE>GetNoticForPTP</OPTYPE><LIST><ROW>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///薪资条调用的WSRR
        /// </summary>
        /// <param name="年"></param>
        /// <param name="月"></param>
        /// <param name="身份证号"></param>
        /// <returns></returns>
        public DataTable GetEHRForSalary(string password, string IdentityCard, string year, string month)
        {
            DataSet ds = dal.ExcuteWsrr("6caa05b7-cb78-4fb1-9f27-2e61df5c09c6", @"<XML><ROOT><OPTYPE>GetEHRForSalary</OPTYPE><LIST><ROW>
                <password>" + password + @"</password>
                <sfz>" + IdentityCard + @"</sfz>
                <year>" + year + @"</year>
                <month>" + month + @"</month>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///打卡查询
        /// </summary>
        /// <param name="年"></param>
        /// <param name="月"></param>
        /// <param name="身份证号"></param>
        /// <returns></returns>
        public DataTable AttendanceGet(string IdentityCard, string year, string month)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>GetCheckWorkAttendance</OPTYPE><LIST><ROW>
                <sfz>" + IdentityCard + @"</sfz>
                <year>" + year + @"</year>
                <month>" + month + @"</month>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///补签考勤查询
        /// </summary>
        /// <param name="年"></param>
        /// <param name="月"></param>
        /// <param name="身份证号"></param>
        /// <returns></returns>
        public DataTable AttendanceGetApply(string IdentityCard, string year, string month)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>GetMangeCardRecordInfo</OPTYPE><LIST><ROW>
                <sfz>" + IdentityCard + @"</sfz>
                <year>" + year + @"</year>
                <month>" + month + @"</month>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///审批人
        /// </summary>
        /// <param name="m_c_oid"></param>
        /// <param name="身份证号"></param>
        /// <returns></returns>
        public DataTable ApplyInfo(string m_c_oid, string m_sfz)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>ApplyInfo</OPTYPE><LIST><ROW>
                <c_oid>" + m_c_oid + @"</c_oid>
                <sfz>" + m_sfz + @"</sfz>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///考勤提交
        /// </summary>
        /// <param name="m_c_oid"></param>
        /// <param name="身份证号"></param>
        /// <returns></returns>
        /// 
        public DataTable AttendanceSubmit(string name, string adddate, string adddate1, string adddate2, string addcause, string addchangeap1,
                                          string addchangeap2, string addremarks, string c_oid)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>ApplyEdit</OPTYPE><LIST><ROW>
                <name>" + name + @"</name>
                <adddate>" + adddate + @"</adddate>
                <adddate1>" + adddate1 + @"</adddate1>
                <adddate2>" + adddate2 + @"</adddate2>
                <addcause>" + addcause + @"</addcause>
                <addchangeap1>" + addchangeap1 + @"</addchangeap1>
                <addchangeap2>" + addchangeap2 + @"</addchangeap2>
                <addremarks>" + addremarks + @"</addremarks>
                <c_oid>" + c_oid + @"</c_oid>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///获取审批考勤数据
        /// </summary>
        /// <param name="m_c_oid"></param>
        /// <returns></returns>
        public DataTable AttendanceGetApprove(string oid)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>GetApprove</OPTYPE><LIST><ROW>
                <oid>" + oid + @"</oid>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///审批考勤数据
        /// </summary>
        /// <param name="m_c_oid"></param>
        /// <returns></returns>
        public DataTable AttendanceApproveSubmit(string apptype, string c_oid, string m_oid_user, string c_approveflowid,
                                                 string c_oid_renewcardsign, string c_remark, string c_renewremark)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>Approve</OPTYPE><LIST><ROW>
                <apptype>" + apptype + @"</apptype>
                <c_oid>" + c_oid + @"</c_oid>
                <m_oid_user>" + m_oid_user + @"</m_oid_user>
                <c_approveflowid>" + c_approveflowid + @"</c_approveflowid>
                <c_oid_renewcardsign>" + c_oid_renewcardsign + @"</c_oid_renewcardsign>
                <c_remark>" + c_remark + @"</c_remark>
                <c_renewremark>" + c_renewremark + @"</c_renewremark>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }


        /// <summary>
        ///加班记录
        /// </summary>
        /// <param name="年"></param>
        /// <param name="月"></param>
        /// <param name="身份证号"></param>
        /// <returns></returns>
        public DataTable OverTimeGet(string c_oid, string year, string month)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>GetOvertimeSearch</OPTYPE><LIST><ROW>
                <c_oid>" + c_oid + @"</c_oid>
                <year>" + year + @"</year>
                <month>" + month + @"</month>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///加班申请提交
        /// </summary>
        /// <param name="c_oid"></param>
        /// <returns></returns>
        public DataTable OverTimeApplySubmit(string c_oid, string sp1, string sp2, string c_remark, string begindate, string enddate, string c_value, string c_reason, string c_attitemid)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>ApplyOvertime</OPTYPE><LIST><ROW>
                <c_oid>" + c_oid + @"</c_oid>
                <sp1>" + sp1 + @"</sp1>
                <sp2>" + sp2 + @"</sp2>
                <c_remark>" + c_remark + @"</c_remark>
                <begindate>" + begindate + @"</begindate>
                <enddate>" + enddate + @"</enddate>
                <c_value>" + c_value + @"</c_value>
                <c_reason>" + c_reason + @"</c_reason>
                <c_attitemid>" + c_attitemid + @"</c_attitemid>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///获取加班审批数据
        /// </summary>
        /// <param name="m_c_oid"></param>
        /// <returns></returns>
        public DataTable OverTimeGetApprove(string c_oid)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>GetApplyOvertime</OPTYPE><LIST><ROW>
                <c_oid>" + c_oid + @"</c_oid>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }
        /// <summary>
        ///审批加班数据
        /// </summary>
        /// <param name="m_c_oid"></param>
        /// <returns></returns>
        public DataTable OverTimeApproveSubmit(string c_oid_overtimeapply, string applec_oid, string c_renewremark, string c_approveflowid,
                                                 string m_c_oid, string m_oid_user, string c_remark, string approveType)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>ApproveOvertime</OPTYPE><LIST><ROW>
                <c_oid_overtimeapply>" + c_oid_overtimeapply + @"</c_oid_overtimeapply>
                <applec_oid>" + applec_oid + @"</applec_oid>
                <c_renewremark>" + c_renewremark + @"</c_renewremark>
                <c_approveflowid>" + c_approveflowid + @"</c_approveflowid>
                <c_oid>" + m_c_oid + @"</c_oid>
                <m_oid_user>" + m_oid_user + @"</m_oid_user>
                <c_remark>" + c_remark + @"</c_remark>
                <overtimetype>" + approveType + @"</overtimetype>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///休假查询
        /// </summary>
        /// <param name="年"></param>
        /// <param name="月"></param>
        /// <returns></returns>
        public DataTable VacationGet(string c_oid, string year, string month)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>GetVacationSearch</OPTYPE><LIST><ROW>
                <c_oid>" + c_oid + @"</c_oid>
                <year>" + year + @"</year>
                <month>" + month + @"</month>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }


        /// <summary>
        ///验证该时段是否有休假
        /// </summary>
        /// <param name="c_oid"></param>
        /// <returns></returns>
        public DataTable CheckVacation(string c_oid, string c_begintime, string c_endtime)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>CheckVacation</OPTYPE><LIST><ROW>
                <c_oid>" + c_oid + @"</c_oid>
                <c_begintime>" + c_begintime + @"</c_begintime>
                <c_endtime>" + c_endtime + @"</c_endtime>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///休假申请提交
        /// </summary>
        /// <param name="c_oid"></param>
        /// <returns></returns>
        public DataTable VacationApplySubmit(string c_oid, string sp1, string sp2, string c_attitemoid, string c_year, string begindate, string enddate, string c_value, string c_reason,
          string c_principal, string c_linkman, string c_remark)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>ApplyVacation</OPTYPE><LIST><ROW>
                <c_oid>" + c_oid + @"</c_oid>
                <sp1>" + sp1 + @"</sp1>
                <sp2>" + sp2 + @"</sp2>
                <c_attitemoid>" + c_attitemoid + @"</c_attitemoid>
                <c_year>" + c_year + @"</c_year>
                <begindate>" + begindate + @"</begindate>
                <enddate>" + enddate + @"</enddate>
                <c_value>" + c_value + @"</c_value>
                <c_reason>" + c_reason + @"</c_reason>
                <c_principal>" + c_principal + @"</c_principal>
                <c_linkman>" + c_linkman + @"</c_linkman>
                <c_remark>" + c_remark + @"</c_remark>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///获取休假审批数据
        /// </summary>
        /// <param name="m_c_oid"></param>
        /// <returns></returns>
        public DataTable VacationGetApprove(string c_oid)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>GetApproveVacationInfo</OPTYPE><LIST><ROW>
                <c_oid>" + c_oid + @"</c_oid>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }
        /// <summary>
        ///审批休假数据
        /// </summary>
        /// <param name="m_c_oid"></param>
        /// <returns></returns>
        ///// 
        public DataTable VacationApproveSubmit(string c_oid, string c_remark, string m_oid_user, string c_approveflowid, string c_oid_vocationapply, string vacationtype)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>ApproveVacationInfo</OPTYPE><LIST><ROW>
                <c_oid>" + c_oid + @"</c_oid>
                <c_remark>" + c_remark + @"</c_remark>
                <m_oid_user>" + m_oid_user + @"</m_oid_user>
                <c_approveflowid>" + c_approveflowid + @"</c_approveflowid>
                <c_oid_vocationapply>" + c_oid_vocationapply + @"</c_oid_vocationapply>
                <vacationtype>" + vacationtype + @"</vacationtype>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///出差查询
        /// </summary>
        /// <param name="年"></param>
        /// <param name="月"></param>
        /// <returns></returns>
        public DataTable OutGet(string c_oid, string year, string month)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>GetBusinessOutSearch</OPTYPE><LIST><ROW>
                <c_oid>" + c_oid + @"</c_oid>
                <year>" + year + @"</year>
                <month>" + month + @"</month>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///验证该时段是否有出差
        /// </summary>
        /// <param name="c_oid"></param>
        /// <returns></returns>
        public DataTable CheckOut(string c_oid, string c_begintime, string c_endtime)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>CheckBusinessOut</OPTYPE><LIST><ROW>
                <c_oid>" + c_oid + @"</c_oid>
                <c_begintime>" + c_begintime + @"</c_begintime>
                <c_endtime>" + c_endtime + @"</c_endtime>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }
        /// <summary>
        ///出差申请提交
        /// </summary>
        /// <param name="c_oid"></param>
        /// <returns></returns>
        public DataTable OutApplySubmit(string c_oid, string sp1, string sp2, string c_remark, string begindate, string enddate, string c_value, string c_attitemid,
          string c_vehicle, string c_reason, string c_destname, string c_destaddress, string c_destination, string c_contactperson, string c_contactphone)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>ApplyBusinessOut</OPTYPE><LIST><ROW>
                <c_oid>" + c_oid + @"</c_oid>
                <sp1>" + sp1 + @"</sp1>
                 <sp2>" + sp2 + @"</sp2>
                <c_remark>" + c_remark + @"</c_remark>
                <c_remark>" + c_remark + @"</c_remark>
                <begindate>" + begindate + @"</begindate>
                <enddate>" + enddate + @"</enddate>
                <c_value>" + c_value + @"</c_value>
                <c_attitemid>" + c_attitemid + @"</c_attitemid>
                <c_vehicle>" + c_vehicle + @"</c_vehicle>
                <c_reason>" + c_reason + @"</c_reason>
                <c_destname>" + c_destname + @"</c_destname>
                <c_destaddress>" + c_destaddress + @"</c_destaddress>
                <c_destination>" + c_destination + @"</c_destination>
                <c_contactperson>" + c_contactperson + @"</c_contactperson>
                <c_contactphone>" + c_contactphone + @"</c_contactphone>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///获取出差审批数据
        /// </summary>
        /// <param name="m_c_oid"></param>
        /// <returns></returns>
        public DataTable OutGetApprove(string c_oid)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>GetApproveBusinessOutInfo</OPTYPE><LIST><ROW>
                <c_oid>" + c_oid + @"</c_oid>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }
        /// <summary>
        ///审批出差数据
        /// </summary>
        /// <param name="m_c_oid"></param>
        /// <returns></returns>
        ///// 
        public DataTable OutApproveSubmit(string c_oid, string c_remark, string m_oid_user, string applec_oid, string c_approveflowid, string c_oid_outapply, string businessouttype)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>ApproveBusinessOutInfo</OPTYPE><LIST><ROW>
                <c_oid>" + c_oid + @"</c_oid>
                <c_remark>" + c_remark + @"</c_remark>
                <m_oid_user>" + m_oid_user + @"</m_oid_user>
                <applec_oid>" + applec_oid + @"</applec_oid>
                <c_approveflowid>" + c_approveflowid + @"</c_approveflowid>
                <c_oid_outapply>" + c_oid_outapply + @"</c_oid_outapply>
                <businessouttype>" + businessouttype + @"</businessouttype>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///新增行动计划
        /// </summary>
        /// <returns></returns>
        ///// 
        public DataTable PromiseEdit(string c_unitname, string c_code, string c_jobname, string UserNameC, string ActionPlan1, string ActionPlan2, string ActionPlan3)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>PromiseEdit</OPTYPE><LIST><ROW>
                <c_unitname>" + c_unitname + @"</c_unitname>
                <c_code>" + c_code + @"</c_code>
                <c_jobname>" + c_jobname + @"</c_jobname>
                <UserNameC>" + UserNameC + @"</UserNameC>
                <actionplan1>" + ActionPlan1 + @"</actionplan1>
                <actionplan2>" + ActionPlan2 + @"</actionplan2>
                <actionplan3>" + ActionPlan3 + @"</actionplan3>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }

        /// <summary>
        ///查询行动计划
        /// </summary>
        /// <returns></returns>
        ///// 
        public DataTable PromiseSearch(string PromiseWhere)
        {
            DataSet ds = dal.ExcuteWsrr("cc517737-703e-4228-93cd-937d9bc328e6", @"<XML><ROOT><OPTYPE>PromiseSearch</OPTYPE><LIST><ROW>
                <promisewhere>" + PromiseWhere + @"</promisewhere>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }



        #endregion

        #region 卓莱雅券号创建券

        /// <summary>
        /// 卓莱雅券号创建券
        /// </summary>
        /// <param name="面币"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public DataTable JLTicketCreate(string sums)
        {
            DataSet ds = dal.ExcuteWsrr("cfd99a2f-22c6-44c4-95fb-c7d7cfa5b4cb", @"<XML><ROOT><OPTYPE>JLTicketCreate</OPTYPE><LIST><ROW>
                <sums>" + sums + @"</sums>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }


        #endregion

        #region 验证小翅膀登入

        /// <summary>
        /// 验证小翅膀登入
        /// </summary>
        /// <param name="姓名"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public DataTable CheackAMUser(string password, string name)
        {
            DataSet ds = dal.ExcuteWsrr("7d67a621-f3a4-498f-84cd-ae3447635ccbb", @"<XML><ROOT><OPTYPE>CheackAMUser</OPTYPE><LIST><ROW>
                <AM_login>" + name + @"</AM_login>
                <AM_Password>" + password + @"</AM_Password>
                </ROW></LIST></ROOT></XML>");
            DataTable dt = ds.Tables[1];
            return dt;
        }
        #endregion


    }
}