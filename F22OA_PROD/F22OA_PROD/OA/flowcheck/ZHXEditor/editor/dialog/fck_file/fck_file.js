
var oEditor		= window.parent.InnerDialogLoaded() ;
var FCK			= oEditor.FCK ;
var FCKLang		= oEditor.FCKLang ;
var FCKConfig	= oEditor.FCKConfig ;


var oFakeImage = FCK.Selection.GetSelectedElement() ;
var oEmbed ;

if ( oFakeImage )
{
	if ( oFakeImage.tagName == 'IMG' && oFakeImage.getAttribute('_fckattach') )
		oEmbed = FCK.GetRealElement( oFakeImage ) ;
	else
		oFakeImage = null ;
}

window.onload = function()
{

	oEditor.FCKLanguageManager.TranslatePage(document) ;

	LoadSelection() ;


	GetE('tdBrowse').style.display = FCKConfig.AttachBrowser	? '' : 'none' ;

	if ( FCKConfig.AttachUpload )
		GetE('frmUpload').action = FCKConfig.AttachUploadURL ;

	window.parent.SetAutoSize( true ) ;
	window.parent.SetOkButton( true ) ;
}

function LoadSelection()
{
	if ( ! oEmbed ) return ;

	var sUrl = GetAttribute( oEmbed, 'src', '' ) ;

	GetE('txtUrl').value    = GetAttribute( oEmbed, 'src', '' ) ;

	// Get Advances Attributes
	GetE('txtAttId').value		= oEmbed.id ;

	
	GetE('txtAttTitle').value		= oEmbed.title ;

	if ( oEditor.FCKBrowserInfo.IsIE )
	{
		GetE('txtAttClasses').value = oEmbed.getAttribute('className') || '' ;
		GetE('txtAttStyle').value = oEmbed.style.cssText ;
	}
	else
	{
		GetE('txtAttClasses').value = oEmbed.getAttribute('class',2) || '' ;
		GetE('txtAttStyle').value = oEmbed.getAttribute('style',2) ;
	}

	UpdatePreview() ;
}


function UpdateEmbed( e )
{

	e.src = GetE('txtUrl').value ;
	
	// Advances Attributes

	SetAttribute( e, 'id'	, GetE('txtAttId').value ) ;
	SetAttribute( e, 'title'	, GetE('txtAttTitle').value ) ;

	if ( oEditor.FCKBrowserInfo.IsIE )
	{
		SetAttribute( e, 'className', GetE('txtAttClasses').value ) ;
		e.style.cssText = GetE('txtAttStyle').value ;
	}
	else
	{
		SetAttribute( e, 'class', GetE('txtAttClasses').value ) ;
		SetAttribute( e, 'style', GetE('txtAttStyle').value ) ;
	}
}

var ePreview ;

function SetPreviewElement( previewEl )
{
	ePreview = previewEl ;
	
	if ( GetE('txtUrl').value.length > 0 )
		UpdatePreview() ;
}

function UpdatePreview()
{
	if ( !ePreview )
		return ;
		
	while ( ePreview.firstChild )
		ePreview.removeChild( ePreview.firstChild ) ;

	if ( GetE('txtUrl').value.length == 0 )
		ePreview.innerHTML = '&nbsp;' ;
	else
	{
		var oDoc	= ePreview.ownerDocument || ePreview.document ;
		var e		= oDoc.createElement( 'EMBED' ) ;
		
		e.src		= GetE('txtUrl').value ;

		
		ePreview.appendChild( e ) ;
	}
}


function BrowseServer()
{
	OpenFileBrowser( FCKConfig.AttachBrowserURL, FCKConfig.AttachBrowserWindowWidth, FCKConfig.AttachBrowserWindowHeight ) ;
}

function SetUrl( url, width, height )
{
	GetE('txtUrl').value = url ;


	UpdatePreview() ;

	window.parent.SetSelectedTab( 'Info' ) ;
}

function OnUploadCompleted( errorNumber, fileUrl, fileName, customMsg )
{
	switch ( errorNumber )
	{
		case 0 :	// No errors
			alert( 'Your file has been successfully uploaded' ) ;
			break ;
		case 1 :	// Custom error
			alert( customMsg ) ;
			return ;
		case 101 :	// Custom warning
			alert( customMsg ) ;
			break ;
		case 201 :
			alert( 'A file with the same name is already available. The uploaded file has been renamed to "' + fileName + '"' ) ;
			break ;
		case 202 :
			alert( 'Invalid file type' ) ;
			return ;
		case 203 :
			alert( "Security error. You probably don't have enough permissions to upload. Please check your server." ) ;
			return ;
		default :
			alert( 'Error on file upload. Error number: ' + errorNumber ) ;
			return ;
	}

	SetUrl( fileUrl ) ;
	GetE('frmUpload').reset() ;
}

var oUploadAllowedExtRegex	= new RegExp( FCKConfig.AttachUploadAllowedExtensions, 'i' ) ;
var oUploadDeniedExtRegex	= new RegExp( FCKConfig.AttachUploadDeniedExtensions, 'i' ) ;

function CheckUpload()
{
	var sFile = GetE('txtUploadFile').value ;
	
	if ( sFile.length == 0 )
	{
		alert( 'Please select a file to upload' ) ;
		return false ;
	}
	
	if ( ( FCKConfig.AttachUploadAllowedExtensions.length > 0 && !oUploadAllowedExtRegex.test( sFile ) ) ||
		( FCKConfig.AttachUploadDeniedExtensions.length > 0 && oUploadDeniedExtRegex.test( sFile ) ) )
	{
		OnUploadCompleted( 202 ) ;
		return false ;
	}
	
	return true ;
}



