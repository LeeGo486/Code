// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://192.168.0.49/webservice/service.php?orgcode=ep&class=WS_System&wsdl
// Version  : 1.0
// (2012/12/14 15:31:59 - 1.33.2.5)
// ************************************************************************ //

unit service;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:int             - "http://www.w3.org/2001/XMLSchema"

  WSO_SOAPHeader       = class;                 { "http://www.turbocrm.com/webservice"[H] }



  // ************************************************************************ //
  // Namespace : http://www.turbocrm.com/webservice
  // ************************************************************************ //
  WSO_SOAPHeader = class(TSOAPHeader)
  private
    FPHPSESSID: WideString;
  published
    property PHPSESSID: WideString read FPHPSESSID write FPHPSESSID;
  end;


  // ************************************************************************ //
  // Namespace : http://www.turbocrm.com/webservice
  // soapAction: http://192.168.0.49/webservice/service.php?orgcode=ep&class=WS_System&method=%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : WS_SystemBinding
  // service   : WS_System
  // port      : WS_SystemPort
  // URL       : http://192.168.0.49/webservice/service.php?orgcode=ep&class=WS_System
  // ************************************************************************ //
  WS_SystemPortType = interface(IInvokable)
  ['{2C80E7C5-7F49-1FC2-11F5-487173F3D981}']
    function  BeCompatible(const allInOneVersion: WideString): WideString; stdcall;
    function  GetMessages(const userCode: WideString; const userPassword: WideString; const allInOneVersion: WideString; const pageInfo: WideString): WideString; stdcall;
    function  ReadUsers(const allInOneVersion: WideString): WideString; stdcall;
    function  UpdateUser(const allInOneVersion: WideString; const users: WideString; const signature: WideString): WideString; stdcall;
    function  WriteUsers(const users: WideString; const allInOneVersion: WideString; const signature: WideString): WideString; stdcall;
    function  deleteu8allinoneuser(const userInfoXml: WideString; const signature: WideString): WideString; stdcall;
    function  login(const user: WideString; const password: WideString; const lang: Integer): WideString; stdcall;
    procedure logout; stdcall;
    function  processU9(const queryXml: WideString): WideString; stdcall;
    function  processWithLogin(const user: WideString; const password: WideString; const queryXml: WideString): WideString; stdcall;
    function  saveu8allinoneuser(const userInfoXml: WideString; const signature: WideString): WideString; stdcall;
  end;

function GetWS_SystemPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): WS_SystemPortType;


implementation

function GetWS_SystemPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): WS_SystemPortType;
const
  defWSDL = 'http://192.168.0.49/webservice/service.php?orgcode=ep&class=WS_System&wsdl';
  defURL  = 'http://192.168.0.49/webservice/service.php?orgcode=ep&class=WS_System';
  defSvc  = 'WS_System';
  defPrt  = 'WS_SystemPort';
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
  try
    Result := (RIO as WS_SystemPortType);
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
  InvRegistry.RegisterInterface(TypeInfo(WS_SystemPortType), 'http://www.turbocrm.com/webservice', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(WS_SystemPortType), 'http://192.168.0.49/webservice/service.php?orgcode=ep&class=WS_System&method=%operationName%');
  InvRegistry.RegisterHeaderClass(TypeInfo(WS_SystemPortType), WSO_SOAPHeader, 'WSO_SOAPHeader', '');
  RemClassRegistry.RegisterXSClass(WSO_SOAPHeader, 'http://www.turbocrm.com/webservice', 'WSO_SOAPHeader');
  InvRegistry.RegisterInvokeOptions(TypeInfo(WS_SystemPortType),ioDocument);
end. 