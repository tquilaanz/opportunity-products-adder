({
	initiateTargetSObject : function(component) {
        var sobject = component.get("v._sobject");
        var field = component.get("v._field");
        
        //Call remote action to query result
        var getTargetSObjectName = component.get("c.getTargetSObjectName");
        
        getTargetSObjectName.setParams({
            "sobjectName":sobject,
            "fieldName":field
        });
        
        getTargetSObjectName.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
	            component.set("v._target_sobject",response.getReturnValue());
            }else{
                console.log("Failed with state: "+ state);
            } 
        });
        
        $A.enqueueAction(getTargetSObjectName);		
	},    
    search : function(component, value){
        var objectName = component.get("v._target_sobject");
        var search = component.get("c.searchKeyword");
        var filter = component.get("v._filter"); 
        search.setParams({
            "objectName": objectName,
            "value": value,
            "filter": filter
        });
        
        search.setCallback(this, function(response){
             var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
	            component.set("v.searchList",response.getReturnValue());
				$A.util.addClass(component.find("selectedlookUp"), "slds-show");
            }else{
                console.log("Failed with state: "+ state);
            } 
        });
        
        $A.enqueueAction(search);
    }
    
})