<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.mapviewer.business.LayerMenuManagerSingleton"%>
<%@page import="com.mapviewer.model.Layer"%>
<%@page import="com.mapviewer.conf.OpenLayerMapConfig"%>
<html>
<head>
		<%@include file="Header.jsp" %>
</head>

<body>
<div class="loader"></div>
<% 

OpenLayerMapConfig mapConfig;
String configFilePath;
mapConfig = OpenLayerMapConfig.getInstance();

configFilePath = getServletContext().getRealPath("/WEB-INF/conf/MapViewConfig.properties");

mapConfig.updateProperties(configFilePath);

//Obtains the folder where XML layers file is stored.
String layersFolder = getServletContext().getRealPath("/layers/");
String baseLayerMenuOrientation = mapConfig.getProperty("baseLayerMenuOrientation");
LayerMenuManagerSingleton.setLayersFolder(layersFolder);
LayerMenuManagerSingleton layersManager  = LayerMenuManagerSingleton.getInstance();
String mainLayers ="";
String vectorLayers ="";
String menuIDs ="";

for(Layer layer: layersManager.getMainLayers()) {
	mainLayers = mainLayers + layer.getName() +",";
}
mainLayers = mainLayers.substring(0,mainLayers.length()-1);
for(Layer layer: layersManager.getVectorLayers()) {
	vectorLayers = vectorLayers + layer.getName() +",";
}
vectorLayers = vectorLayers.substring(0,vectorLayers.length()-1);
for(String menu: layersManager.getMenuIDs()) {
	menuIDs = menuIDs + menu +",";
}
menuIDs = menuIDs.substring(0,menuIDs.length()-1);

%>

<input type="hidden" id="mainLayers" value="<%=mainLayers%>">
<input type="hidden" id="vectorLayers" value="<%=vectorLayers%>">
<input type="hidden" id="menuIDs" value="<%=menuIDs%>">

		<!-- start: Header -->
	<%@include file="navbar.jsp" %>
	<!-- start: Header -->
	
		<div class="container-fluid-full">
		<div class="row-fluid">
				
			<!-- start: Main Menu -->
			<%@include file="Menu.jsp" %>
			<!-- end: Main Menu -->
			
<!-- 			<noscript> -->
<!-- 				<div class="alert alert-block span10"> -->
<!-- 					<h4 class="alert-heading">Warning!</h4> -->
<!-- 					<p>You need to have <a href="http://en.wikipedia.org/wiki/JavaScript" target="_blank">JavaScript</a> enabled to use this site.</p> -->
<!-- 				</div> -->
<!-- 			</noscript> -->
			
			<!-- start: Content -->
			<div id="content" class="span10 geoServerContent">
			
			
			<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href="index.jsp">Home</a> 
					<i class="icon-angle-right"></i>
				</li>
				<li>
					<a href="#">XML Configurator</a>
				</li>
			</ul>
			

        <div class="row-fluid sortable">
                <div class="box-content">
                        <div class="form-horizontal" action="#">
                                <fieldset>
                                        <div class="control-group">
                                                <label class="control-label" for="layerUrl">Enter the URL</label>
                                                <div class="controls">
                                                                <input id="layerUrl" class="span6 typeahead" type="text" name="url">
                                                                <button class="btn btn-primary" onclick="javascript:getGeoServerLayers();">Get Layers</button>
                                                </div>
                                        </div>
                                </fieldset>
                        </div>
                </div>
        </div>
        <div id="data-container"></div>
        <div id="pagination-demo1"></div>
	</div><!--/.fluid-container-->
	
			<!-- end: Content -->
		</div><!--/#content.span10-->
		</div><!--/fluid-row-->
		
	<div class="modal hide fade" id="myModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">�</button>
			<h3>Settings</h3>
		</div>
		<div class="modal-body">
			<p>Here settings can be configured...</p>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">Close</a>
			<a href="#" class="btn btn-primary">Save changes</a>
		</div>
	</div>
	
	<div class="clearfix"></div>
	
	<%@include file="footer.jsp" %>
	

</body>
</html>