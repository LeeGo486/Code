package ep.org.clothingmaintenance.bean;

public class MaintenanceBill {
	private String userid;
	private String guid;
	private String dh;
	private String djr;
	private String djsj;
	private String dpbm;
	private String dpmc;
	private String dplx;
	private String DPDQ;	//店铺大区
	private String PP;	
	private String WXCBM;//维修仓编码
	private String WXCMC;	//维修仓名称
	private String DZXM;// 店长名称
	private String DZLXDH;	//店长联系电话
	private String SLDG;	//受理导购
	private String DGLXDH;	//导购联系电话
	private String GKWX;	//顾客维修
	private String VIPKH;	//VIP卡号
	private String GKXM;//顾客姓名
	private String GKLXDH;	//顾客联系电话
	private String SFTYFFWX;	//是否同意付费维修
	private String SCSJ;	//售出时间
	private String JJCD;	//紧急程度
	private String KH;	//款号
	private String YS;	//颜色
	private String MS;	//码数
	private String THRQ;	//退回日期
	private String WTMS;	//问题描述
	private String XJCD;	//新旧程度
	private String YSGS;	//运输公司
	private String YDH;	//运单号
	private String FHDZ;	//发货地址
	private String SHDZ;	//收货地址
	private String SHR;	//收货人
	private String SHRLXDH;	//收货人联系电话
	private String BZXX;	//备注信息
	private String ZT;	//状态
	private String WXXZ1;	//维修性质1
	private String WTD1;	//问题点1
	private String QY1;	//起因1
	private String XXD1;	//现象点1
	private String WXXZ2;	//维修性质2
	private String WTD2;	//问题点2
	private String QY2;	//起因2
	private String XXD2;//	现象点2
	private String JCYY	;//检测异议
	private String PDCLFS;//	判定处理方式
	private String ZRBM;//	责任部门
	private String TX;//	特修
	private String WXBW;//	维修部位描述
	private String JHWXTS;//	计划维修天数
	private String SFSF;//	是否收费
	private String SFJE;//	收费金额
	private String SFNR;//	收费内容
	private String PJPDBZ;//	品检判定备注
	private String PJPDR;//	品检判定人
	private String PJPDSJ;//	品检判定时间
	private String TXSPR;//	特修审批人
	private String TXSPSJ;//	特修审批时间
	private String TTSPR;//	特退审批人
	private String TTSPSJ;//	特退审批时间
	private String WXR;//	维修人
	private String WXSJ;//	维修时间
	private String WXQRR;//	维修确认人
	private String WXQRSJ;//	维修确认时间
	private String DPPJ;//	店铺评价
	private String DPPJYJ;//	店铺评价意见
	private String GKPJ;//	顾客评价
	private String GKPJYJ;//	顾客评价意见
	private String XGR;//	修改人
	private String XGSJ;//	修改时间
	private String DJZT;//	单据状态
	private String ZBFH_DH;//	总部发货——发货单号
	private String ZBFH_YSGS;//	总部发货——运输公司
	private String ZBFH_YSDH;//	总部发货——运输单号
	private String ZBFH_FHDZ;	//总部发货——发货地址
	private String ZBFH_SHDZ;	//总部发货——收货地址
	private String ZBFH_SHR;	//总部发货——收货人
	private String ZBFH_SHRDH;	//总部发货——收货人电话
	private String ZBFH_BZ;	//总部发货——备注
	private String ZBFH_BZR;	//总部发货——编制人
	private String ZBFH_BZSJ;	//总部发货——编制时间
	private String THDH; //退货单号
	private String TCCLJG; //退仓处理结果
	private String ztTypeName;
	private String sldgCode;
	private String dpTypeName;
	private String dpTypeCode;
	private String WXDW;//维修单位
	private String YJWCSJ;//预计完成时间
	private String SJWCSJ;//时间完成时间
	private String FFJE;//付费金额
	private String YJWCSJ_DAY;//预计完成时间，俺天算，3天或者7天
	private String SLDGXM;
	
	
	
	public String getYJWCSJ_DAY() {
		return YJWCSJ_DAY;
	}
	public void setYJWCSJ_DAY(String yJWCSJDAY) {
		YJWCSJ_DAY = yJWCSJDAY;
	}
	public String getWXDW() {
		return WXDW;
	}
	public void setWXDW(String wXDW) {
		WXDW = wXDW;
	}
	public String getYJWCSJ() {
		return YJWCSJ;
	}
	public void setYJWCSJ(String yJWCSJ) {
		YJWCSJ = yJWCSJ;
	}
	public String getSJWCSJ() {
		return SJWCSJ;
	}
	public void setSJWCSJ(String sJWCSJ) {
		SJWCSJ = sJWCSJ;
	}
	public String getFFJE() {
		return FFJE;
	}
	public void setFFJE(String fFJE) {
		FFJE = fFJE;
	}
	public String getDpTypeCode() {
		return dpTypeCode;
	}
	public void setDpTypeCode(String dpTypeCode) {
		this.dpTypeCode = dpTypeCode;
	}
	public String getDpTypeName() {
		return dpTypeName;
	}
	public void setDpTypeName(String dpTypeName) {
		this.dpTypeName = dpTypeName;
	}
	public String getSldgCode() {
		return sldgCode;
	}
	public void setSldgCode(String sldgCode) {
		this.sldgCode = sldgCode;
	}
	public String getZtTypeName() {
		return ztTypeName;
	}
	public void setZtTypeName(String ztTypeName) {
		this.ztTypeName = ztTypeName;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getGuid() {
		return guid;
	}
	public void setGuid(String guid) {
		this.guid = guid;
	}
	public String getDh() {
		return dh;
	}
	public void setDh(String dh) {
		this.dh = dh;
	}
	public String getDjr() {
		return djr;
	}
	public void setDjr(String djr) {
		this.djr = djr;
	}
	public String getDjsj() {
		return djsj;
	}
	public void setDjsj(String djsj) {
		this.djsj = djsj;
	}
	public String getDpbm() {
		return dpbm;
	}
	public void setDpbm(String dpbm) {
		this.dpbm = dpbm;
	}
	public String getDpmc() {
		return dpmc;
	}
	public void setDpmc(String dpmc) {
		this.dpmc = dpmc;
	}
	public String getDplx() {
		return dplx;
	}
	public void setDplx(String dplx) {
		this.dplx = dplx;
	}
	public String getDPDQ() {
		return DPDQ;
	}
	public void setDPDQ(String dPDQ) {
		DPDQ = dPDQ;
	}
	public String getPP() {
		return PP;
	}
	public void setPP(String pP) {
		PP = pP;
	}
	public String getWXCBM() {
		return WXCBM;
	}
	public void setWXCBM(String wXCBM) {
		WXCBM = wXCBM;
	}
	public String getWXCMC() {
		return WXCMC;
	}
	public void setWXCMC(String wXCMC) {
		WXCMC = wXCMC;
	}
	public String getDZXM() {
		return DZXM;
	}
	public void setDZXM(String dZXM) {
		DZXM = dZXM;
	}
	public String getDZLXDH() {
		return DZLXDH;
	}
	public void setDZLXDH(String dZLXDH) {
		DZLXDH = dZLXDH;
	}
	public String getSLDG() {
		return SLDG;
	}
	public void setSLDG(String sLDG) {
		SLDG = sLDG;
	}
	public String getDGLXDH() {
		return DGLXDH;
	}
	public void setDGLXDH(String dGLXDH) {
		DGLXDH = dGLXDH;
	}
	public String getGKWX() {
		return GKWX;
	}
	public void setGKWX(String gKWX) {
		GKWX = gKWX;
	}
	public String getVIPKH() {
		return VIPKH;
	}
	public void setVIPKH(String vIPKH) {
		VIPKH = vIPKH;
	}
	public String getGKXM() {
		return GKXM;
	}
	public void setGKXM(String gKXM) {
		GKXM = gKXM;
	}
	public String getGKLXDH() {
		return GKLXDH;
	}
	public void setGKLXDH(String gKLXDH) {
		GKLXDH = gKLXDH;
	}
	public String getSFTYFFWX() {
		return SFTYFFWX;
	}
	public void setSFTYFFWX(String sFTYFFWX) {
		SFTYFFWX = sFTYFFWX;
	}
	public String getSCSJ() {
		return SCSJ;
	}
	public void setSCSJ(String sCSJ) {
		SCSJ = sCSJ;
	}
	public String getJJCD() {
		return JJCD;
	}
	public void setJJCD(String jJCD) {
		JJCD = jJCD;
	}
	public String getKH() {
		return KH;
	}
	public void setKH(String kH) {
		KH = kH;
	}
	public String getYS() {
		return YS;
	}
	public void setYS(String yS) {
		YS = yS;
	}
	public String getMS() {
		return MS;
	}
	public void setMS(String mS) {
		MS = mS;
	}
	public String getTHRQ() {
		return THRQ;
	}
	public void setTHRQ(String tHRQ) {
		THRQ = tHRQ;
	}
	public String getWTMS() {
		return WTMS;
	}
	public void setWTMS(String wTMS) {
		WTMS = wTMS;
	}
	public String getXJCD() {
		return XJCD;
	}
	public void setXJCD(String xJCD) {
		XJCD = xJCD;
	}
	public String getYSGS() {
		return YSGS;
	}
	public void setYSGS(String ySGS) {
		YSGS = ySGS;
	}
	public String getYDH() {
		return YDH;
	}
	public void setYDH(String yDH) {
		YDH = yDH;
	}
	public String getFHDZ() {
		return FHDZ;
	}
	public void setFHDZ(String fHDZ) {
		FHDZ = fHDZ;
	}
	public String getSHDZ() {
		return SHDZ;
	}
	public void setSHDZ(String sHDZ) {
		SHDZ = sHDZ;
	}
	public String getSHR() {
		return SHR;
	}
	public void setSHR(String sHR) {
		SHR = sHR;
	}
	public String getSHRLXDH() {
		return SHRLXDH;
	}
	public void setSHRLXDH(String sHRLXDH) {
		SHRLXDH = sHRLXDH;
	}
	public String getBZXX() {
		return BZXX;
	}
	public void setBZXX(String bZXX) {
		BZXX = bZXX;
	}
	public String getZT() {
		return ZT;
	}
	public void setZT(String zT) {
		ZT = zT;
	}
	public String getWXXZ1() {
		return WXXZ1;
	}
	public void setWXXZ1(String wXXZ1) {
		WXXZ1 = wXXZ1;
	}
	public String getWTD1() {
		return WTD1;
	}
	public void setWTD1(String wTD1) {
		WTD1 = wTD1;
	}
	public String getQY1() {
		return QY1;
	}
	public void setQY1(String qY1) {
		QY1 = qY1;
	}
	public String getXXD1() {
		return XXD1;
	}
	public void setXXD1(String xXD1) {
		XXD1 = xXD1;
	}
	public String getWXXZ2() {
		return WXXZ2;
	}
	public void setWXXZ2(String wXXZ2) {
		WXXZ2 = wXXZ2;
	}
	public String getWTD2() {
		return WTD2;
	}
	public void setWTD2(String wTD2) {
		WTD2 = wTD2;
	}
	public String getQY2() {
		return QY2;
	}
	public void setQY2(String qY2) {
		QY2 = qY2;
	}
	public String getXXD2() {
		return XXD2;
	}
	public void setXXD2(String xXD2) {
		XXD2 = xXD2;
	}
	public String getJCYY() {
		return JCYY;
	}
	public void setJCYY(String jCYY) {
		JCYY = jCYY;
	}
	public String getPDCLFS() {
		return PDCLFS;
	}
	public void setPDCLFS(String pDCLFS) {
		PDCLFS = pDCLFS;
	}
	public String getZRBM() {
		return ZRBM;
	}
	public void setZRBM(String zRBM) {
		ZRBM = zRBM;
	}
	public String getTX() {
		return TX;
	}
	public void setTX(String tX) {
		TX = tX;
	}
	public String getWXBW() {
		return WXBW;
	}
	public void setWXBW(String wXBW) {
		WXBW = wXBW;
	}
	public String getJHWXTS() {
		return JHWXTS;
	}
	public void setJHWXTS(String jHWXTS) {
		JHWXTS = jHWXTS;
	}
	public String getSFSF() {
		return SFSF;
	}
	public void setSFSF(String sFSF) {
		SFSF = sFSF;
	}
	public String getSFJE() {
		return SFJE;
	}
	public void setSFJE(String sFJE) {
		SFJE = sFJE;
	}
	public String getSFNR() {
		return SFNR;
	}
	public void setSFNR(String sFNR) {
		SFNR = sFNR;
	}
	public String getPJPDBZ() {
		return PJPDBZ;
	}
	public void setPJPDBZ(String pJPDBZ) {
		PJPDBZ = pJPDBZ;
	}
	public String getPJPDR() {
		return PJPDR;
	}
	public void setPJPDR(String pJPDR) {
		PJPDR = pJPDR;
	}
	public String getPJPDSJ() {
		return PJPDSJ;
	}
	public void setPJPDSJ(String pJPDSJ) {
		PJPDSJ = pJPDSJ;
	}
	public String getTXSPR() {
		return TXSPR;
	}
	public void setTXSPR(String tXSPR) {
		TXSPR = tXSPR;
	}
	public String getTXSPSJ() {
		return TXSPSJ;
	}
	public void setTXSPSJ(String tXSPSJ) {
		TXSPSJ = tXSPSJ;
	}
	public String getTTSPR() {
		return TTSPR;
	}
	public void setTTSPR(String tTSPR) {
		TTSPR = tTSPR;
	}
	public String getTTSPSJ() {
		return TTSPSJ;
	}
	public void setTTSPSJ(String tTSPSJ) {
		TTSPSJ = tTSPSJ;
	}
	public String getWXR() {
		return WXR;
	}
	public void setWXR(String wXR) {
		WXR = wXR;
	}
	public String getWXSJ() {
		return WXSJ;
	}
	public void setWXSJ(String wXSJ) {
		WXSJ = wXSJ;
	}
	public String getWXQRR() {
		return WXQRR;
	}
	public void setWXQRR(String wXQRR) {
		WXQRR = wXQRR;
	}
	public String getWXQRSJ() {
		return WXQRSJ;
	}
	public void setWXQRSJ(String wXQRSJ) {
		WXQRSJ = wXQRSJ;
	}
	public String getDPPJ() {
		return DPPJ;
	}
	public void setDPPJ(String dPPJ) {
		DPPJ = dPPJ;
	}
	public String getDPPJYJ() {
		return DPPJYJ;
	}
	public void setDPPJYJ(String dPPJYJ) {
		DPPJYJ = dPPJYJ;
	}
	public String getGKPJ() {
		return GKPJ;
	}
	public void setGKPJ(String gKPJ) {
		GKPJ = gKPJ;
	}
	public String getGKPJYJ() {
		return GKPJYJ;
	}
	public void setGKPJYJ(String gKPJYJ) {
		GKPJYJ = gKPJYJ;
	}
	public String getXGR() {
		return XGR;
	}
	public void setXGR(String xGR) {
		XGR = xGR;
	}
	public String getXGSJ() {
		return XGSJ;
	}
	public void setXGSJ(String xGSJ) {
		XGSJ = xGSJ;
	}
	public String getDJZT() {
		return DJZT;
	}
	public void setDJZT(String dJZT) {
		DJZT = dJZT;
	}
	public String getZBFH_DH() {
		return ZBFH_DH;
	}
	public void setZBFH_DH(String zBFHDH) {
		ZBFH_DH = zBFHDH;
	}
	public String getZBFH_YSGS() {
		return ZBFH_YSGS;
	}
	public void setZBFH_YSGS(String zBFHYSGS) {
		ZBFH_YSGS = zBFHYSGS;
	}
	public String getZBFH_YSDH() {
		return ZBFH_YSDH;
	}
	public void setZBFH_YSDH(String zBFHYSDH) {
		ZBFH_YSDH = zBFHYSDH;
	}
	public String getZBFH_FHDZ() {
		return ZBFH_FHDZ;
	}
	public void setZBFH_FHDZ(String zBFHFHDZ) {
		ZBFH_FHDZ = zBFHFHDZ;
	}
	public String getZBFH_SHDZ() {
		return ZBFH_SHDZ;
	}
	public void setZBFH_SHDZ(String zBFHSHDZ) {
		ZBFH_SHDZ = zBFHSHDZ;
	}
	public String getZBFH_SHR() {
		return ZBFH_SHR;
	}
	public void setZBFH_SHR(String zBFHSHR) {
		ZBFH_SHR = zBFHSHR;
	}
	public String getZBFH_SHRDH() {
		return ZBFH_SHRDH;
	}
	public void setZBFH_SHRDH(String zBFHSHRDH) {
		ZBFH_SHRDH = zBFHSHRDH;
	}
	public String getZBFH_BZ() {
		return ZBFH_BZ;
	}
	public void setZBFH_BZ(String zBFHBZ) {
		ZBFH_BZ = zBFHBZ;
	}
	public String getZBFH_BZR() {
		return ZBFH_BZR;
	}
	public void setZBFH_BZR(String zBFHBZR) {
		ZBFH_BZR = zBFHBZR;
	}
	public String getZBFH_BZSJ() {
		return ZBFH_BZSJ;
	}
	public void setZBFH_BZSJ(String zBFHBZSJ) {
		ZBFH_BZSJ = zBFHBZSJ;
	}
	public String getTHDH() {
		return THDH;
	}
	public void setTHDH(String tHDH) {
		THDH = tHDH;
	}
	public String getTCCLJG() {
		return TCCLJG;
	}
	public void setTCCLJG(String tCCLJG) {
		TCCLJG = tCCLJG;
	}
	public String getSLDGXM() {
		return SLDGXM;
	}
	public void setSLDGXM(String sLDGXM) {
		SLDGXM = sLDGXM;
	}
	
}
