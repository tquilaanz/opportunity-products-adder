public class OpportunityItemEditController {
    
    @AuraEnabled
    public static Opportunity getOpportunity(Id recordId){
        OpportunityService service = new OpportunityService();
        return service.getOpportunity(recordId);
    }
    
    public class OpportunityItem{
        public Double salesPrice{set;get;}
        public Double quantity {set;get;}
        public String productName{set;get;}
        public String priceBookEntryId{set;get;}
        public Date serviceDate{set;get;}
        public String description{set;get;}
        
        
    }
    public class PriceBookEntryFeed{
        public PriceBookEntryFeed(PriceBookEntry pbEntry){
            this.isSelected = false;
            this.pbEntry = pbEntry;
        }
        
        @AuraEnabled
        public PriceBookEntry pBEntry {private set;get;}
        
        @AuraEnabled
        public String linkURL{ private set; get{
            return '/' + pBEntry.Product2.Id;
            
        }}
        
        @AuraEnabled
        public Boolean isSelected {set;get;}
        
    }
    
    @AuraEnabled
    public static List<PriceBookEntryFeed> getPriceBookEntries(Id recordId){
        OpportunityService service = new OpportunityService();
        Opportunity opp = service.getOpportunity(recordId);
        Id priceBookId = opp.PriceBook2Id ;
        
        List<PriceBookEntryFeed> feeds = new List<PriceBookEntryFeed>();
        List<PriceBookEntry> priceBookEntries = new List<PriceBookEntry>();
        priceBookEntries 
            = PriceBookEntrySelector.getPriceBookEntriesByPriceBookId(priceBookId);
            
        for(PriceBookEntry pb: priceBookEntries){
            feeds.add(new PriceBookEntryFeed(pb));
        }
        return feeds;         
    }
    
    @AuraEnabled 
    public static List<PriceBookEntryFeed> getPriceBookEntriesWithConditions(Id recordId, String conditionString){
        OpportunityService service = new OpportunityService();
        Opportunity opp = service.getOpportunity(recordId);
        Id priceBookId = opp.PriceBook2Id ;
        
        list<Conditions> conditions =(List<Conditions>) JSON.deserialize(conditionString, List<Conditions>.class);
        PriceBookEntryService pbService = new PriceBookEntryService();
        return pbService.getPriceBookEntriesByConditions(priceBookId, conditions);
    }
    
    @AuraEnabled
    public static void createOpportunityItems(String opportunityItemJSON, Id recordId){
        List<OpportunityItem> oppItems = (List<OpportunityItem>)JSON.deserialize(opportunityItemJSON, List<OpportunityItem>.class);
        List<OpportunityLineItem> items = new List<OpportunityLineItem>();
        System.debug('The oppItems ' + oppItems);
        for(OpportunityItem oppItem: oppItems){
            OpportunityLineItem item = new OpportunityLineItem();
            item.OpportunityId = recordId;
            item.Quantity = oppItem.quantity;
            item.UnitPrice = oppItem.salesPrice;
            item.Description = oppItem.description;
            item.ServiceDate = oppItem.serviceDate;
            item.PriceBookEntryId = oppItem.priceBookEntryId;
            items.add(item);
        }
        
        insert items;
        
        
    }
    

}