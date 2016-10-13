@isTest
private class tqaopa_LookUpControllersTest {

    private static testMethod void testGetTargetSObjectName() {
        System.assertEquals(
            tqaopa_LookUpControllers.getTargetSObjectName('Contact', 'AccountId'), 'Account');
            
    }
    
    private static testMethod void testSearchKeyword() {
        Account acc = new Account(Name = 'Test Account for search');
        insert acc;
        
        System.assertEquals(tqaopa_LookUpControllers.searchKeyword('Account', 'test').size(), 1);
        System.assertEquals(tqaopa_LookUpControllers.searchKeyword('Account', 'test', null).size(), 1);
        System.assertEquals(
            tqaopa_LookUpControllers.searchKeyword('Account', 'Not Existing Account').size(), 0);
            
    }

}