({
    searchForAll : function(component, event, helper){
        component.set("v._keyword","");
        component.set("v._filter_list", []);
        component.set("v.showFilterLogic", false);
        component.set("v._filter_logic", null);
        helper.combineFilter(component);
        component.set("v.showFilterBar", false);
    },
    addFilter : function(component, event, helper) {
       var filterList = component.get("v._filter_list");
       filterList = filterList? filterList : [];
       filterList.push({
            'field':'',
            'label':'New Filter',
            'operator':'',
            'value': '',
            'operatorlabel': '',
            'fieldType': 'STRING',
        });
       component.set("v._filter_list", filterList); 
    },
    addCondition : function(component, event, helper) {
        var source = event.currentTarget;
        var homePin = document.getElementsByClassName("home-popin")[0];
		var topPosition = source.parentElement.offsetTop - source.parentElement.offsetHeight;
        var filterList = component.get("v._filter_list");
        var index = source.dataset.index;
        var currentFilter = filterList[index];
        currentFilter.index = index;
        component.set("v.showFilterColumn", false);
        component.set("v._filter_unit", currentFilter);
        component.set("v._top_size","top:"+topPosition+ "px");
        component.set("v.showFilterColumn", true);
        
    },
    removeCondition : function(component, event, helper){
        var index = event.currentTarget.dataset.index
        var filterList = component.get("v._filter_list");
		filterList.splice(index, 1);
		console.log('index is '+index);
        component.set("v._filter_list", filterList);
        component.set("v.showFilterColumn", false);
    },
    hideFieldColumn  : function(component, event, helper){
        component.set("v.showFilterColumn", false);
    },
    applyFilter : function(component, event, helper){
        var _filter_unit = event.getParam("_filter_unit");
        var filterList = component.get("v._filter_list");
        var index = _filter_unit.index;
        filterList[index] = _filter_unit;
		component.set("v.showFilterColumn", false);
        component.set("v._filter_list", filterList);
    },
    showFilterLogic : function(component, event, helper){
        component.set("v.showFilterLogic", true);
    },
    hideFilterLogic : function(component, event, helper){
        component.set("v.showFilterLogic", false);
        component.set("v._filter_logic", '');
    },
    removeAll : function(component, event, helper){
        component.set("v._filter_list", []);
        component.set("v.showFilterLogic", false);
        component.set("v._filter_logic", null);        
    }, 
    search : function(component, event, helper){
        helper.combineFilter(component);
        component.set("v.showFilterBar", false);
    },
    hideFilterBar : function(component, event, helper){
		component.set("v.showFilterBar", false);
    }
    
})