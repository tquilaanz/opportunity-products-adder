({
	retrieveOpportunity : function(component) {
        component.set("v._opportunity_items",[]);
        this.toggleProductSelection(component);
        component.set("v.showSpinner",true);
        var recordId = component.get("v.recordId");
		var getOpportunity = component.get("c.getOpportunityRecord");
        getOpportunity.setParams(
            {
                "opportunityId": recordId
            }
        );
        getOpportunity.setCallback(this, function(response){
            var state = response.getState();
            component.set("v.showSpinner",false);
            if(component.isValid() && state === "SUCCESS"){
                component.set("v._record", response.getReturnValue());
            }else{
                console.log("Failed with state: "+ state);
            }
        });
        $A.enqueueAction(getOpportunity);
	},
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
                if(response.getReturnValue().IsSuccess){
                    component.set("v._opportunity_items",[]);                    
                    this.retrieveOpportunity(component);
                    $A.get('e.force:refreshView').fire();	                    
                }else{
                  this.handleErrorOfOppItemsCreation(response, component);  
                }
            }else{
                console.log("Failed with state: "+ state);
            }
        });
        $A.enqueueAction(createOpportunityItems);
    },
    handleErrorOfOppItemsCreation : function(response, component){
        var oppProdTable = component.find("opportunityProductTable");
        oppProdTable.handleError(response);
	},
    toggleProductSelection : function(component){
        var oppItems = component.get("v._opportunity_items");
        if(oppItems.length > 0){
        	component.set("v.showProductSelection", false);
        }else{
            component.set("v.showProductSelection", true);
        }
    } 
   
})