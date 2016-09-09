({
	turnOffFilter : function(component, event, helper) {
        var isShowing = false;
        component.set("v.isShowing", isShowing);
	},    
    doInitiateProductFields : function(component, event, helper) {        
        //Initiate Operators
		helper.initiateOpreators(component);
        
        //Initiate Option List
        helper.initiateFieldList(component);
		
	},
    addColumn : function(component, event, helper) {
        var criteriaIds = component.get("v.criteriaIds");
        var timeStamp = (new Date()).getTime();
        criteriaIds.push(timeStamp+"");        
        var criteriaMap = component.get("v.criteriaMap");
        criteriaMap[timeStamp] = {};
        
        component.set("v.criteriaIds", criteriaIds);
        component.set("v.criteriaMap", criteriaMap);
    },
    clearAll : function(component, event, helper){
        component.set("v.criteriaIds", []);
        component.set("v.criteriaMap", {});
    },
    calculateCondition : function(component, event, helper){
        var keyword = component.get("v.keyword");
        var criteriaMap = component.get("v.criteriaMap");
        var conditions = {};        
        conditions.keyword = keyword;
        conditions.criteriaMap = criteriaMap;        
        component.set("v.conditions", conditions);                                
    },
    
    search : function(component, event, helper){
        var conditions = component.get("v.conditions");
        var searchTokenEvent = component.getEvent("searchConditions");
        searchTokenEvent.setParams({"conditions": JSON.stringify([conditions])});
        searchTokenEvent.fire();
    }
    
})