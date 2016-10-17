/*****
 *  GlobalUtility is used to deal with logic that will deal generic SObject
 *  Created By: Alvin Zhou
 *  Date: 20/09/2016
 * 
****/
public class tqaopa_GlobalUtility {
    
    /***
     * Description: get SObject type from sobject name and field name
     * Created By: Alvin Zhou
     * Date: 20/09/2016
     * 
     * Parameter
    ****/
    //get Object type
    public static String getSObjectType(String sobjectName, String filedName){
        String targetSobj = '';
        SObjectType sobjType = Schema.getGlobalDescribe().get(sobjectName);
        if(sobjType == null){
            throw new GlobalUtilityException('The object ' + sobjectName + ' is not accessible');
        }
        Map<String,Schema.SObjectField> mfields = sobjType.getDescribe().fields.getMap();
        Schema.SObjectField singleField=mfields.get(filedName);
        if(singleField == null){
            throw new GlobalUtilityException('The field (' + singleField + ') is not accessible for the object ' + sobjectName);
        }
        
        //if it is null point exception, it means that the field is not accessible 
        List<Schema.sObjectType> targetSobjTypes = singleField.getdescribe().getReferenceTo();
        
        if(!targetSobjTypes.isEmpty()){
           targetSobj = targetSobjTypes.get(0).getDescribe().getName(); 
        }else{
            throw new GlobalUtilityException('The field (' + singleField + ') is not an reference field for the object ' + sobjectName);
        }
        return targetSobj;
    }
    
    public static List<Schema.DescribeFieldResult> getFieldApiNames(String sobjectName){
        Schema.SObjectType conversobjTypeType = Schema.getGlobalDescribe().get(sobjectName);
        return getFieldApiNames(conversobjTypeType);
    }
    
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
    
    public static String fillStringWithSlods(
        List<tqaopa_ProductFilterCondition.Filter> filterList, String filterLogic){
        String condition = '';
        Integer strLength = filterLogic.length();
        String numericString = '';
        String tempNumber = '';
        String templateOperator = '';
        System.debug('########The filter logic is #########' + filterLogic);
        System.debug('########The filter list size is #########' + filterList.size());
        for(integer i =0;i<filterLogic.length();i++){
            String s= filterLogic.mid(i,1);
            if(s.isNumeric()){
                numericString +=s;
                tempNumber = numericString;
                if(templateOperator != ''){
                   condition += templateOperator; 
                   templateOperator = '';
                } 
                
            }else{
               templateOperator += s;
               numericString = ''; 
            }
            
            if(numericString == '' && tempNumber != ''){
                Integer indexNum = Integer.valueOf(tempNumber);
                indexNum --;
                tqaopa_ProductFilterCondition.Filter filter = null;
                try{
                   filter = filterList.get(indexNum);
                }catch(Exception ex){
                    throw new GlobalUtilityException('Filter logic provided is incorrect!!!');
                }
                condition += ' ';
                condition += filter.getFilterUnit();
                tempNumber = '';
                if(i == filterLogic.length() -1){
                    condition += s;
                }
            }
        }
        if(tempNumber != ''){
            if(templateOperator != ''){
                condition += templateOperator;
            }
            Integer indexNum = Integer.valueOf(tempNumber);
            indexNum --;
            tqaopa_ProductFilterCondition.Filter filter = null;
            try{
               filter = filterList.get(indexNum);
            }catch(Exception ex){
                throw new GlobalUtilityException('Filter logic provided is incorrect!!!');
            }
            condition += ' ';
            condition += filter.getFilterUnit();
            tempNumber = '';
        }
        return condition;
    }
    
    public static Map<String, Object> handleWithDMLException(DMLException ex){
        Integer errorNumber = ex.getNumDml();
        List<Map<String, String>> errorResults = new List<Map<String, String>>();
        Map<String, Object> errors = new Map<String, Object>();
        for(Integer i = 0; i < errorNumber; i ++){
            Map<String, String> errorMap = new Map<String, String>();
            errorMap.put('index','' + ex.getDmlIndex(i));
            errorMap.put('fields','' + ex.getDmlFields(i));
            errorMap.put('message','' + ex.getDmlMessage(i));
            errorResults.add(errorMap);
        }
        errors.put('errorResults', errorResults);
        errors.put('message', ex.getMessage());
        errors.put('statusCode', ex.getTypeName());
        errors.put('IsSuccess', false);
        
        return errors;
        
    }
    
    public class GlobalUtilityException extends Exception{}
   
    
    
}