unit CYWXINTOCRMFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGridEh, StdCtrls, AdvGroupBox, xmldom,
  XMLIntf, msxmldom, XMLDoc, ComCtrls, ExtCtrls;
  type   TMyGrid   =   class(TDBGridEH);
type
  TCYWXINTOCRMForm = class(TForm)
    grp1: TAdvGroupBox;
    grp2: TAdvGroupBox;
    grp3: TAdvGroupBox;
    dbgrdh1: TDBGridEh;
    qry1: TADOQuery;
    ds1: TDataSource;
    con1: TADOConnection;
    CRM: TADOConnection;
    qry2: TADOQuery;
    lbl1: TLabel;
    btn1: TButton;
    lbl2: TLabel;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    qry3: TADOQuery;
    xmldcmnt1: TXMLDocument;
    btn5: TButton;
    tmr2: TTimer;
    dtp1: TDateTimePicker;
    edt1: TEdit;
    tmr1: TTimer;
    btn6: TButton;
    btn7: TButton;
    procedure btn4Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure dbgrdh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure tmr2Timer(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CYWXINTOCRMForm: TCYWXINTOCRMForm;
  BS:STRING;
implementation
  uses  service,service1,MsgCenter;
{$R *.dfm}

procedure TCYWXINTOCRMForm.btn4Click(Sender: TObject);
begin
  close;
end;

procedure TCYWXINTOCRMForm.btn1Click(Sender: TObject);
begin
  with qry1 do
  begin
    close;
    sql.Clear;
    sql.Add(' select * from CYWXDJB where (vipkh is not null and vipkh<>'''') and bsw is  null  order by dpbm');
    open;
  end;
  BS:='1';
  
end;

procedure TCYWXINTOCRMForm.dbgrdh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  case ds1.DataSet.RecNo   mod   2   =   0   of //如果是奇数行显示的颜色是00DDE8FF，偶数行显示时clwhite
     True:   dbgrdh1.Canvas.Brush.Color   :=   clwhite;
     False:   dbgrdh1.Canvas.Brush.Color   :=$00FFFFE1;
  end;
  dbgrdh1.DefaultDrawColumnCell(rect,datacol,column,state);



  with   dbgrdh1  do
  with   Canvas   do
  begin
    if  TMyGrid(dbgrdh1).Row   =   MouseCoord(Rect.Left+1,   Rect.Top+1).Y   then
    begin
      Canvas.Brush.Color   :=  $0088FFFF;
      Canvas.Font.Color :=clblack;
    end;
    DefaultDrawColumnCell(Rect,   DataCol,   Column,   State);
  end;
end;

procedure TCYWXINTOCRMForm.btn2Click(Sender: TObject);
begin
  with qry1 do
  begin
    close;
    sql.Clear;
    sql.Add(' select * from CYWXDJB where gkxm in  ');
    sql.Add(' (select gkxm from (select gkxm,count(gkxm) num ');
    sql.Add(' from CYWXDJB where (vipkh is null or vipkh='''') ');
    sql.Add(' group by gkxm) a where num=''1'') and bsw is null order by dpbm ');
    open;
  end;
  BS:='2';
end;

procedure TCYWXINTOCRMForm.btn3Click(Sender: TObject);
var
 service:WS_SystemPortType;
 service1:WS_EAIPortType;
 head1:WSO_SOAPHeader;
 user, password  :string;
 lang :Integer;
 rStr,rStr1,rStr2 :string;
 jugetest,DEPT_ID,STSubject,customerID,STime,ACCOUNT_NAME,account_id:string;
 S1,S2,S3:STRING;
 VIPKH,GKXM,DPBM,DJSJ,DEPT_NAME,KH,KSMC,WTMS,WXXZ,WTD,QY,XXD,PDCLFS,DH,PDW:STRING;

begin
  user:='admin';
  password:='';
  lang:=2;

  //SHOWMESSAGE(BS);


  IF BS='1' THEN
  BEGIN
    WITH QRY1 DO
    BEGIN
      FIRST;
      WHILE NOT EOF DO
      BEGIN
        VIPKH:=trim(dbgrdh1.datasource.dataset.fieldbyname('VIPKH').asstring);
        GKXM:=trim(dbgrdh1.datasource.dataset.fieldbyname('GKXM').asstring);
        DPBM:=trim(dbgrdh1.datasource.dataset.fieldbyname('DPBM').asstring);
        DJSJ:=trim(dbgrdh1.datasource.dataset.fieldbyname('DJSJ').asstring);
        KH:=trim(dbgrdh1.datasource.dataset.fieldbyname('KH').asstring);
        WTMS:=trim(dbgrdh1.datasource.dataset.fieldbyname('WTMS').asstring);
        WXXZ:=trim(dbgrdh1.datasource.dataset.fieldbyname('WXXZ1').asstring);
        WTD:=trim(dbgrdh1.datasource.dataset.fieldbyname('WTD1').asstring);
        QY:=trim(dbgrdh1.datasource.dataset.fieldbyname('QY1').asstring);
        XXD:=trim(dbgrdh1.datasource.dataset.fieldbyname('XXD1').asstring);
        PDCLFS:=trim(dbgrdh1.datasource.dataset.fieldbyname('PDCLFS').asstring);
        DH:=trim(dbgrdh1.datasource.dataset.fieldbyname('DH').asstring);
        STSubject:='成衣维修单('+''+DH+''+')';

        //取CRM店铺编号，顾客姓名，客户ID
        WITH QRY2 DO
        BEGIN
          CLOSE;
          SQL.Clear;
          SQL.Add(' SELECT account_id,DEPT_ID,ACCOUNT_NAME FROM  tc_account where  account_simple_code='''+VIPKH+''' ');
          //SHOWMESSAGE(SQL.TEXT);
          OPEN;
          DEPT_ID:=TRIM(fieldbyname('DEPT_ID').asstring);
          ACCOUNT_NAME:=TRIM(fieldbyname('ACCOUNT_NAME').asstring);
          account_id:=TRIM(fieldbyname('account_id').asstring);
        end;
        //取店铺名称
        WITH QRY2 DO
        BEGIN
          CLOSE;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT DEPT_NAME FROM tc_department WHERE identify_code='''+TRIM(DPBM)+'''');
          //SHOWMESSAGE(SQL.TEXT);
          OPEN;
          DEPT_NAME:=TRIM(fieldbyname('DEPT_NAME').asstring);
        end;
        //取款式名称
        WITH QRY2 DO
        BEGIN
          CLOSE;
          SQL.Clear;
          SQL.Add('select DISTINCT prod_name from tc_product where prod_code='''+KH+'''');
          //SHOWMESSAGE(SQL.TEXT);
          OPEN;
          KSMC:=TRIM(fieldbyname('prod_name').asstring);
        end;

        //SHOWMESSAGE(STSubject);
        //SHOWMESSAGE(VIPKH);
        //SHOWMESSAGE(GKXM);
        //SHOWMESSAGE(DEPT_ID);
        //SHOWMESSAGE(ACCOUNT_NAME);
        //SHOWMESSAGE(account_id);
        //SHOWMESSAGE(DEPT_NAME);
        S1:='客户('+''+ACCOUNT_NAME+''+')于'+''+DJSJ+''+'在'+''+DEPT_NAME+''+'对款号为'+''+KH+''+'('+''+KSMC+''+')要求进行维修,问题点为(';
        S2:=''+S1+''+''+WTMS+''+'),经品检判定结果为:维修性质 '+''+WXXZ+''+',问题点 '+''+WTD+''+',起因 '+''+QY+''+',现象点 '+''+XXD+''+',判定处理方式 '+''+PDCLFS+''+'.'  ;
        //SHOWMESSAGE(S2);
        
        //EXIT;
        try
        begin
          service := GetWS_SystemPortType(False,'');
          service1 := GetWS_EAIPortType(False,'');
          rStr:=service.login(user,password,lang );

          {if rStr<>'' then
          begin
            showmessage( rStr );
          end
          else
          begin
            showmessage('cuowu');
          end;}

          jugetest :='<Interface type="add" model="object" value ="KHWH" lang="2" withDetail="0"><Row>';
          jugetest :=jugetest+'<KHWH.CreatedByID>35756</KHWH.CreatedByID>';                           //固定
          jugetest :=jugetest+'<KHWH.DepartmentID>'+''+TRIM(DEPT_ID)+''+'</KHWH.DepartmentID>';
          jugetest :=jugetest+'<KHWH.OwnerID>35756</KHWH.OwnerID>';
          jugetest :=jugetest+'<KHWH.GTFS>1003</KHWH.GTFS>';
          jugetest :=jugetest+'<KHWH.org_id>1</KHWH.org_id>';
          jugetest :=jugetest+'<KHWH.Privilege1>'+''+TRIM(DEPT_ID)+''+'</KHWH.Privilege1>';
          jugetest :=jugetest+'<KHWH.TypeID>2094</KHWH.TypeID>';                                  //固定
          jugetest :=jugetest+'<KHWH.Name>'+''+trim(STSubject)+''+'</KHWH.Name>';                 //主题
          jugetest :=jugetest+'<KHWH.CreateTime>'+''+trim(DJSJ)+''+'</KHWH.CreateTime>';         //STIME 发送时间
          jugetest :=jugetest+'<KHWH.customerID>'+''+trim(account_id)+''+'</KHWH.customerID>';      //通过手机号去取
          jugetest :=jugetest+'<KHWH.Description>'+''+trim(S2)+''+'</KHWH.Description></Row></Interface>';  //内容


          try
          begin
            rStr1:=service1.process(jugetest);
            s3 := copy(rStr1,pos('success="',rStr1) + 9,4);
            //showmessage(s3);
            if s3='fals' then
            begin

            end;

            if s3='true' then
            begin
              with qry3 do
              begin
                close;
                sql.Clear;
                sql.Add('update CYWXDJB set bsw=''1'' where dh='''+DH+''' ');
                execsql;
              end;
            end;


            
            {if rStr1<>'' then
            begin
              showmessage( rStr1 );
            end
            else
            begin
              showmessage('cuowu1');
            end;}
          end;
          finally
            service1 := nil;
          end;
        end;
        finally
          service := nil;
        end;



        NEXT;
      end;
    end;
    btn1.Click;
  end;

  IF BS='2' THEN
  BEGIN
    WITH QRY1 DO
    BEGIN
      FIRST;
      WHILE NOT EOF DO
      BEGIN
        //VIPKH:=trim(dbgrdh1.datasource.dataset.fieldbyname('VIPKH').asstring);
        GKXM:=trim(dbgrdh1.datasource.dataset.fieldbyname('GKXM').asstring);
        DPBM:=trim(dbgrdh1.datasource.dataset.fieldbyname('DPBM').asstring);
        DJSJ:=trim(dbgrdh1.datasource.dataset.fieldbyname('DJSJ').asstring);
        KH:=trim(dbgrdh1.datasource.dataset.fieldbyname('KH').asstring);
        WTMS:=trim(dbgrdh1.datasource.dataset.fieldbyname('WTMS').asstring);
        WXXZ:=trim(dbgrdh1.datasource.dataset.fieldbyname('WXXZ1').asstring);
        WTD:=trim(dbgrdh1.datasource.dataset.fieldbyname('WTD1').asstring);
        QY:=trim(dbgrdh1.datasource.dataset.fieldbyname('QY1').asstring);
        XXD:=trim(dbgrdh1.datasource.dataset.fieldbyname('XXD1').asstring);
        PDCLFS:=trim(dbgrdh1.datasource.dataset.fieldbyname('PDCLFS').asstring);
        DH:=trim(dbgrdh1.datasource.dataset.fieldbyname('DH').asstring);
        STSubject:='成衣维修单('+''+DH+''+')';


        //取CRM店铺编号，顾客姓名，客户ID
        WITH QRY2 DO
        BEGIN
          CLOSE;
          SQL.Clear;
          SQL.Add(' SELECT account_id,DEPT_ID,ACCOUNT_NAME FROM  tc_account where  ACCOUNT_NAME='''+GKXM+''' ');
          //SHOWMESSAGE(SQL.TEXT);
          OPEN;
          DEPT_ID:=TRIM(fieldbyname('DEPT_ID').asstring);
          ACCOUNT_NAME:=TRIM(fieldbyname('ACCOUNT_NAME').asstring);
          account_id:=TRIM(fieldbyname('account_id').asstring);
        end;
        //取店铺名称
        WITH QRY2 DO
        BEGIN
          CLOSE;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT DEPT_NAME FROM tc_department WHERE identify_code='''+TRIM(DPBM)+'''');
          //SHOWMESSAGE(SQL.TEXT);
          OPEN;
          DEPT_NAME:=TRIM(fieldbyname('DEPT_NAME').asstring);
        end;
        //取款式名称
        WITH QRY2 DO
        BEGIN
          CLOSE;
          SQL.Clear;
          SQL.Add('select DISTINCT prod_name from tc_product where prod_code='''+KH+'''');
          //SHOWMESSAGE(SQL.TEXT);
          OPEN;
          KSMC:=TRIM(fieldbyname('prod_name').asstring);
        end;

        //SHOWMESSAGE(STSubject);
        //SHOWMESSAGE(VIPKH);
        //SHOWMESSAGE(GKXM);
        //SHOWMESSAGE(DEPT_ID);
        //SHOWMESSAGE(ACCOUNT_NAME);
        //SHOWMESSAGE(account_id);
        //SHOWMESSAGE(DEPT_NAME);
        S1:='客户('+''+ACCOUNT_NAME+''+')于'+''+DJSJ+''+'在'+''+DEPT_NAME+''+'对款号为'+''+KH+''+'('+''+KSMC+''+')要求进行维修,问题点为(';
        S2:=''+S1+''+''+WTMS+''+'),经品检判定结果为:维修性质 '+''+WXXZ+''+',问题点 '+''+WTD+''+',起因 '+''+QY+''+',现象点 '+''+XXD+''+',判定处理方式 '+''+PDCLFS+''+'.'  ;
        //SHOWMESSAGE(S2);
        
        //EXIT;
        try
        begin
          service := GetWS_SystemPortType(False,'');
          service1 := GetWS_EAIPortType(False,'');
          rStr:=service.login(user,password,lang );

          {if rStr<>'' then
          begin
            showmessage( rStr );
          end
          else
          begin
            showmessage('cuowu');
          end;}

          jugetest :='<Interface type="add" model="object" value ="KHWH" lang="2" withDetail="0"><Row>';
          jugetest :=jugetest+'<KHWH.CreatedByID>35756</KHWH.CreatedByID>';                           //固定
          jugetest :=jugetest+'<KHWH.DepartmentID>'+''+TRIM(DEPT_ID)+''+'</KHWH.DepartmentID>';
          jugetest :=jugetest+'<KHWH.OwnerID>35756</KHWH.OwnerID>';
          jugetest :=jugetest+'<KHWH.GTFS>1003</KHWH.GTFS>';
          jugetest :=jugetest+'<KHWH.org_id>1</KHWH.org_id>';
          jugetest :=jugetest+'<KHWH.Privilege1>'+''+TRIM(DEPT_ID)+''+'</KHWH.Privilege1>';
          jugetest :=jugetest+'<KHWH.TypeID>2094</KHWH.TypeID>';                                  //固定
          jugetest :=jugetest+'<KHWH.Name>'+''+trim(STSubject)+''+'</KHWH.Name>';                 //主题
          jugetest :=jugetest+'<KHWH.CreateTime>'+''+trim(DJSJ)+''+'</KHWH.CreateTime>';         //STIME 发送时间
          jugetest :=jugetest+'<KHWH.customerID>'+''+trim(account_id)+''+'</KHWH.customerID>';      //通过手机号去取
          jugetest :=jugetest+'<KHWH.Description>'+''+trim(S2)+''+'</KHWH.Description></Row></Interface>';  //内容

          try
          begin
            rStr1:=service1.process(jugetest);
            s3 := copy(rStr1,pos('success="',rStr1) + 9,4);
            //showmessage(s3);
            if s3='fals' then
            begin

            end;

            if s3='true' then
            begin
              with qry3 do
              begin
                close;
                sql.Clear;
                sql.Add('update CYWXDJB set bsw=''1'' where dh='''+DH+''' ');
                execsql;
              end;
            end;


            {if rStr1<>'' then
            begin
              showmessage( rStr1 );
            end
            else
            begin
              showmessage('cuowu1');
            end;}
          end;
          finally
            service1 := nil;
          end;
        end;
        finally
          service := nil;
        end;



        NEXT;
      end;
    end;
    
    btn2.Click;
  end;




end;

procedure TCYWXINTOCRMForm.btn5Click(Sender: TObject);
var
  str,rStr1:string;
begin
  rStr1:='sadasdadadadad""""======"""""success="true"asdasdasdasdasda';
  str := copy(rStr1,pos('success="',rStr1) + 9,4);
  showmessage(str);
end;

procedure TCYWXINTOCRMForm.tmr2Timer(Sender: TObject);
var
  dt1:string;
begin
  dtp1.DateTime:=Now();
  datetimetostring(dt1,'hh:mm',dtp1.DateTime);
  edt1.Text:=Trim(dt1);
end;

procedure TCYWXINTOCRMForm.tmr1Timer(Sender: TObject);
var
 Msgsend:MsgCenterSoap;
 TypeID, SystemmID  ,Receiver, SenderID, Content, SendTime,DT1:string;

begin
  if  edt1.Text='23:59' then
  begin
    btn1.Click;
    btn3.Click;
    btn2.Click;
    btn3.Click;
    WITH QRY3 do
    begin
      CLOSE;
      SQL.CLEAR;
      SQL.ADD('SELECT  CONVERT(VARCHAR(100),GETDATE(),21) AS TT');
      OPEN;
      DT1:=Trim(FIELDBYNAME('TT').AsString);
    end;
    TypeID:='AM';
    SystemmID:='CRM';
    SenderID:='信息部服务中心';
    Receiver:='赵振';
    Content:='您好，成衣维修数据回写成功！';
    SendTime:=''+DT1+'';
    Msgsend := GetMsgCenterSoap(False,'');
    Msgsend.SendMsg(TypeID, SystemmID ,Receiver, SenderID, Content, SendTime);

    TypeID:='AM';
    SystemmID:='CRM';
    SenderID:='信息部服务中心';
    Receiver:='沈洪彬';
    Content:='您好，成衣维修数据回写成功！';
    SendTime:=''+DT1+'';
    Msgsend := GetMsgCenterSoap(False,'');
    Msgsend.SendMsg(TypeID, SystemmID ,Receiver, SenderID, Content, SendTime);


    TypeID:='AM';
    SystemmID:='CRM';
    SenderID:='信息部服务中心';
    Receiver:='王樑';
    Content:='您好，成衣维修数据回写成功！';
    SendTime:=''+DT1+'';
    Msgsend := GetMsgCenterSoap(False,'');
    Msgsend.SendMsg(TypeID, SystemmID ,Receiver, SenderID, Content, SendTime);
  end;
end;

procedure TCYWXINTOCRMForm.btn6Click(Sender: TObject);
begin
  tmr1.Enabled:=True;
  btn6.Enabled:=false;
end;

procedure TCYWXINTOCRMForm.btn7Click(Sender: TObject);
begin
  tmr1.Enabled:=False;
  btn6.Enabled:=true;
end;

end.
