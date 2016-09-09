({
	initiateOpreators : function(component) {
        var operators = component.get("v.operators");
        var opratorOpts = [{"class": "optionClass","label": "--None--","value": ""}];
        for(var key in operators){
            opratorOpts.push({
                "class": "optionClass",
                "label": operators[key],
                "value": operators[key]});
        }        
        component.find("productFieldOperator").set("v.options", opratorOpts);		
	},
    
    initiateFieldList: function(component){
        var getOptionList = component.get("c.getFieldOptions");
        getOptionList.setCallback(this, function(response){
           var state = response.getState();
            var opts = [{"class": "optionClass","label": "--None--","value": ""}];
            if(component.isValid() && state === "SUCCESS"){
                component.set("v.fieldList",response.getReturnValue());
				var values = component.get("v.fieldList");

                for(var key in values){
                    opts.push({
                        "class": "optionClass",
                        "label": values[key].label,
                        "value": values[key].value});                    
                }
                component.find("productFieldList").set("v.options", opts);
            }else{
                console.log("Failed with state: "+ state);
            }
        });
        $A.enqueueAction(getOptionList);
    
	},
    
    generateCriteriaFilter : function(component){
        var criteriaValue = '';
        var fieldApiName = component.get("v.fieldName");
        var operator = component.get("v.operator");
        var fieldValue = component.get("v.fieldValue");
        var criteriaObj = {};
        criteriaObj.fieldName = fieldApiName;
        criteriaObj.operator = operator;
        criteriaObj.fieldValue = fieldValue;
        criteriaValue = JSON.stringify(criteriaObj);
        return criteriaValue;
    }
})