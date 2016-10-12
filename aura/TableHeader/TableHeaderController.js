({
    init : function(component, event, helper) {
        if(component.get("v.required")){
     		component.set("v.requiredClass", "requiredLabel");
		}
    },
    setOrderBy : function(component, event, helper) {
        if(component.get("v.disableOrderBy")){
            return;
        }
		component.set("v.orderBy", component.get("v.label"));
        helper.switchArrow(component);
	},
    switchOnIcons : function(component, event, helper) {
        var orderBy = component.get("v.orderBy");
        var label = component.get("v.label");
        if(label === orderBy){
            component.set("v.showIcons", true);
        }else{
            component.set("v.showIcons", false);
        }
    },
    updateIconClass : function(component, event, helper){
        if(component.get("v.showIcons")){
            component.set("v.iconClass","slds-show");
        }else{
            component.set("v.iconClass","slds-hide");            
        }
    }
})