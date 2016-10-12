({
	init : function(component, event, helper) {        
        var value = component.get("v._value");
        var text_value = component.get("v._text_value");
        var filter = component.get("v._filter");        
        helper.initiateTargetSObject(component);                
	},
    search: function(component, event, helper){
        var value = event.target.value;
        if(value && value.length > 2){
           helper.search(component, value); 
        }
    },
    itemSelected: function(component, event, helper){
        console.log("event "+event);
		$A.util.removeClass(component.find("selectedlookUp"), "slds-show");
        component.set("v._value",event.target.id);
        component.set("v._text_value",event.target.title);
    }
    
    
})