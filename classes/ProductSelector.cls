public class ProductSelector {
    public static List<List<SObject>> keyWordSearch(Id priceBookId, String keyword, String condition){
        if(condition != null && condition != ''){
            condition = 'where '+ condition;
        }
        String queryString = 'Find : keyword IN ALL FIELDS RETURNING Product2 (Id  '+condition+') WITH PricebookId = \''+priceBookId+'\'';
        System.debug('Query String is ' +queryString);
        return search.query(queryString);    
    }
    

}