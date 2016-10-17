public class tqaopa_PriceBookEntrySelector {
    public static List<PricebookEntry> getPricebookEntryByPBId(Id pricebook2Id){
        String queryString ='Select Id, Product2.Id, Product2.ProductCode, '
                              + 'Product2.Family, Product2.Name, Product2.Description, UnitPrice from PricebookEntry ';
        queryString = queryString + ' where Pricebook2Id =: pricebook2Id limit 2000 ';
        return database.query(queryString);
    }
    
    public static List<PricebookEntry> getPricebookEntryByCondition(Id pricebook2Id, String condition,  String orderBy){
        String queryString ='Select Id, Product2.Id, Product2.ProductCode, '
                              + 'Product2.Family, Product2.Name, Product2.Description, UnitPrice from PricebookEntry ';
        queryString = queryString + ' where Pricebook2Id =: pricebook2Id ';
        if(condition != null && condition != ''){
          queryString = queryString + '  and ( ' + condition + ' )' ;
        }
        
        queryString = queryString + ' ' + orderBy + ' limit 2000';
        System.debug('###############The query String is #############' + queryString);
        return Database.query(queryString);
    }
    
    public static List<PricebookEntry> getPricebookEntryByPBANDProId(Id pricebook2Id, List<Id> productIds, String orderBy){
        String queryString ='Select Id, Product2.Id, Product2.ProductCode, '
                              + 'Product2.Family, Product2.Name, Product2.Description, UnitPrice from PricebookEntry ';
        queryString = queryString + ' where Pricebook2Id =: pricebook2Id  and product2Id in: productIds '+ orderBy + ' limit 2000';
        return database.query(queryString);
    }

}