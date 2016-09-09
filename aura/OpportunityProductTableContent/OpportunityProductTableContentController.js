({
	handleComponentEvent : function(component, event, helper){      
       var totalPageNumber = event.getParam("totalPageNumber");
       var numPerPage = event.getParam("numPerPage");
       component.set("v.totalNumber", totalPageNumber);
       component.set("v.numPerPage", numPerPage);        
        
    },
    
    checkAllCheckBoxes : function(component, event, helper){
        var target = event.getSource(); 
        if(target.get("v.name") === "selectAll"){
            helper.checkAllCheckBoxes(component, event);
        }else{
            helper.checkOneUnit(component, event);
        }
    },
    updateSelectAll: function(component, event, helper){
        helper.checkButtonStatus(component);  
		helper.pageViewUpdated(component);        
    },
       
    updateView : function(component, event, helper){
        var buttonName = event.target.getAttribute("name")
        var pageNumber = component.get("v.pageNumber");
        var totalPageNumber = component.get("v.totalNumber");		
        
        if(buttonName === "first"){
            pageNumber = 1;            
        }else if(buttonName === "last"){
            pageNumber = totalPageNumber;            
        }else if(buttonName === "next"){
            if(pageNumber < totalPageNumber){
                pageNumber ++;                
            }
        }else if(buttonName === "previous"){
            if(pageNumber > 1){
                pageNumber --;
            }
        }
		helper.checkButtonStatus(component);        
        component.set("v.pageNumber", pageNumber);
    },
    selectItems : function(component, event, helper){
        var productFeeds = component.get("v.productFeeds");
        var opportunityItems = [];
        if(productFeeds.length > 0 ){
            for(var key in productFeeds){
                //if selected, go to 
                if(productFeeds[key].isSelected){
                    var item = {}; 
                    item.quantity = null;
                    item.serviceDate = null;
                    item.description = '';
                    item.productName = productFeeds[key].pBEntry.Product2.Name;
					item.salesPrice = productFeeds[key].pBEntry.UnitPrice;
                    item.priceBookEntryId = productFeeds[key].pBEntry.Id;
                    opportunityItems.push(item);
                }
            }
        }
        if(opportunityItems.length > 0 ){
            component.set("v.opportunityItems", opportunityItems);
        }

    },
    cancel : function(component){

        var recordId = component.get("v.recordId");        
      	var event = document.createEvent('Event');
        event.initEvent('navigateToSObject', true, true);
        window.dispatchEvent (event);
    }
})