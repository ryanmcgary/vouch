// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
 var profiles = {window800:{height:400,width:500,center:1,status:1,menubar:0,toolbars:0,location:0,status:0,resizable:0,onUnload:unloadcallback}};
 $(function(){$(".auth_popup").popupwindow(profiles);});
 function unloadcallback(){location.reload();
 document.getElementById('coolframe').contentWindow.history.back(-1);
 	};              
