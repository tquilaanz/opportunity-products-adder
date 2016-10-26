public class tqaopa_LookUpControllers {
    
    @AuraEnabled
    public static String getTargetSObjectName(String sobjectName, String fieldName){
       String targetSObjectName = tqaopa_GlobalUtility.getSObjectType(sobjectName, fieldName);
       return targetSObjectName; 
    }
    
    @AuraEnabled
    public static List<SObject> searchKeyword(String objectName, String value){
        value = '%'+ value + '%';
        System.debug('the value is ' + value);
        String queryString = 'Select Id, Name from ' + String.escapeSingleQuotes(objectName) + ' where Name like : value';
        
        return Database.query(queryString);
    }
    
    @AuraEnabled
    public static List<SObject> searchKeyword(String objectName, String value, String filter){
        value = '%'+ value + '%';
        System.debug('the value is ' + value);
        String queryString = 'Select Id, Name from ' + String.escapeSingleQuotes(objectName) + ' where Name like : value ' ;
        if(filter != '' && filter != null){
            queryString += 'and ';
            queryString += String.escapeSingleQuotes(filter);
        }
        return Database.query(queryString);
    }

}