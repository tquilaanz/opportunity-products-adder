({
	updateButtons : function(component, event, helper) {
		helper.updateDisplayButtons(component);	
        
	},
    goToPage : function(component, event, helper){
        var source = event.target;
        var pageNumber = source.textContent;
        helper.goToPage(component, pageNumber);
    },
    previous : function(component, event, helper){
        var paginationInfo = component.get("v._pagination_info");
        var pageNumber = paginationInfo.pageNumber ;
        if(pageNumber > 1){
            pageNumber --;
            helper.goToPage(component, pageNumber);
        }
    },
    next : function(component, event, helper){
        var paginationInfo = component.get("v._pagination_info");
        var pageNumber = paginationInfo.pageNumber ;
        if(pageNumber < paginationInfo.totalPages){
            pageNumber ++;
            helper.goToPage(component, pageNumber);
        }
    },
    
})