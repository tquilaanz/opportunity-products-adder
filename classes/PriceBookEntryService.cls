public class PricebookEntryService{
    //
    public List<PricebookEntry> getPricebookEntryByPBId(Id pricebook2Id){
        return PriceBookEntrySelector.getPricebookEntryByPBId(pricebook2Id);
    }
    
    public List<PricebookEntry> getPricebookEntryByFilter(Id pricebook2Id, String filterInfoStr){
        List<PricebookEntry> pricebookEntries 
            = new List<PricebookEntry>();
        ProductService productService = new ProductService();
        
        ProductFilterCondition filterCondition = 
            ProductFilterCondition.create(filterInfoStr);
        
        String condition = filterCondition.generateConditions();
        String orderBy = filterCondition.orderBy;
        if(orderBy != null && orderBy != ''){
            orderBy = ' Order By Product2.'+ orderBy.trim();
        }
        if(orderBy == null){
            orderBy = '';
        }
        
        if(filterCondition.isForSearch){
            List<Id> productIdList = new Products(productService.searchProductsByCriteria(
                    pricebook2Id, condition, filterCondition.keyword)).getRecordIds();        
            pricebookEntries = PriceBookEntrySelector.getPricebookEntryByPBANDProId(pricebook2Id, productIdList, orderBy);    
        }else{
            pricebookEntries = PriceBookEntrySelector.getPricebookEntryByCondition(pricebook2Id, condition, orderBy);                            
        }
        
        return pricebookEntries;
    }

}