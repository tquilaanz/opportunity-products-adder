public class GlobalUtility {
    
     public static List<Schema.DescribeFieldResult> getFieldApiNames(SObjectType sobjType){
        Map<String,Schema.SObjectField> mfields = sobjType.getDescribe().fields.getMap();
        List<Schema.DescribeFieldResult> fieldListResults = new List<Schema.DescribeFieldResult>(); 
        for(String key : mfields.keySet()){
            Schema.SObjectField singleField=mfields.get(key);
            Schema.DescribeFieldResult describeFieldResult=singleField.getDescribe();
            if(describeFieldResult.isAccessible()){
                fieldListResults.add(describeFieldResult);
            }
        }
        return fieldListResults;
     }
     
     public static String queryConditions( Conditions cond, Boolean SOQL){
        String prefix = '';
        if(SOQL){
            prefix = 'Product2.';
        }
        List<Schema.DescribeFieldResult> fieldListResults 
            = GlobalUtility.getFieldApiNames(Product2.SobjectType);
        Map<String, Schema.DescribeFieldResult> fieldResultMap 
            = new Map<String, Schema.DescribeFieldResult>();
        for(Schema.DescribeFieldResult result: fieldListResults){
            fieldResultMap.put(result.getName(), result);
        }
        Map<String, Conditions.Filter> filterMap = cond.criteriaMap;
        String queryString = '';
        for(String cId: filterMap.keySet()){
            Conditions.Filter filter = filterMap.get(cId);
            if(filter.operator == null || filter.fieldName == null){
                continue;
            }
            String operator = filter.operator;
            String fieldName = filter.fieldName;
            String fieldValue = filter.fieldValue;
            String unitQuery = '' ;
            String operatorRAW = '';
            Schema.DescribeFieldResult result 
                = fieldResultMap.get(fieldName);
            System.debug('Field Name is ' + fieldName);
            if(operator == 'Equals'){
                operatorRAW = ' = ';
            }else if(operator == 'Not equals'){
                operatorRAW = ' != ';
            }else if(operator == 'Contains'){
                operatorRAW = ' like ';
            }else if(operator == 'Start with'){
                operatorRAW = ' like ';
            }
            
            fieldName = prefix + fieldName;
            if(fieldValue != null){
                //Translate Field Value
                if(result.getType() == Schema.DisplayType.Currency 
                    || result.getType() == Schema.DisplayType.Double){
                    if(operator == 'Contains' || operator == 'Start with' ){
                        continue;
                    }
                    unitQuery = fieldName + operatorRAW + Double.valueOf(fieldValue);
                }else if(result.getType() == Schema.DisplayType.ID 
                    || result.getType() == Schema.DisplayType.Reference){
                    if(operator == 'Contains' || operator == 'Start with' ){
                        continue;
                    }
                    unitQuery = fieldName + operatorRAW + '\'' +(String) fieldValue +'\'';
                    
                }else if(result.getType() == Schema.DisplayType.Date){
                    if(operator == 'Contains' || operator == 'Start with' ){
                        continue;
                    }
                    unitQuery = fieldName + operatorRAW + Date.valueOf(fieldValue);
                    
                }else if(result.getType() == Schema.DisplayType.DateTime){
                    if(operator == 'Contains' || operator == 'Start with' ){
                        continue;
                    }
                    unitQuery = fieldName + operatorRAW + DateTime.valueOf(fieldValue);
                    
                }else if(result.getType() == Schema.DisplayType.Integer){
                   if(operator == 'Contains' || operator == 'Start with' ){
                        continue;
                    }
                    unitQuery = fieldName + operatorRAW + Integer.valueOf(fieldValue); 
                }else if(result.getType() == Schema.DisplayType.MultiPicklist){
                    continue;   
                }else if(result.getType() == Schema.DisplayType.Email 
                    || result.getType() == Schema.DisplayType.String 
                    || result.getType() == Schema.DisplayType.TextArea
                    || result.getType() == Schema.DisplayType.Picklist){
                    if(operator != 'Contains' ){
                        unitQuery = fieldName + operatorRAW + '\'' +(String) fieldValue +'\'';
                    }else if(operator == 'Start with' ){
                        unitQuery = fieldName + operatorRAW + '\'%' +(String) fieldValue +'\'';
                    }else{
                        unitQuery = fieldName + operatorRAW + '\'%' +(String) fieldValue +'%\'';
                    }
                }
                
                if(queryString == ''){
                    queryString = unitQuery;
                }else{
                    queryString = queryString + ' and ' + unitQuery;
                }
            }
            
        }
        
        return queryString;
    }

}