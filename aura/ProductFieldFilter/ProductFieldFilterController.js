({
	doInitiateProductFields : function(component, event, helper) {        
        //Initiate Operators
		helper.initiateOpreators(component);
        
        //Initiate Option List
        helper.initiateFieldList(component);
		
	},
    generateCriteria : function(component, event, helper){
	    if(component.get("v.operator")){
           component.set("v.filterCriteria",helper.generateCriteriaFilter(component));
        }
    }
    
})