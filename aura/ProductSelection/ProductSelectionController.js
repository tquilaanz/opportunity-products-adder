({
    //Get the Product Candidates from the search
	getProductCandidates : function(component, event, helper) {
        if(!helper.checkIfPriceBookExists(component)){
            helper.retrieveProductCandidates(component);
        }
	},
    toggleFilterBar : function(component, event, helper){
        var showFilterBar = component.get("v.showFilterBar");
        if(showFilterBar){
	        $A.util.removeClass(component.find("productFilterBar"),"slds-hide")
        }else{
            $A.util.addClass(component.find("productFilterBar"),"slds-hide")
        }
    },
    applyFilter : function(component, event, helper){
        helper.search(component);
    }
    
})