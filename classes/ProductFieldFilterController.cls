public class ProductFieldFilterController {
    
    public class OptionList{
        public OptionList(String label, String value){
            this.label = label;
            this.value = value;
        }
        
        @AuraEnabled
        public String label {private set;get;}
        @AuraEnabled
        public String value {private set;get;}
    }
    
    
        
    @AuraEnabled
    public static OptionList[] getFieldOptions(){
        List<Schema.DescribeFieldResult> fieldList = GlobalUtility.getFieldApiNames(Product2.SobjectType);
        
        List<OptionList> options = new List<OptionList>();
        for(Schema.DescribeFieldResult fieldResult : fieldList){
            options.add(new OptionList( fieldResult.getLabel(), fieldResult.getName()));
        }
        return options;
    }

}