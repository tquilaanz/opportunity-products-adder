({
	checkIfPriceBookExists : function(component) {
        var opportunity = component.get("v._opportunity");
        var showPriceBookSelection = true;
        $A.util.addClass(component.find("pricebookSelection"),"slds-hide");
        $A.util.addClass(component.find("productSelection"),"slds-hide");
        
        if(opportunity && opportunity.Pricebook2){
            var priceBook2Id = opportunity.Pricebook2.Id;
            $A.util.removeClass(component.find("productSelection"),"slds-hide");
            showPriceBookSelection = false;
        }

        if(opportunity && !opportunity.Pricebook2){
            $A.util.removeClass(component.find("pricebookSelection"),"slds-hide")
            showPriceBookSelection = true;
        }
        return showPriceBookSelection;
	},
    retrieveProductCandidates: function(component){
        var opportunity = component.get("v._opportunity");
        
        var getProductCandidate = component.get("c.getProductCandidate");
        getProductCandidate.setParams({
            "pricebook2Id": opportunity.Pricebook2.Id
        });
        
        getProductCandidate.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                component.set("v.productCandidates", response.getReturnValue());   
            }else{
                console.log("Failed with state: "+ state);
            }
        });
        
        $A.enqueueAction(getProductCandidate);
	},
    search: function(component){
        var opportunity = component.get("v._opportunity");
		var filterInfo = component.get("v._filter");
        var orderBy = component.get("v.orderBy");
        filterInfo = filterInfo ? filterInfo : {};
        filterInfo.orderBy = orderBy;
        var applyFilter = component.get("c.applyFilterSearch");
        applyFilter.setParams({
            "pricebook2Id": opportunity.Pricebook2.Id,
            "filterInfoStr": JSON.stringify (filterInfo)
        });
        
        applyFilter.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                component.set("v.productCandidates",response.getReturnValue());
                console.log(response.getReturnValue());   
            }else{
                console.log("Failed with state: "+ state);
            }
        });
        
        $A.enqueueAction(applyFilter);
	},
})