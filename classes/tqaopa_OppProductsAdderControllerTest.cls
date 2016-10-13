@isTest
private class tqaopa_OppProductsAdderControllerTest {
    @testSetup static void init() {
        tqaopa_TestDataFactory.createOpportunities();
    }
    
    private static testMethod void testGetOpportunityRecord() {
        Opportunity oppToBeUsed = tqaopa_TestDataFactory.opportunities.get(0);
        System.assertEquals(
            tqaopa_OppProductsAdderController.getOpportunityRecord(
                oppToBeUsed.Id).Id, oppToBeUsed.Id);
    }
    
    private static testMethod void testGetProductCandidate() {
        Id priceBookId = Test.getStandardPricebookId();
        tqaopa_TestDataFactory.createProductsAndPriceBookEntries();
        System.assert(
            tqaopa_OppProductsAdderController.getProductCandidate(
                priceBookId).size() > 0);
    }
    
    private static testMethod void testSaveOpportunityRecord() {
        Opportunity oppToBeUsed = tqaopa_TestDataFactory.opportunities.get(0);
        oppToBeUsed.PriceBook2Id = Test.getStandardPricebookId();
        tqaopa_OppProductsAdderController.saveOpportunityRecord(oppToBeUsed);
    }
    
    public static testMethod void testApplyFilterSearch(){
        Id priceBookId = Test.getStandardPricebookId();
        tqaopa_TestDataFactory.createProductsAndPriceBookEntries();
        
        String filterString = '{"filterList":[{"field":"Name","label":"Product Name","operator":"like",'
            + '"value":"test","operatorlabel":"≈  like","fieldType":"STRING","index":"0"},{"field":'
            + '"ProductCode","label":"Product Code","operator":" = null ","value":"","operatorlabel":' 
            + '"∃ null","fieldType":"STRING","index":"1"}]}';
        System.assert(tqaopa_OppProductsAdderController.applyFilterSearch(
            priceBookId, filterString).size()>0);
        
    }
    
    public static testMethod void testApplyFilterSearchWithKeyWord(){
        Id priceBookId = Test.getStandardPricebookId();
        tqaopa_TestDataFactory.createProductsAndPriceBookEntries();
        
        String filterString = '{"keyword":"product","filterList":[{"field":"Name","label":"Product Name","operator":"like",'
            + '"value":"test","operatorlabel":"≈  like","fieldType":"STRING","index":"0"},{"field":'
            + '"ProductCode","label":"Product Code","operator":" = null ","value":"","operatorlabel":' 
            + '"∃ null","fieldType":"STRING","index":"1"}]}';
        tqaopa_OppProductsAdderController.applyFilterSearch(
            priceBookId, filterString);
        
    }
    
    public static testMethod void testCreateOpportunityItems(){
        tqaopa_OppProductsAdderController.createOpportunityItems(
            tqaopa_TestDataFactory.prepareJSONForCreatingOppProds(), tqaopa_TestDataFactory.Opportunities[0].Id);
        
        List<OpportunityLineItem> oppItems = [Select Id from OpportunityLineItem];
        System.assertEquals(oppItems.size(), tqaopa_TestDataFactory.numOfRecords);
        
    }
    
    public static testMethod void testCreateOpportunityItemsWithException(){
        
        Map<String, Object> successMessage 
            = tqaopa_OppProductsAdderController.createOpportunityItems(
                tqaopa_TestDataFactory.prepareJSONForCreatingOppProdsWithException(), tqaopa_TestDataFactory.Opportunities[0].Id);
        
        System.assert(!((Boolean)successMessage.get('IsSuccess')));
        
    }
    
    
    
}