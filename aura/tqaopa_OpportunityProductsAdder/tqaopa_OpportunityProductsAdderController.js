({
    afterOpportunityLoads: function(component, event, helper){
        component.set("v.showSpinner", false);
    },
    init : function(component, event, helper){
        helper.retrieveOpportunity(component);  
    },
    createOppProd : function(component, event, helper) {
		var selectedProducts = event.getParam("_selected_products");
        component.set("v._opportunity_items", selectedProducts);
        helper.toggleProductSelection(component);
	},
    handleOppProducts : function(component, event, helper){
    	var command = event.getParam("command");
        if(command === "save"){
            var opportunityItems = component.get("v._opportunity_items");
            var recordId = component.get("v.recordId");
            if(opportunityItems.length > 0){
                helper.createOpportunityItems(component,opportunityItems, recordId);
            }
        }else if (command === "cancel"){
            component.set("v._opportunity_items",[]);
            helper.retrieveOpportunity(component);
        }
    }
}
    
    
      
})