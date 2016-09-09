({
	createOpportunityItems : function(component,opportunityItems, recordId) {
        var createOpportunityItems = component.get("c.createOpportunityItems");
        createOpportunityItems.setParams({
            "opportunityItemJSON":JSON.stringify(opportunityItems),
            "recordId": recordId
        });
        
        createOpportunityItems.setCallback(this, function(response){
            var state = response.getState();
            component.set("v.showSpinner",false);
            if(component.isValid() && state === "SUCCESS"){
                console.log("Create Successfully: " + state);
                this.redirectToRecord(component,recordId);
            }else{
                console.log("Failed with state: "+ state);
            }
        });
        $A.enqueueAction(createOpportunityItems);		
	},
    redirectToRecord : function (component,recordId) {
        component.set("v.showSpinner",true);
        var event = document.createEvent('Event');
        event.initEvent('navigateToSObject', true, true);
        window.dispatchEvent (event);

        
	}
})