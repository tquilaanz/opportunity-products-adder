({
	cancel : function(component, event, helper) {
		component.set("v.opportunityItems",[]);
		
	},
    save : function(component, event, helper){
        var opportunityItems = component.get("v.opportunityItems");
        var recordId = component.get("v.recordId");
        if(opportunityItems.length > 0){
	        helper.createOpportunityItems(component,opportunityItems, recordId);
        }
    }
})