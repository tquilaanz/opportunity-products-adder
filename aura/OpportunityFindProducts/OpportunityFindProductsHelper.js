({
	initiateProductList : function(component, recordId){
        var getProductsAction = component.get("c.getPriceBookEntries");
        getProductsAction.setParams({'recordId': recordId});
        
		this.callWebService(component, getProductsAction);        
    },
    callWebService : function(component, getProductsAction){
        getProductsAction.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                component.set("v.showSpinner", false);
                component.set("v.productFeeds", response.getReturnValue());   
            }else{
                console.log("Failed with state: "+ state);
            }
        });        
        $A.enqueueAction(getProductsAction);
    },
    searchProductList : function(component, recordId, conditions){
       var getProductsAction = component.get("c.getPriceBookEntriesWithConditions");
        getProductsAction.setParams({
            "recordId": recordId,
            "conditionString": conditions}); 
        this.callWebService(component, getProductsAction);
    }

})