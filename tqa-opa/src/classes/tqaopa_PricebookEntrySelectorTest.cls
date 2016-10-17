@isTest
private class tqaopa_PricebookEntrySelectorTest {

    
    @testSetup static void Datasetup() {
        
        tqaopa_TestDataFactory.createProductsAndPriceBookEntries();
        
    }

    private static testMethod void getPricebookEntryByPBId_test() {
        
        Id pBEId = [Select Id,Product2.Id,Product2.ProductCode,Product2.Family,Pricebook2Id,
                    Product2.Name, Product2.Description, 
                    UnitPrice from PricebookEntry where Product2.Name = 'Test Product 0' LIMIT 1][0].Pricebook2Id;
        system.debug('Id****'+pBEId);           
        List<PricebookEntry>searchEntriesList = tqaopa_PriceBookEntrySelector.getPricebookEntryByPBId(pBEId);
                system.assertEquals(searchEntriesList.size(),10);
                    
    }
    private static testMethod void getPricebookEntryByCondition_test() {
        Id pBEId = [Select Id,Product2.Id,Product2.ProductCode,Product2.Family,Pricebook2Id,
                    Product2.Name, Product2.Description, 
                    UnitPrice from PricebookEntry where Product2.Name = 'Test Product 0' LIMIT 1][0].Pricebook2Id; 
        
        string condition = 'Product2.Name LIKE \'Test%\'';            
        List<PricebookEntry>searchEntriesList = tqaopa_PriceBookEntrySelector.getPricebookEntryByCondition(pBEId,condition,'Order By Name');               
        system.assertEquals(searchEntriesList.size(),10);

    }
    private static testMethod void getPricebookEntryByPBANDProId_test() {
        List<Id>Product2Ids = new List<Id>();
        for(product2 pp : [Select Id from product2 where Name Like 'Test%']) {
            Product2Ids.add(pp.Id);    
        }
        Id pb2Id = Test.getStandardPricebookId();
        List<PricebookEntry>searchEntriesList = tqaopa_PriceBookEntrySelector.getPricebookEntryByPBANDProId(pb2Id,Product2Ids,'Order By Name');               
        system.assertEquals(searchEntriesList.size(),10);

    }    
    
    
}