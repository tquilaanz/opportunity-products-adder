public class PriceBookEntrySelector {
    
    private final static String Raw_Query = 'Select Id, Product2.Id, Product2.ProductCode, '
                                          + 'Product2.Family, Product2.Name, Product2.Description, UnitPrice from PricebookEntry ';
    
    public static List<PriceBookEntry> getPriceBookEntriesByPriceBookId(Id priceBookId){
        String query = Raw_Query + ' where PriceBook2Id = : priceBookId';
        return Database.query(query);
    }
    
     public static List<PriceBookEntry> getPriceBookEntriesByCondition(String condition){
        String query = Raw_Query + condition;
        return Database.query(query);
    }
    
    public static List<PriceBookEntry> getPriceBookEntriesByKeyWordAndProductIds(Id priceBookId, List<Id> productIds){
        String query = Raw_Query + ' where PriceBook2Id = : priceBookId and Product2Id in: productIds';
        return Database.query(query);
    }
    
}