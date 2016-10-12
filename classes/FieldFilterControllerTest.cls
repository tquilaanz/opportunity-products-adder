@isTest
private class FieldFilterControllerTest {

	private static testMethod void getFieldOptionsTest() {
	    System.assert(FieldFilterController.getFieldOptions('Account').size()>0);

	}

}