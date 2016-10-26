public class tqaopa_ProductFilterCondition {
    public static tqaopa_ProductFilterCondition create(String filterConditionString){
        tqaopa_ProductFilterCondition condition = (tqaopa_ProductFilterCondition)JSON.deserialize(filterConditionString, tqaopa_ProductFilterCondition.class);
        return condition;
    }
    private tqaopa_ProductFilterCondition(){
        
    }
    private void setupFilterLogic(){
        if(filterLogic == null && !filterList.isEmpty()){
            filterLogic = ' 1 ';
            for(Integer i = 1; i< filterList.size(); i++){
                Integer index = i + 1;
                filterLogic = filterLogic + ' and ' + index;
            }
        }
        System.debug('########The filterLogic is #########' + filterLogic);
    }
    
    //Return condition string
    public String generateConditions(){
       setupFilterLogic();
       String condition = '';
       if(filterLogic != null && filterLogic != ''){
            condition = tqaopa_GlobalUtility.fillStringWithSlods(filterList, filterLogic);
       }
       System.debug('########The condition is #########' + condition);
       
       
       return condition;
    }
    
    public Boolean isForSearch{
        get{
            return (keyword != null && keyword != '');
        }
    }
    
    public String keyword {set;get;}
    public List<Filter> filterList {
        set;
        get{
            if(filterList == null){
                return new List<Filter>();
            }
            for(Filter filterUnit: filterList){
                
                System.debug('######## The isForSearch is  #########' + isForSearch );
               if(!isForSearch){
                   filterUnit.crossObj = 'Product2.';
               }else{
                   filterUnit.crossObj = '';
               }
            }
            return filterList;
        }}
    public String orderBy {set;get;}
    public String filterLogic {set;get;}
    public class Filter{
        public String getFilterUnit(){
            System.debug('######## The field is  #########' + field);
            System.debug('######## The operator is  #########' + operator);
            System.debug('######## The value is  #########' + value);
            System.debug('######## The fieldType is  #########' + fieldType);
            String filterUnit = '';
            field = crossObj + field.trim();
            String valueUnit = value;
            field = String.escapeSingleQuotes(field);
            
            valueUnit = String.escapeSingleQuotes(valueUnit);
            
            if(operator.contains('like')){
                valueUnit =  '\'%' + valueUnit +'%\' ';
            }else if(fieldType != 'INTEGER' 
                && fieldType != 'DOUBLE' && fieldType != 'DATE'
                && fieldType != 'DATETIME' && fieldType != 'BOOLEAN'){
                valueUnit = ' \'' + valueUnit + '\' ';
            }
            
            if(fieldType == 'DATETIME'){
                field = ' DAY_ONLY(' + field + ') ';
            }
            
            if(fieldType == 'BOOLEAN' && 
                (valueUnit ==null || valueUnit == '')){
                valueUnit = ' false ';
            }
            
            if(operator == ' = null ' || operator == ' != null '){
                valueUnit = '';
            }
            
            
            if(operator.contains('not like')){
                filterUnit = ' ( not ' + field + ' like  ' + valueUnit +') ';
            }else{
                filterUnit = field + ' ' + operator +' ' + valueUnit;
            }
            System.debug('######## The filter unit is  #########' + filterUnit);
            return filterUnit;
        }
        
        public String crossObj{set;get;}
        public String field {set;get;}
        public String label {set;get;}
        public String operator {set;get;}
        public String value {set;get;}
        public String operatorlabel {set;get;} 
        public String fieldType {set;get;} 
    }
    
    
    

}