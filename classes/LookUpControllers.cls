public class LookUpControllers {
    
    @AuraEnabled
    public static String getTargetSObjectName(String sobjectName, String fieldName){
       String targetSObjectName = GlobalUtility.getSObjectType(sobjectName, fieldName);
       return targetSObjectName; 
    }
    
    @AuraEnabled
    public static List<SObject> searchKeyword(String objectName, String value){
        value = '%'+ value + '%';
        System.debug('the value is ' + value);
        String queryString = 'Select Id, Name from ' + objectName + ' where Name like : value';
        
        return Database.query(queryString);
    }
    
    @AuraEnabled
    public static List<SObject> searchKeyword(String objectName, String value, String filter){
        value = '%'+ value + '%';
        System.debug('the value is ' + value);
        String queryString = 'Select Id, Name from ' + objectName + ' where Name like : value ' ;
        if(filter != '' && filter != null){
            queryString += 'and ';
            queryString += filter;
        }
        return Database.query(queryString);
    }

}