public class tqaopa_OpportunityLineItemService {
    public List<OpportunityLineItem> prepareOpportunityLineItemsFromJSON(String opportunityItemJSON, Id recordId){
         List< tqaopa_OppProductsAdderController.OpportunityItem> items 
            = (List< tqaopa_OppProductsAdderController.OpportunityItem>)JSON.deserialize(opportunityItemJSON, 
                List< tqaopa_OppProductsAdderController.OpportunityItem>.class);
         List<OpportunityLineItem> oppLineItems = (new tqaopa_OpportunityLineItems()).convertOpportunityLineItems(items, recordId);
         
         return oppLineItems;
    }
    
    public void createOpportunityLineItems(String opportunityItemJSON, Id recordId){
        List<OpportunityLineItem> oppLineItems 
            = prepareOpportunityLineItemsFromJSON(opportunityItemJSON, recordId);
        Savepoint sp = Database.setSavepoint();
        try{
            Database.SaveResult[] results = Database.insert(oppLineItems, true);
        }catch(DMLException ex){
             System.debug('The rows have issue is ' + ex.getNumDml());
             System.debug('The index is ' + ex.getDmlIndex(0));
             system.debug('The field is ' + ex.getDmlFields(0));
             system.debug('The error is ' + ex.getDmlMessage(0));
             throw ex;
        }
         
    }
    
    public class OpportunityLineItemServiceException extends Exception{
        public List<Map<String, String>> errorResults {set;get;}
        
    }
    
}