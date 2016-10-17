({
	
    combineFilter : function(component){
    	var keyword = component.get("v._keyword");
        var filterLogic = component.get("v._filter_logic");
        var filterList = component.get("v._filter_list");
      
        var filter = {
            "keyword": keyword,
            "filterLogic": filterLogic,
            "filterList": filterList
        };
        component.set("v._filter", filter);
        console.log("the filter is " + filter);
    }
})