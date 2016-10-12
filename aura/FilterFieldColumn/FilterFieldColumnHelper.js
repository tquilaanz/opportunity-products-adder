({
    initiateFieldList: function(component){
        var getOptionList = component.get("c.getFieldOptions");
        var sobjectName = component.get("v._sobject_name");
        getOptionList.setParams ({'sobjectName': sobjectName});
        getOptionList.setCallback(this, function(response){
           var state = response.getState();
            var opts = [{"class": "optionClass","label": "--None--","value": ""}];
            if(component.isValid() && state === "SUCCESS"){
                this.initiatePrePopulateValue(component,response.getReturnValue());				
            }else{
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(getOptionList);
	},
    initiateOperatorValue: function(component){
        var fieldUnit = component.get("v._filter_unit");
        var operatorList = component.get("v._operator_list");
        for(var key in operatorList){
            if(operatorList[key].value === fieldUnit.operator){
                operatorList[key].selected = true;
            }
        }

        component.set("v._operator_list", operatorList);
        if(fieldUnit.operator && fieldUnit.operator.indexOf("null") !== -1){
        	component.set("v._field_type", '');
        }
        
    },
    initiatePrePopulateValue: function(component, fieldList){
        var fieldUnit = component.get("v._filter_unit");
        for(var key in fieldList){
            if(fieldList[key].value === fieldUnit.field){
                fieldList[key].selected = true;
            }
        }
        component.set("v._field_List",fieldList);	
    },
    updateInputType : function(component) {
        var fieldInfo = this.getFieldInfo(component);
		var fieldType = fieldInfo.fieldType;
        var operatorMap = component.get("v._operator_map");
        var operatorList = operatorMap[fieldType];
        if(!operatorList){
            operatorList = operatorMap["Other"];
        }
        if(fieldType === 'TEXTAREA' 
           || fieldType === 'PICKLIST' 
           || fieldType === 'MULTIPICKLIST'){
            fieldType = 'STRING'
        }
        component.set("v._field_type", fieldType);
        component.set("v._operator_list", operatorList);
    },
    applyFilterUnit : function(component){
        var filterUnit = this.getFieldInfo(component);
        filterUnit.operatorlabel = this.getOperatorLabel(component);
        return filterUnit; 
    },    
    getOperatorLabel: function(component){
        var fieldUnit = component.get("v._filter_unit");
        var _operator_list = component.get("v._operator_list");
        var operatorLabel = '';
        for(var operatorKey in _operator_list){
            var operatorEntity = _operator_list[operatorKey];
            if(operatorEntity.value === fieldUnit.operator){
                operatorLabel = operatorEntity.label;
            }
        }
        return operatorLabel;
    },
    getFieldInfo: function(component){
        var fieldList = component.get("v._field_List");         
        var fieldUnit = component.get("v._filter_unit");
        var field = fieldUnit.field; 

        var fieldType = '';
        for(var key in fieldList){
            var fieldEntity = fieldList[key];
            if(fieldEntity.value === field){
                fieldUnit.fieldType = fieldEntity.type;
                fieldUnit.label = fieldEntity.label;
            }
        }
        return fieldUnit;
    },
    initiateOperator : function(){
        var operatorMap = {
            "Other": [{"label": "=  equals", "value":"=", "selected":false},
                      {"label": "≠  not equals", "value":"!=", "selected":false},
                       {"label": "≈  like", "value":"like", "selected":false},
                       {"label": "≉  not like", "value":"not like", "selected":false},                      
                      {"label": "∅  null", "value":" = null ", "selected":false},
                      {"label": "∃  not null", "value":" != null ", "selected":false}],
            "DOUBLE": [{"label": "=  equals", "value":"=", "selected":false},
                      {"label": "≠  not equals", "value":"!=", "selected":false},
                       {"label": "≥  greater or equals", "value":">= ", "selected":false},
                       {"label": ">  greater", "value":">", "selected":false},
                       {"label": "≤  less or equals", "value":"<=", "selected":false},
                       {"label": "<  less", "value":"<", "selected":false},
                      {"label": "∅  null", "value":" = null ", "selected":false},
                      {"label": "∃  not null", "value":" != null ", "selected":false}],
            "INTEGER": [{"label": "=  equals", "value":"=", "selected":false},
                      {"label": "≠  not equals", "value":"!=", "selected":false},
                       {"label": "≥  greater or equals", "value":">= ", "selected":false},
                       {"label": ">  greater", "value":">", "selected":false},
                       {"label": "≤  less or equals", "value":"<=", "selected":false},
                       {"label": "<  less", "value":"<", "selected":false},
                      {"label": "∅  null", "value":" = null ", "selected":false},
                      {"label": "∃  not null", "value":" != null ", "selected":false}],
            "BOOLEAN": [{"label": "=  equals", "value":"=", "selected":false},
                      {"label": "≠  not equals", "value":"!=", "selected":false}],
            "DATE":	  [{"label": "=  equals", "value":"=", "selected":false},
                      {"label": "≠  not equals", "value":"!=", "selected":false},
                       {"label": "≥  greater or equals", "value":">= ", "selected":false},
                       {"label": ">  greater", "value":">", "selected":false},
                       {"label": "≤  less or equals", "value":"<=", "selected":false},
                       {"label": "<  less", "value":"<", "selected":false},
                      {"label": "∅  null", "value":" = null ", "selected":false},
                      {"label": "∃  not null", "value":" != null ", "selected":false}],
            "DATETIME":[{"label": "=  equals", "value":"=", "selected":false},
                      {"label": "≠  not equals", "value":"!=", "selected":false},
                       {"label": "≥  greater or equals", "value":">= ", "selected":false},
                       {"label": ">  greater", "value":">", "selected":false},
                       {"label": "≤  less or equals", "value":"<=", "selected":false},
                       {"label": "<  less", "value":"<", "selected":false},
                      {"label": "∅  null", "value":" = null ", "selected":false},
                      {"label": "∃  not null", "value":" != null ", "selected":false}],
            "ID":	[{"label": "=  equals", "value":"=", "selected":false},
                      {"label": "≠  not equals", "value":"!=", "selected":false},
                      {"label": "∅  null", "value":" = null ", "selected":false},
                      {"label": "∃  not null", "value":" != null ", "selected":false}],
            "REFERENCE":[{"label": "=  equals", "value":"=", "selected":false},
                      {"label": "≠  not equals", "value":"!=", "selected":false},
                      {"label": "∅  null", "value":" = null ", "selected":false},
                      {"label": "∃  not null", "value":" != null ", "selected":false}]
        };
        
        return operatorMap;
    }
},
 
 
 })