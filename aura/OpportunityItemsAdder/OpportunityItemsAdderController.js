({    
    checkIfGoToSecondStep : function(component, event, helper){
        var opportunityItems = component.get("v.opportunityItems");
        if(opportunityItems.length > 0){
            component.set("v.showFirstStep",false);
        }else{
            component.set("v.showFirstStep",true);
        }
    }
    
})