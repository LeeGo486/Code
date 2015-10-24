
SELECT TOP 1000 [GUID]
,DH				-- 单号
,Branch			--分公司
,DJR			--登记人
,DJSJ			--登记日期
,DPBM			--店铺编码
,DPMC			--店铺名称
,DPLX			--店铺类型		
,DPDQ			--店铺大区
,PP				--品牌
,WXCBM			--维修仓编码
,WXCMC			--维修仓名称
,DZXM			--店长姓名
,DZLXDH			--店长联系电话
,SLDG			--受理导购
,DGLXDH			--导购联系电话
,SFFGKWX		--是否顾客维修
,VIPKH			--VIP卡号
,GKXM			--顾客姓名
,GKLXDH			--顾客联系电话
,SFTYFFWX		--是否同意付费维修
,SCSJ			--售出时间
,JJCD			--紧急程度
,KH				--款号
,YS				--颜色
,MS				--码数
,THRQ			--退回日期
,WTMS			--问题描述
,XJCD			--新旧程度
,YSGS			--运输公司
,YDH			--运单号
,FHDZ			--发货地址
,SHDZ			--收货地址
,SHR			--收货人
,SHRLXDH		--收货人联系电话
,BZXX			--备注信息
,ZT				--状态
,WXXZ1			--维修性质1
,WTD1			--问题点1
,QY1			--起因1
,XXD1			--现象点
,WXXZ2			--维修性质2
,WTD2			--问题点2
,QY2			--起因2
,XXD2			--现象点2
,JCYY			--检测异意
,PDCLFS			--判断处理方式
,ZRBM			--责任部门
,TX				--特修
,WXBW			--维修部位描述
,JHWXTS			--计划维修天数
,SFSF			--是否收费
,SFJE			--收费金额
,SFNR			--收费内容
,PJPDBZ			--品检判定备注
,PJPDR			--品检判定人
,PJPDSJ			--品检判定时间
,TXSPR			--特修审批人	
,TXSPSJ			--特修审批时间
,TTSPR			--特退审批人
,TTSPSJ			--特退审批时间
,WXR			--维修人
,WXSJ			--维修时间		
,WXQRR			--维修确认人
,WXQRSJ			--维修确认时间
,DPPJ			--店铺评价	
,DPPJYJ			--店铺评价意见
,GKPJ			--顾客评价
,GKPJYJ			--顾客评价意见
,XGR			--修改人
,XGRQ			--修改日期
,DJZT			--单据状态
,ZBFH_DH		--总部发货——发货单号
,ZBFH_YSGS		--总部发货-运输公司
,ZBFH_YSDH		--总部发货-运输单号
,ZBFH_FHDZ		--总部发货-发货地址
,ZBFH_SHDZ		--总部发货-收货地址
,ZBFH_SHR		--总部发货-收货人
,ZBFH_SHRDH		--总部发货-收货人电话
,ZBFH_BZ		--总部发货-备注
,ZBFH_BZR		--总部发货-编制人
,ZBFH_BZRQ		--总部发货-编制日期
,TCCLJG			--退仓处理结果
,AMTSBS			--AM提示标识
,AMTSSJ			--AM提示时间
,THDH			--退货单号
,POSTHFHDDZBS	--POS退货发货单登帐标识
FROM [epapp].[dbo].[CYWXDJB]
 select menuid,menuname from cm_menu ;select guid,userid,com from cm_loginlog;
   select
        loginlog0_.guid as guid24_,
        loginlog0_.com as com24_,
        loginlog0_.userid as userid24_ 
    from
        dbo.CM_LOGINLOG loginlog0_ 
    where
        loginlog0_.userid='1122'
 
 
 
 select zt,pdclfs,* FROM CYWXDJB --成衣维修登记表 
 
select zbfh_bzr,zbfh_shr,zbfh_shrdh,zbfh_shdz,zbfh_fhdz,shrlxdh,sffgkwx,sftyffwx,kh,zt,sldg,wxxz1,wxxz2,pdclfs,jhwxts,tx,sfsf,* FROM CYWXDJB --成衣维修登记表 
where dh='WX0100101420111021002'

3	111	ANDY	2011-11-08 15:13:35.000	ANDY	2011-11-08 15:13:35.000
3	111	ANDY	2011-11-08 15:13:35.000	ANDY	2011-11-08 15:13:35.000	2011-11-08 下午 03:13:36
select zt,sldg,pjpdr,pjpdsj,xgr,xgrq,tccljg,* FROM CYWXDJB --成衣维修登记表 
where dh='WX0100100220111108001'

update CYWXDJB set zt=1 where dh='WX0100101420101226001'

delete CYWXDJB where guid in ('ec14eded975a4c96bc5491e051ab1d59'
,'ecc96be014f44cd88cc0fd7cf796001f')


select * FROM CYWXDJB --成衣维修登记表 
where guid='054DDDA0EB8C48C0B3EB29B2F26E538D'

delete CYWXDJB --成衣维修登记表 
where dh='01001002'

 
 
-- 查找定义 状态
select bh,mc,sx from 
(
select '-1' as bh ,'全部' as mc,-1 as sx
union
SELECT SCFX_TYBMB.FCODE as bh, SCFX_TYBMB.FCONTENT as mc,FSEQUENCE as sx
  FROM SCFX_TYBMB
  WHERE SCFX_TYBMB.FSCOPE = '成衣维修状态'
)a order by sx


SELECT * FROM SCFX_TYBMB WHERE FSCOPE='店铺类别'

-- 查找定义 店铺（DRP数据库-仓店档案表）
SELECT A.DEPOTID, A.D_NAME,*
  FROM F22TEST.F22TEST.dbo.J_DEPOT A  
  
  where  depotid = '01001002'
  
    SELECT employeeid, names ,telephone FROM F22TEST.F22TEST.dbo.J_EMPLOYEE  where depotid ='null'
  SELECT *
  FROM F22TEST.F22TEST.dbo.J_EMPLOYEE 
  
  SELECT FCODE, FCONTENT,*, FPARENTCODE FROM SCFX_TYBMB where fscope in('退仓处理结果','成衣问题现象点','成衣问题起因','成衣问题点' ) and SCFX_TYBMB.FDELETEFLAG = 0
  select clothingid,len(clothingid),oldclothingid from F22TEST.F22TEST.dbo.J_CLOTHING  where clothingid  <> oldclothingid
  B10AO8001aHXS	B10AO800101
B10AO8001aHS	B10AO800102
B10AO8001aHM	B10AO800103
B10AO8001aHL	B10AO800104
B10AO8001aHXL	B10AO800105
B10AT1001aWXS	B10AT100101
B10AT1001aWS	B10AT100102
B10AT1001aWM	B10AT100103
B10AT1001aWL	B10AT100104
B10AT1001aWXL	B10AT100105
-- 查找定义  店铺类型
--     0：全部   1：自营    2：加盟

select WXCBM,WXCMC,* from PPWXCDYB
select depotid,areaid,d_name,r_name,Tel,m_type,address,d_dq,d_dd,d_lx,brandid,m_type  from J_DEPOT


SELECT SCFX_TYBMB.FCODE, SCFX_TYBMB.FCONTENT, SCFX_TYBMB.FPARENTCODE
  FROM SCFX_TYBMB
  WHERE SCFX_TYBMB.FSCOPE = '成衣问题点'  and 
  
  SELECT SCFX_TYBMB.FCODE, SCFX_TYBMB.FPARENTCODE, SCFX_TYBMB.FCONTENT
  FROM SCFX_TYBMB
  WHERE SCFX_TYBMB.FSCOPE = '成衣问题起因'
  
  SELECT SCFX_TYBMB.FCODE, SCFX_TYBMB.FCONTENT, SCFX_TYBMB.FPARENTCODE
  FROM SCFX_TYBMB
  WHERE SCFX_TYBMB.FSCOPE = '成衣问题现象点'
  
  
  SELECT SCFX_TYBMB.FCODE, SCFX_TYBMB.FCONTENT
  FROM SCFX_TYBMB
  WHERE SCFX_TYBMB.FSCOPE = '退仓处理结果' and SCFX_TYBMB.FDELETEFLAG = 0
  
  
  SELECT SCFX_TYBMB.FCODE, SCFX_TYBMB.FCONTENT,*
  FROM SCFX_TYBMB
  WHERE SCFX_TYBMB.FSCOPE = '维修_责任部门'
  
  SELECT SCFX_TYBMB.FCODE, SCFX_TYBMB.FCONTENT
  FROM SCFX_TYBMB
  WHERE SCFX_TYBMB.FSCOPE = '计划维修天数'