// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://192.168.0.49/webservice/service.php?orgcode=ep&class=WS_EAI&wsdl
// Version  : 1.0
// (2012/12/14 15:33:01 - 1.33.2.5)
// ************************************************************************ //

unit service1;

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
  // soapAction: http://192.168.0.49/webservice/service.php?orgcode=ep&class=WS_EAI&method=%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : WS_EAIBinding
  // service   : WS_EAI
  // port      : WS_EAIPort
  // URL       : http://192.168.0.49/webservice/service.php?orgcode=ep&class=WS_EAI
  // ************************************************************************ //
  WS_EAIPortType = interface(IInvokable)
  ['{07C03610-04AA-319E-A92D-9C1A0B74C2DF}']
    function  process(const queryXml: WideString): WideString; stdcall;
    function  processNC(const queryXml: WideString): WideString; stdcall;
  end;

function GetWS_EAIPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): WS_EAIPortType;


implementation

function GetWS_EAIPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): WS_EAIPortType;
const
  defWSDL = 'http://192.168.0.49/webservice/service.php?orgcode=ep&class=WS_EAI&wsdl';
  defURL  = 'http://192.168.0.49/webservice/service.php?orgcode=ep&class=WS_EAI';
  defSvc  = 'WS_EAI';
  defPrt  = 'WS_EAIPort';
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
    Result := (RIO as WS_EAIPortType);
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
  InvRegistry.RegisterInterface(TypeInfo(WS_EAIPortType), 'http://www.turbocrm.com/webservice', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(WS_EAIPortType), 'http://192.168.0.49/webservice/service.php?orgcode=ep&class=WS_EAI&method=%operationName%');
  InvRegistry.RegisterHeaderClass(TypeInfo(WS_EAIPortType), WSO_SOAPHeader, 'WSO_SOAPHeader', '');
  RemClassRegistry.RegisterXSClass(WSO_SOAPHeader, 'http://www.turbocrm.com/webservice', 'WSO_SOAPHeader');
  InvRegistry.RegisterInvokeOptions(TypeInfo(WS_EAIPortType),ioDocument);
end. 