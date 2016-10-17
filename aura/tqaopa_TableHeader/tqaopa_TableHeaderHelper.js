({
    switchArrow : function(component) {
        var showArrowDown = component.get("v.showArrowDown");
        component.set("v.showArrowDown", !showArrowDown);
        this.updateArrowClass(component);
    },
    updateArrowClass : function(component){
        if(component.get("v.showArrowDown")){
            component.set("v.arrowUpClass","slds-show");
            component.set("v.arrowDownClass","slds-hide");            
        }else{
            component.set("v.arrowDownClass","slds-show");
            component.set("v.arrowUpClass","slds-hide");
        }
    },
})