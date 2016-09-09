public class PriceBookEntryService {
    public List<OpportunityItemEditController.PriceBookEntryFeed> getPriceBookEntriesByConditions(Id recordId, list<Conditions> conditions){
        List<PriceBookEntry> priceBookEntries = new List<PriceBookEntry>();
        if(conditions.isEmpty()){
            return getPriceBookEntries(recordId);
        }
        
        Conditions cond = conditions.get(0);
        String keyWord = cond.keyword;
        
        if(keyWord == null || keyWord == ''){
            return getPriceBookEntriesBySOQL(recordId, cond);
        }else{
            return getPriceBookEntriesBySOSL(recordId, cond);
        }
    }
    
    public List<OpportunityItemEditController.PriceBookEntryFeed> getPriceBookEntriesBySOQL(Id recordId, Conditions cond){
        List<PriceBookEntry> pbEntries = new List<PriceBookEntry>();
        String criteriaString = GlobalUtility.queryConditions(cond, true);
        if(criteriaString != '' && criteriaString!= null){
            criteriaString = 'where PriceBook2Id = \''+recordId+'\' and ' + criteriaString;
        }
        pbEntries = PriceBookEntrySelector.getPriceBookEntriesByCondition(criteriaString);
        return getPriceBookEntries(pbEntries);
    }
    
    public List<OpportunityItemEditController.PriceBookEntryFeed> getPriceBookEntriesBySOSL(Id recordId, Conditions cond){
        List<PriceBookEntry> pbEntries = new List<PriceBookEntry>();
        String criteriaString = GlobalUtility.queryConditions(cond, false);
        String keyWord = cond.keyword;
        List<List<SObject>> sobjList 
            = ProductSelector.keyWordSearch(recordId, keyword, criteriaString);
        List<Id> productIds = new List<Id>();
        for(List<SObject> listSobj: sobjList){
            for(Sobject sobj: listSobj){
                productIds.add(sobj.Id);
            }
        }
        
        pbEntries = PriceBookEntrySelector.getPriceBookEntriesByKeyWordAndProductIds(recordId, productIds);
        return getPriceBookEntries(pbEntries);
    }
    
    public List<OpportunityItemEditController.PriceBookEntryFeed> getPriceBookEntries(List<PriceBookEntry> priceBookEntries){
       List<OpportunityItemEditController.PriceBookEntryFeed> feeds 
            = new List<OpportunityItemEditController.PriceBookEntryFeed>();    
        for(PriceBookEntry pb: priceBookEntries){
            feeds.add(new OpportunityItemEditController.PriceBookEntryFeed(pb));
        }
        return feeds;  
    }
    
    public List<OpportunityItemEditController.PriceBookEntryFeed> getPriceBookEntries(Id priceBookId){
       
        List<PriceBookEntry> priceBookEntries = new List<PriceBookEntry>();
        priceBookEntries 
            = PriceBookEntrySelector.getPriceBookEntriesByPriceBookId(priceBookId);
        
       return getPriceBookEntries(priceBookEntries);          
    }
    
    
}