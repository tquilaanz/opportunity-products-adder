@isTest
private class tqaopa_FieldFilterControllerTest {

    private static testMethod void getFieldOptionsTest() {
        System.assert(tqaopa_FieldFilterController.getFieldOptions('Account').size()>0);

    }

}