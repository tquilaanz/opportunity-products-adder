public class tqaopa_ProductSelector {
    public static List<List<SObject>> searchProductsByCriteria(Id priceBookId, String condition, String keyword){
        if(condition != null && condition != ''){
            condition = 'where '+ condition;
        }
        String queryString = 'Find : keyword IN ALL FIELDS RETURNING Product2 (Id  '+condition+') WITH PricebookId = \''+priceBookId+'\'';
        System.debug('################The Search String is #########: ' + queryString);
        System.debug('################The keyword is #########: ' + keyword);
        return search.query(queryString);    
    }
    
    public static List<Product2> queryProductsByCriteria(Id priceBookId, String condition){
        String queryCondition = '';
        if(condition != null && condition != ''){
            queryCondition = queryCondition + ' where  ' + condition + ' WITH pricebookId =: priceBookId';
        }
        String queryString = 'Select Id from Product2 ' + queryCondition;
        return database.query(queryString);
    }
    

}