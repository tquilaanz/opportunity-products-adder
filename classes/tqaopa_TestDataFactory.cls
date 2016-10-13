@isTest
public class tqaopa_TestDataFactory {
    public static Integer numOfRecords = 10;

    public static List<Opportunity> opportunities{
        get{
            return [select Id, Name, PriceBook2Id from Opportunity];
        }
    }
    public static List<PricebookEntry> priceBookEntries{
        get{
            return [select Id from PricebookEntry];
        }
    }
    public static List<Product2> products {
        get{
            return [select Id, Name, ProductCode, Description from Product2];
        }
    }
    
    public static void createOpportunities(){
        List<Schema.DescribeFieldResult> oppFieldResults 
            = tqaopa_GlobalUtility.getFieldApiNames('Opportunity');
        Schema.DescribeFieldResult stageName = null;        
        for(Schema.DescribeFieldResult fieldResult : oppFieldResults){
            if(fieldResult.getName() == 'StageName'){
                stageName = fieldResult;
            }
        }    
        List<Schema.picklistEntry> stageOptions = stageName.getPicklistValues();    
        List<Opportunity> opps = new List<Opportunity>();
        for(Integer i = 0;i<numOfRecords; i++){
            Opportunity opp = new Opportunity();
            opp.name = 'Test Opp' + i;
            opp.CloseDate = Date.today();
            opp.StageName = stageOptions.get(0).getValue();
            opps.add(opp);
        }
        insert opps;
    }
    
    private static void createProducts(){
        List<Product2> prods = new List<Product2>();
        for(Integer i = 0;i<numOfRecords; i++){
            Product2 product = new Product2();
            product.name = 'Test Product ' + i;
            product.IsActive = true;
            prods.add(product);
        }
        insert prods;
    }
    
    public static void createProductsAndPriceBookEntries(){
        createProducts();
        Id priceBookId = Test.getStandardPricebookId();
        List<PricebookEntry> pbEntries = new List<PriceBookEntry>();
        for(Product2 prod: products){
            PriceBookEntry pbEntry = new PriceBookEntry();
            pbEntry.product2Id = prod.Id;
            pbEntry.UnitPrice = 10;
            pbEntry.PriceBook2Id = priceBookId;
            pbEntry.IsActive = true;
            pbEntries.add(pbEntry);
        }
        
        insert pbEntries;
        
        
    }
    
    public static String prepareJSONForCreatingOppProdsWithException(){
        createProductsAndPriceBookEntries();
        String jsonString = '[{"quantity":null,"serviceDate":"2016-10-06","description":"t' 
                + 0 + '","productName":"GenWatt Diesel 200kW","salesPrice":25000,"priceBookEntryId":"'
                + priceBookEntries.get(0).Id + '","errors":{"quantity":"","salesPrice":""}}';
        for(Integer i = 1;i<priceBookEntries.size();i++){
            PricebookEntry pbEntry = priceBookEntries.get(i);
            String oppItemJSON = ',{"quantity":1,"serviceDate":"2016-10-06","description":"t' 
                + i + '","productName":"GenWatt Diesel 200kW","salesPrice":25000,"priceBookEntryId":"'
                + pbEntry.Id +'","errors":{"quantity":"","salesPrice":""}}';
            jsonString = jsonString + oppItemJSON;
        }
        jsonString = jsonString +  ']';
        System.debug('JsonString  is ' + jsonString);
        return jsonString;
        
    }
    
    public static String prepareJSONForCreatingOppProds(){
        createProductsAndPriceBookEntries();
        String jsonString = '[{"quantity":1,"serviceDate":"2016-10-06","description":"t' 
                + 0 + '","productName":"GenWatt Diesel 200kW","salesPrice":25000,"priceBookEntryId":"'
                + priceBookEntries.get(0).Id + '","errors":{"quantity":"","salesPrice":""}}';
        for(Integer i = 1;i<priceBookEntries.size();i++){
            PricebookEntry pbEntry = priceBookEntries.get(i);
            String oppItemJSON = ',{"quantity":1,"serviceDate":"2016-10-06","description":"t' 
                + i + '","productName":"GenWatt Diesel 200kW","salesPrice":25000,"priceBookEntryId":"'
                + pbEntry.Id +'","errors":{"quantity":"","salesPrice":""}}';
            jsonString = jsonString + oppItemJSON;
        }
        jsonString = jsonString +  ']';
        System.debug('JsonString  is ' + jsonString);
        return jsonString;
        
    }
    
    

}