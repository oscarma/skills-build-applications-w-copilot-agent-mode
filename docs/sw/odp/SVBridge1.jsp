<%@ taglib uri="/view.tld" prefix="view" %>
<%@ page import="java.util.*"%>
<%@ page import="com.bs.neti.common.SVBridge"%>

<view:getValue name="config.netipath" variable="netipath"/>
<view:getValue name="request.header.host" variable="environmentURL"/>
<view:getValue name="request.operationBridge" variable="operative"/>	
<view:getValue name='request.h5Parameters' variable="h5Parameters"/>	
<view:getValue name='request.h5Errors' variable="h5hMErrors"/>	

<%		
Map hMParams = SVBridge.generateMap(h5Parameters);
Map hMErrors = null;
if(!"".equals(h5hMErrors))
	hMErrors = SVBridge.generateMap(h5hMErrors);
%>

<head>
   	<script src='/neti/generic-modules/neti-bridge.umd.js'></script>
</head>
   
<style>
   	.odpIframe{
   		border:none;
   		position:absolute;
   		max-width:995px;	    
   	}
</style>

 <iframe id="frameH5" src="<%=netipath%>odp/tester/"
	class="odpIframe"
	scrolling="no"
	name="frameH5"
	height='<%=hMParams.get("iframeHeight")%>'
	width='<%=hMParams.get("iframeWidth")%>'
	<%=hMParams.get("iframeSandbox")!=null?"sandbox="+hMParams.get("iframeSandbox"): ""%>
	<%=hMParams.get("iframeReferrerPolicy")!=null?"referrerpolicy="+hMParams.get("iframeReferrerPolicy"): ""%>
	<%=hMParams.get("iframeAllow")!=null?"allow="+hMParams.get("iframeAllow"): ""%>
></iframe>   

<script>
    const netiBridge = odpCoreCommunicationsNetiBridge.NetiBridgeComponent.getInstance({
      netiIframe: document.getElementById('frameH5'),
      netiParams: '<%=hMParams%>',
      errorParams: '<%=hMErrors%>',
      netiPath: '<%=netipath%>'
    });
    if (typeof fullNetiBridge !== 'undefined' || window.fullNetiBridge) {
    	fullNetiBridge.setUrlToReturn(netiBridge.getUrlToReturn());
    }
</script>