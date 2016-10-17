({
	updateValue : function(component, event, helper) {
        component.set("v._value", event.target.checked);
	},
    checkValue : function(component, event, helper){
        var value = component.get("v._value");
        console.log('value is ' + value);
    }
})