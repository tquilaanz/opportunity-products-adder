public class tqaopa_Products {
    public List<Product2> records {private set; public get;}
    public tqaopa_Products(List<Product2> records){
        this.records = records;
    }
    
    public List<Id> getRecordIds(){
        List<Id> recordIds = new List<Id>();
        for(Product2 record: records){
            recordIds.add(record.Id);
        }
        return recordIds;
    }
    
}