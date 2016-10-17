({
    cancel: function(component, event, helper){
        component.set("v._error", '');
		helper.fireHandleOppProductsEvent(component, "cancel");
    },
    save: function(component, event, helper){
        if(helper.validateRequiredField(component)){
            helper.fireHandleOppProductsEvent(component, "save");        
        }
    },
    handleErrors: function(component, event, helper){

        var response =event.getParam('arguments')._server_response;
        helper.handleErrorOfOppItemsCreation(response, component);
    }
})