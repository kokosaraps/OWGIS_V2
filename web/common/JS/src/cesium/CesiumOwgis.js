goog.provide('owgis.cesium');

goog.require('owgis.ncwms.currents.particles');
goog.require('owgis.error.texts');
goog.require('owgis.error.popover');
goog.require('olcs.OLCesium');
goog.require('owgis.interf');

var CESIUM_BASE_URL="./common/JS/vendor/minimized/";

var reduceNumberStreamLinesBy = 2;// n times less particles than non cesium

function validateWebGL(){
	//First thing is to validate that WebGL is supported by the browser
	var pass = true;
	if (!window.WebGLRenderingContext) {
		// the browser doesn't even know what WebGL is
		pass = false;
	} else {
		var canvas = getElementById('testWebGLCanvas');    
		var context = canvas.getContext("webgl");
		if (!context) {
			// browser supports WebGL but initialization failed.
			pass = false;
		}
	}

	if(!pass){
		owgis.error.popover.create(owgis.error.texts._NO_WEBGL,
		"http://get.webgl.org/troubleshooting");
		return false;
	}else{
		return true;
	}
}

function initCesium(){
	_cesium = new olcs.OLCesium({map: map});
	_cesium.setEnabled(true);
	//Start the currents animation of 'static' day.
	
	var c_scene = _cesium.getCesiumScene();
	// Don't show the border of the world
	c_scene.skyAtmosphere.show = false;
	// Don't allow tilt with the camera
	c_scene.screenSpaceCameraController.enableTilt = false;
	
	//Set the view depending on the current resolution
	var res = map.getView().getResolution();
	var cam = _cesium.getCamera();
	cam.setAltitude(res*200000000);
	
	owgis.layouts.draggable.topmenu.isUsed('.cesiumSpan');
	cesiumParticles(false);
	owgis.interf.loadingallscreen(false);
}

function cesiumParticles(wasEnabled){
	//Start the currents animation of 'static' day.
	if(_mainlayer_streamlines){
		//We need to restore the number of streamlines
		var totParticles;
		if(wasEnabled){
			totParticles = Math.floor(owgis.ncwms.currents.particles.getNumParticles()*reduceNumberStreamLinesBy);
		}else{
			totParticles = Math.floor(owgis.ncwms.currents.particles.getNumParticles()/reduceNumberStreamLinesBy);
		}
		owgis.ncwms.currents.particles.setNumParticles(totParticles);
		owgis.ncwms.currents.style.updateNumberOfParticlesSliders(totParticles);
		owgis.ncwms.currents.startSingleDateAnimation();
	}
}

/**
 * This function is in charge of initializing the Cesium Sphere and
 * the switching from Ol3 when is already initialized.  
 * @returns {undefined}
 */
owgis.cesium.toogleCesium= function toogleCesium(){
	// In this case is the first time the button has been clicked
	console.log("Toggle Cesium");
	owgis.interf.loadingallscreen(true);
	if(_.isEmpty(_cesium)){
		if(validateWebGL()){
			$.getScript( CESIUM_BASE_URL+"Cesium.js")
					.done(function( data, textStatus) {
						if( typeof ocl !== 'undefined'){
							initCesium();
				}else{
					$.getScript("./common/JS/vendor/minimized/ol3cesium.js")
							.done(function( data, textStatus) {
								initCesium();
					})//done
							.fail(function( jqxhr, settings, exception){
								console.log("Fail to load ol3cesium.js: "+exception);
						owgis.error.popover.create(owgis.error.texts._OL3CESIUM); });
				}//Else
			})//Second done
					.fail(function( jqxhr, settings, exception){
						console.log("Fail to load Cesium.js: "+exception);
				owgis.error.popover.create(owgis.error.texts._CESIUM); });
		}//Validate WebGL
	}else{
		var wasEnabled = _cesium.getEnabled();
		_cesium.setEnabled(!wasEnabled);
		cesiumParticles(wasEnabled);
		owgis.interf.loadingallscreen(false);
	}
}
