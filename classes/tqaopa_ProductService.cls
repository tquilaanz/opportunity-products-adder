/****
 *  Description: ProductService is used to manage the logic relationship in product2 object
 *  Created By: Alvin Zhou
 *  Created Date: 30/09/2016
 * 
******/
public class tqaopa_ProductService {
    
   
    public List<Product2> searchProductsByCriteria(Id pricebookId, String condition, String keyword){
        List<Product2> records = new List<Product2>();
        List<List<SObject>> results = tqaopa_ProductSelector.searchProductsByCriteria(pricebookId, condition, keyword);
        if(!results.isEmpty()){
            records = results.get(0);
        }
        
        return records;
    }
    
}