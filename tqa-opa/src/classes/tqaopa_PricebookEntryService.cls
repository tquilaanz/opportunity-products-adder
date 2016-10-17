public class tqaopa_PricebookEntryService{
    //
    public List<PricebookEntry> getPricebookEntryByPBId(Id pricebook2Id){
        return tqaopa_PriceBookEntrySelector.getPricebookEntryByPBId(pricebook2Id);
    }
    
    public List<PricebookEntry> getPricebookEntryByFilter(Id pricebook2Id, String filterInfoStr){
        List<PricebookEntry> pricebookEntries 
            = new List<PricebookEntry>();
        tqaopa_ProductService productService = new tqaopa_ProductService();
        
        tqaopa_ProductFilterCondition filterCondition = 
            tqaopa_ProductFilterCondition.create(filterInfoStr);
        
        String condition = filterCondition.generateConditions();
        String orderBy = filterCondition.orderBy;
        if(orderBy != null && orderBy != ''){
            orderBy = ' Order By Product2.'+ orderBy.trim();
        }
        if(orderBy == null){
            orderBy = '';
        }
        
        if(filterCondition.isForSearch){
            List<Id> productIdList = new tqaopa_Products(productService.searchProductsByCriteria(
                    pricebook2Id, condition, filterCondition.keyword)).getRecordIds();        
            pricebookEntries = tqaopa_PriceBookEntrySelector.getPricebookEntryByPBANDProId(pricebook2Id, productIdList, orderBy);    
        }else{
            pricebookEntries = tqaopa_PriceBookEntrySelector.getPricebookEntryByCondition(pricebook2Id, condition, orderBy);                            
        }
        
        return pricebookEntries;
    }

}