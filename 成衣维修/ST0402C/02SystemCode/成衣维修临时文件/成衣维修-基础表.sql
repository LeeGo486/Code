
SELECT TOP 1000 [GUID]
,DH				-- ����
,Branch			--�ֹ�˾
,DJR			--�Ǽ���
,DJSJ			--�Ǽ�����
,DPBM			--���̱���
,DPMC			--��������
,DPLX			--��������		
,DPDQ			--���̴���
,PP				--Ʒ��
,WXCBM			--ά�޲ֱ���
,WXCMC			--ά�޲�����
,DZXM			--�곤����
,DZLXDH			--�곤��ϵ�绰
,SLDG			--������
,DGLXDH			--������ϵ�绰
,SFFGKWX		--�Ƿ�˿�ά��
,VIPKH			--VIP����
,GKXM			--�˿�����
,GKLXDH			--�˿���ϵ�绰
,SFTYFFWX		--�Ƿ�ͬ�⸶��ά��
,SCSJ			--�۳�ʱ��
,JJCD			--�����̶�
,KH				--���
,YS				--��ɫ
,MS				--����
,THRQ			--�˻�����
,WTMS			--��������
,XJCD			--�¾ɳ̶�
,YSGS			--���乫˾
,YDH			--�˵���
,FHDZ			--������ַ
,SHDZ			--�ջ���ַ
,SHR			--�ջ���
,SHRLXDH		--�ջ�����ϵ�绰
,BZXX			--��ע��Ϣ
,ZT				--״̬
,WXXZ1			--ά������1
,WTD1			--�����1
,QY1			--����1
,XXD1			--�����
,WXXZ2			--ά������2
,WTD2			--�����2
,QY2			--����2
,XXD2			--�����2
,JCYY			--�������
,PDCLFS			--�жϴ���ʽ
,ZRBM			--���β���
,TX				--����
,WXBW			--ά�޲�λ����
,JHWXTS			--�ƻ�ά������
,SFSF			--�Ƿ��շ�
,SFJE			--�շѽ��
,SFNR			--�շ�����
,PJPDBZ			--Ʒ���ж���ע
,PJPDR			--Ʒ���ж���
,PJPDSJ			--Ʒ���ж�ʱ��
,TXSPR			--����������	
,TXSPSJ			--��������ʱ��
,TTSPR			--����������
,TTSPSJ			--��������ʱ��
,WXR			--ά����
,WXSJ			--ά��ʱ��		
,WXQRR			--ά��ȷ����
,WXQRSJ			--ά��ȷ��ʱ��
,DPPJ			--��������	
,DPPJYJ			--�����������
,GKPJ			--�˿�����
,GKPJYJ			--�˿��������
,XGR			--�޸���
,XGRQ			--�޸�����
,DJZT			--����״̬
,ZBFH_DH		--�ܲ�����������������
,ZBFH_YSGS		--�ܲ�����-���乫˾
,ZBFH_YSDH		--�ܲ�����-���䵥��
,ZBFH_FHDZ		--�ܲ�����-������ַ
,ZBFH_SHDZ		--�ܲ�����-�ջ���ַ
,ZBFH_SHR		--�ܲ�����-�ջ���
,ZBFH_SHRDH		--�ܲ�����-�ջ��˵绰
,ZBFH_BZ		--�ܲ�����-��ע
,ZBFH_BZR		--�ܲ�����-������
,ZBFH_BZRQ		--�ܲ�����-��������
,TCCLJG			--�˲ִ�����
,AMTSBS			--AM��ʾ��ʶ
,AMTSSJ			--AM��ʾʱ��
,THDH			--�˻�����
,POSTHFHDDZBS	--POS�˻����������ʱ�ʶ
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
 
 
 
 select zt,pdclfs,* FROM CYWXDJB --����ά�޵ǼǱ� 
 
select zbfh_bzr,zbfh_shr,zbfh_shrdh,zbfh_shdz,zbfh_fhdz,shrlxdh,sffgkwx,sftyffwx,kh,zt,sldg,wxxz1,wxxz2,pdclfs,jhwxts,tx,sfsf,* FROM CYWXDJB --����ά�޵ǼǱ� 
where dh='WX0100101420111021002'

3	111	ANDY	2011-11-08 15:13:35.000	ANDY	2011-11-08 15:13:35.000
3	111	ANDY	2011-11-08 15:13:35.000	ANDY	2011-11-08 15:13:35.000	2011-11-08 ���� 03:13:36
select zt,sldg,pjpdr,pjpdsj,xgr,xgrq,tccljg,* FROM CYWXDJB --����ά�޵ǼǱ� 
where dh='WX0100100220111108001'

update CYWXDJB set zt=1 where dh='WX0100101420101226001'

delete CYWXDJB where guid in ('ec14eded975a4c96bc5491e051ab1d59'
,'ecc96be014f44cd88cc0fd7cf796001f')


select * FROM CYWXDJB --����ά�޵ǼǱ� 
where guid='054DDDA0EB8C48C0B3EB29B2F26E538D'

delete CYWXDJB --����ά�޵ǼǱ� 
where dh='01001002'

 
 
-- ���Ҷ��� ״̬
select bh,mc,sx from 
(
select '-1' as bh ,'ȫ��' as mc,-1 as sx
union
SELECT SCFX_TYBMB.FCODE as bh, SCFX_TYBMB.FCONTENT as mc,FSEQUENCE as sx
  FROM SCFX_TYBMB
  WHERE SCFX_TYBMB.FSCOPE = '����ά��״̬'
)a order by sx


SELECT * FROM SCFX_TYBMB WHERE FSCOPE='�������'

-- ���Ҷ��� ���̣�DRP���ݿ�-�ֵ굵����
SELECT A.DEPOTID, A.D_NAME,*
  FROM F22TEST.F22TEST.dbo.J_DEPOT A  
  
  where  depotid = '01001002'
  
    SELECT employeeid, names ,telephone FROM F22TEST.F22TEST.dbo.J_EMPLOYEE  where depotid ='null'
  SELECT *
  FROM F22TEST.F22TEST.dbo.J_EMPLOYEE 
  
  SELECT FCODE, FCONTENT,*, FPARENTCODE FROM SCFX_TYBMB where fscope in('�˲ִ�����','�������������','������������','���������' ) and SCFX_TYBMB.FDELETEFLAG = 0
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
-- ���Ҷ���  ��������
--     0��ȫ��   1����Ӫ    2������

select WXCBM,WXCMC,* from PPWXCDYB
select depotid,areaid,d_name,r_name,Tel,m_type,address,d_dq,d_dd,d_lx,brandid,m_type  from J_DEPOT


SELECT SCFX_TYBMB.FCODE, SCFX_TYBMB.FCONTENT, SCFX_TYBMB.FPARENTCODE
  FROM SCFX_TYBMB
  WHERE SCFX_TYBMB.FSCOPE = '���������'  and 
  
  SELECT SCFX_TYBMB.FCODE, SCFX_TYBMB.FPARENTCODE, SCFX_TYBMB.FCONTENT
  FROM SCFX_TYBMB
  WHERE SCFX_TYBMB.FSCOPE = '������������'
  
  SELECT SCFX_TYBMB.FCODE, SCFX_TYBMB.FCONTENT, SCFX_TYBMB.FPARENTCODE
  FROM SCFX_TYBMB
  WHERE SCFX_TYBMB.FSCOPE = '�������������'
  
  
  SELECT SCFX_TYBMB.FCODE, SCFX_TYBMB.FCONTENT
  FROM SCFX_TYBMB
  WHERE SCFX_TYBMB.FSCOPE = '�˲ִ�����' and SCFX_TYBMB.FDELETEFLAG = 0
  
  
  SELECT SCFX_TYBMB.FCODE, SCFX_TYBMB.FCONTENT,*
  FROM SCFX_TYBMB
  WHERE SCFX_TYBMB.FSCOPE = 'ά��_���β���'
  
  SELECT SCFX_TYBMB.FCODE, SCFX_TYBMB.FCONTENT
  FROM SCFX_TYBMB
  WHERE SCFX_TYBMB.FSCOPE = '�ƻ�ά������'