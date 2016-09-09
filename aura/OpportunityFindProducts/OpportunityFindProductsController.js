({
    initiateProductList : function(component, event, helper){
        var recordId = component.get("v.recordId");
        //Initiate Product List
        helper.initiateProductList(component, recordId);
    },
    toggleFilter : function(component, event){
        var toggleCheck = event.getParam("toggle");
        component.set("v.toggle", toggleCheck);
    },
    searchProducts : function(component, event, helper){
        var conditionString = event.getParam("conditions");
		var recordId = component.get("v.recordId");
        helper.searchProductList(component, recordId, conditionString);        
    }
})