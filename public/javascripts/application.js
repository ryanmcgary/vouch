// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
 var profiles = {window800:{height:400,width:400,center:1,status:1,menubar:0,toolbars:0,location:0,status:0,resizable:0,onUnload:unloadcallback}};
 $(function(){$(".auth_provider").popupwindow(profiles);});
 function unloadcallback(){location.reload();  
 	};              