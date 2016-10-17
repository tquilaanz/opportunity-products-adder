/***
 * OpportunityProductsAdderController is the controller for 
 * the lightning component Lightning Opportunity Product Adder
 * 
***/
public class tqaopa_OppProductsAdderController {
    @AuraEnabled
    public static Opportunity getOpportunityRecord(Id opportunityId){
        List<Opportunity> opps = [select Id, Name, Pricebook2.Id, Pricebook2.Name from Opportunity where Id =: opportunityId ];
        Opportunity opp = null;
        if(!opps.isEmpty()){
            opp = opps.get(0);
        }
        return opp;
    }
    
    @AuraEnabled
    public static List<PriceBookEntryFeed> applyFilterSearch(Id pricebook2Id, String filterInfoStr){
        tqaopa_PricebookEntryService service = new tqaopa_PricebookEntryService();
        List<PricebookEntry> pricebookEntries 
            = service.getPricebookEntryByFilter(pricebook2Id, filterInfoStr);
        return getPricebookEntryFeeds(pricebookEntries);
    }
    
    private static List<PriceBookEntryFeed> getPricebookEntryFeeds(List<PricebookEntry> pricebookEntries ){
        List<PriceBookEntryFeed> feeds = new List<PriceBookEntryFeed>();
        for(PriceBookEntry pb: priceBookEntries){
            feeds.add(new PriceBookEntryFeed(pb));
        }
        return feeds;
    }
    
    @AuraEnabled
    public static void saveOpportunityRecord(Opportunity opportunityRecord){
        update opportunityRecord;
    }
    
    @AuraEnabled
    public static List<PriceBookEntryFeed> getProductCandidate(Id pricebook2Id){
        tqaopa_PricebookEntryService service = new tqaopa_PricebookEntryService();
        
        List<PriceBookEntry> priceBookEntries = service.getPricebookEntryByPBId(pricebook2Id);
        return getPricebookEntryFeeds(pricebookEntries);
    }
    
    @AuraEnabled
    public static Map<String, Object> createOpportunityItems(String opportunityItemJSON, Id recordId){
        tqaopa_OpportunityLineItemService service = new tqaopa_OpportunityLineItemService();
        try{
            service.createOpportunityLineItems(opportunityItemJSON, recordId);
        }catch(DMLException ex){
            Map<String, Object> errors = tqaopa_GlobalUtility.handleWithDMLException(ex);
            
            return errors;
        }
        
        Map<String, Object> successMessage = new Map<String, Object>{'IsSuccess'=>true};
        
        return successMessage;
        
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
    
}