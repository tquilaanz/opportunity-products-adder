({
	toggleFilter : function(component, event, helper) {
        var toggle = component.get("v.toggle");        
        if(toggle){
            $A.util.addClass(component.find("filterToggle"), "slds-is-selected");
        }else{
            $A.util.removeClass(component.find("filterToggle"), "slds-is-selected");         
        }        
	},
    
    updateToggle : function(component, event, helper){
        var toggle = component.get("v.toggle");
        toggle = ! toggle;
        component.set("v.toggle", toggle);
    }
    
})