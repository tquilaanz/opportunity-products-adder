@isTest
private class tqaopa_GlobalUtilityTest {

    static testMethod void getSObjectTypeTest() {
        System.assertEquals(tqaopa_GlobalUtility.getSObjectType('Contact', 'AccountId'),'Account');
    }
    static testMethod void getFieldApiNamesTest(){
        System.assert(tqaopa_GlobalUtility.getFieldApiNames('Contact').size()>0);
    }
}