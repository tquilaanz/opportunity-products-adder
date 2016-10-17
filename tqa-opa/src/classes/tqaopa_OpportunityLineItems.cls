public class tqaopa_OpportunityLineItems {
    public List<SObject> records {public get; private set;}
    public tqaopa_OpportunityLineItems(){
    }
    public tqaopa_OpportunityLineItems(List<SObject> records){
        this.records = records;
    }
    
    public List<OpportunityLineItem> convertOpportunityLineItems(
            List< tqaopa_OppProductsAdderController.OpportunityItem> oppItems, Id recordId){
                
        List<OpportunityLineItem> items = new List<OpportunityLineItem>();
        for(tqaopa_OppProductsAdderController.OpportunityItem oppItem: oppItems){
            OpportunityLineItem item = new OpportunityLineItem();
            item.OpportunityId = recordId;
            item.Quantity = oppItem.quantity;
            item.UnitPrice = oppItem.salesPrice;
            item.Description = oppItem.description;
            item.ServiceDate = oppItem.serviceDate;
            item.PriceBookEntryId = oppItem.priceBookEntryId;
            items.add(item);
        }
        
        return items;
    }
    

}