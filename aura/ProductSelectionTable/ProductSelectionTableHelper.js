({
    checkAllCheckBoxes : function(selectedProductMap, currentRecords, checked){
        for(var key in currentRecords){
            currentRecords[key]["isSelected"] = checked;
            this.checkOneUnit(selectedProductMap, currentRecords[key].pBEntry.Id, checked);
        }
    },    
    checkOneUnit : function(selectedProductMap, recordId, checked){
        selectedProductMap[recordId] = checked;
    },
    checkIfNeedToCheckAllCheckBoxes : function(selectedProductMap, currentRecords){
        var checkAllBox = true;
        for(var key in currentRecords){
            if(!selectedProductMap[currentRecords[key].pBEntry.Id]){
                checkAllBox = false;
            }            
        }
        return checkAllBox;
    },
    fireCreateProductsEvent : function(component){
        var createProducts = component.getEvent("createProducts"); 
        var selectedProductMap = component.get("v.selectedProductMap");
        var productCandidates = component.get("v.productCandidates");
        var selectedProducts = [];
        selectedProducts = this.convertSelectedProducts(selectedProductMap, productCandidates);
        createProducts.setParams({
            "_selected_products": selectedProducts

        });
        createProducts.fire();
    },
    convertSelectedProducts : function(selectedProductsMap, productCandidates){
        var opportunityItems = [];
        for(var key in productCandidates){
            var candidate = productCandidates[key];
            
            if(selectedProductsMap[candidate.pBEntry.Id]){
                var item = {
                    "quantity": 1,
                    "serviceDate": null,
                    "description": '',
                    "productName": candidate.pBEntry.Product2.Name,
                    "salesPrice": candidate.pBEntry.UnitPrice,
                    "priceBookEntryId": candidate.pBEntry.Id,
                    "errors":{
                        "quantity": "",
                        "salesPrice" : "",
                        "serviceDate" : "",
                        "description" : "",
                        "message" : ""
                    }
                }; 
                
                opportunityItems.push(item);
            }
        }
        return opportunityItems;
    }
})