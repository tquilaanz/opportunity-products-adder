({
    init : function(component, event, helper){

        if(component.get("v._field_List").length === 0){
            helper.initiateFieldList(component);
        }
        if(!component.get("v._operator_map")){
            var operatorMap = helper.initiateOperator();
            component.set("v._operator_map", operatorMap);
            helper.updateInputType(component);
			helper.initiateOperatorValue(component);
        }
    },
    updateInputType : function(component, event, helper) {
        helper.updateInputType(component);
    },
    updateFilter : function(component, event, helper){		
        var filterUnit = helper.applyFilterUnit(component);
        var applyFilter = component.getEvent("applyFilter"); 
        applyFilter.setParams({
            "_filter_unit": filterUnit

        });
        applyFilter.fire();
    },
    updateOperator : function(component, event, helper){
        var filter_unit = component.get("v._filter_unit");
        var fieldInfo = helper.getFieldInfo(component);
        var fieldType = fieldInfo.fieldType;
        if(event.getSource().get("v.value").indexOf("null") !== -1){
            fieldType = '';
            filter_unit.value = '';
            component.set("v._filter_unit", filter_unit);
        }else{
 			if(fieldType === 'TEXTAREA' 
           || fieldType === 'PICKLIST' 
           || fieldType === 'MULTIPICKLIST'){
            fieldType = 'STRING'
        	}
        }
        component.set("v._field_type", fieldType);

    }
})