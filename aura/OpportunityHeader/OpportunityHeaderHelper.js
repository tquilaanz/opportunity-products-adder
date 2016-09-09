({
	initiateOpportunity : function(component, recordId) {
        var getOpportunityAction = component.get("c.getOpportunity");
        getOpportunityAction.setParams({'recordId': recordId});
        getOpportunityAction.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                component.set("v.opportunity", response.getReturnValue());
                
                component.set("v.redirectURL", "/"+recordId);
            }else{
                console.log("Failed with state: "+ state);
            }
        });        
        $A.enqueueAction(getOpportunityAction);
	},
})