@isTest
private class OpportunityProductsAdderControllerTest {
    @testSetup static void init() {
        TestDataFactory.createOpportunities();
    }
    
	private static testMethod void testGetOpportunityRecord() {
	    Opportunity oppToBeUsed = TestDataFactory.opportunities.get(0);
	    System.assertEquals(
	        OpportunityProductsAdderController.getOpportunityRecord(
	            oppToBeUsed.Id).Id, oppToBeUsed.Id);
	}
	
    private static testMethod void testGetProductCandidate() {
        Id priceBookId = Test.getStandardPricebookId();
        TestDataFactory.createProductsAndPriceBookEntries();
        System.assert(
            OpportunityProductsAdderController.getProductCandidate(
                priceBookId).size() > 0);
    }
    
    private static testMethod void testSaveOpportunityRecord() {
        Opportunity oppToBeUsed = TestDataFactory.opportunities.get(0);
        oppToBeUsed.PriceBook2Id = Test.getStandardPricebookId();
        OpportunityProductsAdderController.saveOpportunityRecord(oppToBeUsed);
    }
    
    public static testMethod void testApplyFilterSearch(){
        Id priceBookId = Test.getStandardPricebookId();
        TestDataFactory.createProductsAndPriceBookEntries();
        
        String filterString = '{"filterList":[{"field":"Name","label":"Product Name","operator":"like",'
            + '"value":"test","operatorlabel":"≈  like","fieldType":"STRING","index":"0"},{"field":'
            + '"ProductCode","label":"Product Code","operator":" = null ","value":"","operatorlabel":' 
            + '"∃ null","fieldType":"STRING","index":"1"}]}';
        System.assert(OpportunityProductsAdderController.applyFilterSearch(
            priceBookId, filterString).size()>0);
        
    }
    
    public static testMethod void testApplyFilterSearchWithKeyWord(){
        Id priceBookId = Test.getStandardPricebookId();
        TestDataFactory.createProductsAndPriceBookEntries();
        
        String filterString = '{"keyword":"product","filterList":[{"field":"Name","label":"Product Name","operator":"like",'
            + '"value":"test","operatorlabel":"≈  like","fieldType":"STRING","index":"0"},{"field":'
            + '"ProductCode","label":"Product Code","operator":" = null ","value":"","operatorlabel":' 
            + '"∃ null","fieldType":"STRING","index":"1"}]}';
        OpportunityProductsAdderController.applyFilterSearch(
            priceBookId, filterString);
        
    }
    
    public static testMethod void testCreateOpportunityItems(){
        OpportunityProductsAdderController.createOpportunityItems(
            TestDataFactory.prepareJSONForCreatingOppProds(), TestDataFactory.Opportunities[0].Id);
        
        List<OpportunityLineItem> oppItems = [Select Id from OpportunityLineItem];
        System.assertEquals(oppItems.size(), TestDataFactory.numOfRecords);
        
    }
    
    public static testMethod void testCreateOpportunityItemsWithException(){
        
        Map<String, Object> successMessage 
            = OpportunityProductsAdderController.createOpportunityItems(
                TestDataFactory.prepareJSONForCreatingOppProdsWithException(), TestDataFactory.Opportunities[0].Id);
        
        System.assert(!((Boolean)successMessage.get('IsSuccess')));
        
    }
    
    
    
}