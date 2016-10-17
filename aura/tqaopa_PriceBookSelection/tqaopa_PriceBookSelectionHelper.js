({
	saveChangesInPricebook : function(component) {
        var opportunity = component.get("v._opportunity");
		
        var saveOpportunityRecord = component.get("c.saveOpportunityRecord");
        saveOpportunityRecord.setParams({
            "opportunityRecord": opportunity
        });
        
        saveOpportunityRecord.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                
                console.log("Create Successfully: " + state);
                this.firePricebookCheckEvent(component);
            }else{
                console.log("Failed with state: "+ state);
            }
        });
        
        $A.enqueueAction(saveOpportunityRecord);	
	},
    
    firePricebookCheckEvent : function(component){
        var OpportunityPricebookCheckEvent = component.getEvent("firePricebookCheckEvent"); 
        OpportunityPricebookCheckEvent.fire();
    
	}
})