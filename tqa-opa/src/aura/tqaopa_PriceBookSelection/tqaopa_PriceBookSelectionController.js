({
	cancel : function(component, event, helper) {
		var dismissActionPanel = $A.get("e.force:closeQuickAction");
		dismissActionPanel.fire();
	},
    saveOpportunity : function(component, event, helper){
        helper.saveChangesInPricebook(component);
    }
})