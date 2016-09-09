({
	checkAllCheckBoxes : function(component, event){
		var currentRecords = component.get("v.currentRecords");        
        var target = event.getSource();        
        var checkBoxValue = false;
        if(target.get("v.value")){
            checkBoxValue = true;
        }        
        for(var key in currentRecords){
            currentRecords[key].isSelected = checkBoxValue;
        }
        component.set("v.currentRecords", currentRecords);        
    },    
    checkOneUnit : function(component, event){
		var currentRecords = component.get("v.currentRecords");        
        var target = event.getSource();        
        var checkBoxValue = false;
        if(target.get("v.value")){
            checkBoxValue = true;
        }        
        for(var key in currentRecords){
            if(!currentRecords[key].isSelected){
                checkBoxValue = false;
            }
        }
        component.set("v.checkAllForCurrentPage", checkBoxValue);   
    },
    
    pageViewUpdated : function(component){
        var checkBoxValue = true;
        var currentRecords = component.get("v.currentRecords");  
        for(var key in currentRecords){
            if(!currentRecords[key].isSelected){
                checkBoxValue = false;
            }
        }
        component.set("v.checkAllForCurrentPage", checkBoxValue);   
    },
    enableAllButtons: function(component){
        $A.util.removeClass(component.find("first"), "slds-button--inverse ");
        $A.util.removeClass(component.find("next"), "slds-button--inverse ");
        $A.util.removeClass(component.find("last"), "slds-button--inverse ");
        $A.util.removeClass(component.find("previous"), "slds-button--inverse ");
        $A.util.removeClass(component.find("select"), "slds-button--inverse ");       
    },
    disableAllButtons: function(component){
        $A.util.addClass(component.find("first"), "slds-button--inverse ");
        $A.util.addClass(component.find("next"), "slds-button--inverse ");
        $A.util.addClass(component.find("last"), "slds-button--inverse ");
        $A.util.addClass(component.find("previous"), "slds-button--inverse ");
        $A.util.addClass(component.find("select"), "slds-button--inverse ");       
    },
    
    checkButtonStatus: function(component){
        var pageNumber = component.get("v.pageNumber");
        var totalPageNumber = component.get("v.totalNumber");
        if(pageNumber == 1){
            $A.util.addClass(component.find("previous"), "slds-button--inverse ");
            $A.util.addClass(component.find("first"), "slds-button--inverse ");
        }else{
            $A.util.removeClass(component.find("previous"), "slds-button--inverse ");
            $A.util.removeClass(component.find("first"), "slds-button--inverse ");
        }
        if(pageNumber == totalPageNumber){
            $A.util.addClass(component.find("next"), "slds-button--inverse");
            $A.util.addClass(component.find("last"), "slds-button--inverse");            
        }else{
           $A.util.removeClass(component.find("next"), "slds-button--inverse");
            $A.util.removeClass(component.find("last"), "slds-button--inverse"); 
        }
    }
})