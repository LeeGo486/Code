// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://192.168.0.89/MsgCenter.asmx?wsdl
// Encoding : utf-8
// Version  : 1.0
// (2012/6/21 9:46:40 - 1.33.2.5)
// ************************************************************************ //

unit MsgCenter;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns,OPconvert;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"



  // ************************************************************************ //
  // Namespace : http://yj.chinacloudtech.com/
  // soapAction: http://yj.chinacloudtech.com/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // binding   : MsgCenterSoap
  // service   : MsgCenter
  // port      : MsgCenterSoap
  // URL       : http://192.168.0.89/MsgCenter.asmx
  // ************************************************************************ //
  MsgCenterSoap = interface(IInvokable)
  ['{DF12B672-C4F6-0BEE-477F-62204EC3FC9B}']
    function  SendMsg(const Type_: WideString; const System: WideString; const Receiver: WideString; const Sender: WideString; const Content: WideString; const SendTime: WideString): WideString; stdcall;
    function  SendMsgByCom(const Type_: WideString; const System: WideString; const Receiver: WideString; const Sender: WideString; const Content: WideString; const SendTime: WideString; const Com: WideString): WideString; stdcall;
    function  SendSQL(const SQL: WideString): WideString; stdcall;
  end;

function GetMsgCenterSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): MsgCenterSoap;


implementation

function GetMsgCenterSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): MsgCenterSoap;
const
  defWSDL = 'http://192.168.0.89/MsgCenter.asmx?wsdl';
  defURL  = 'http://192.168.0.89/MsgCenter.asmx';
  defSvc  = 'MsgCenter';
  defPrt  = 'MsgCenterSoap';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  //add-------to support UTF-8
RIO.HTTPWebNode.UseUTF8InHeader := true; //添加该行，指定采用UTF-8代码传输
RIO.Converter.Encoding:='UTF-8';
RIO.Converter.Options:=RIO.Converter.Options + [soUTF8InHeader,soUTF8EncodeXML];
//add-------END

  try
    Result := (RIO as MsgCenterSoap);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(MsgCenterSoap), 'http://yj.chinacloudtech.com/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(MsgCenterSoap), 'http://yj.chinacloudtech.com/%operationName%');
  InvRegistry.RegisterExternalParamName(TypeInfo(MsgCenterSoap), 'SendMsg', 'Type_', 'Type');
  InvRegistry.RegisterExternalParamName(TypeInfo(MsgCenterSoap), 'SendMsgByCom', 'Type_', 'Type');
  InvRegistry.RegisterInvokeOptions(TypeInfo(MsgCenterSoap),ioDocument);

end.