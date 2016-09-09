({
	initiateOpportunity : function(component, event, helper) {        
        var recordId = component.get("v.recordId");                
        //Initiate Opportunity
        helper.initiateOpportunity(component, recordId);        
	},
})