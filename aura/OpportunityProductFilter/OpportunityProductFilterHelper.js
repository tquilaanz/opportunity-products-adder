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
        component.set("v.operatorList",opratorOpts);	
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
                component.set("v.fieldList",opts);
            }else{
                console.log("Failed with state: "+ state);
            }
        });
        $A.enqueueAction(getOptionList);
    
	},
		
})