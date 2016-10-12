({
	toggleToolTip: function(component, event, helper) {
        var context = component.get("v.context");
        if(!context || context === ""){
            component.set("v.showError", false);
        }else{
            component.set("v.showError", true);
        }

	}
})