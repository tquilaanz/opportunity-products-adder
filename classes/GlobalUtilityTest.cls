@isTest
private class GlobalUtilityTest {

    static testMethod void getSObjectTypeTest() {
    	System.assertEquals(GlobalUtility.getSObjectType('Contact', 'AccountId'),'Account');
    }
    static testMethod void getFieldApiNamesTest(){
        System.assert(GlobalUtility.getFieldApiNames('Contact').size()>0);
    }
}