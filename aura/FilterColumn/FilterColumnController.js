({
	deleteCondition : function(component, event, helper) {
       var cId = component.get("v.cId");
       var criteriaIds = component.get("v.criteriaIds");
       var criteriaMap = component.get("v.criteriaMap");
       var i = criteriaIds.length;
        while(i--){
            if((criteriaIds[i]) === cId){
               criteriaIds.splice(i,1);   
            }                              
        }
        delete criteriaMap[cId];
        component.set("v.criteriaMap", criteriaMap);      
        component.set("v.criteriaIds", criteriaIds);      
	},
    calculateCriteria : function(component, event, helper){
       
       var fieldName = component.get("v.fieldName");
       var operator = component.get("v.operator");
       var fieldValue = component.get("v.fieldValue");
       
        if(fieldName && operator){
            var cId = component.get("v.cId");
            var criteriaMap = component.get("v.criteriaMap");
            criteriaMap[cId].fieldName = fieldName;
            criteriaMap[cId].operator = operator;      
            criteriaMap[cId].fieldValue = fieldValue;   
			component.set("v.criteriaMap", criteriaMap);				            
        } 
        
        
    }
})