({
	changePage : function(component, event, helper) {
		console.log("changes made");
        var pageNumber = component.get("v.pageNumber");
        
      	helper.updateRecordView(component, pageNumber);
	},
    resetAllData : function(component, event, helper){
        //Initiate the page number 
        component.set("v.pageNumber", 1);
        var pageNumber = component.get("v.pageNumber");
        
      	helper.updateRecordView(component, pageNumber);              
    },
    broadCastTotalPages : function(component, event, helper){
		var totalPages = component.get("v.totalPages");
        var numPerPage = component.get("v.numPerPage");
        var paginationEvent = component.getEvent("pagination"); 
               
        paginationEvent.setParams({
            "message": "Pagination Tester",
            "totalPageNumber": "" + totalPages,
            "numPerPage": "" +numPerPage
        });
        paginationEvent.fire();
     },
    
     changeReocrds : function(component, event, helper){
		var records = component.get("v.recordsOfCurrentPage");
        var allRecords = component.get("v.allRecords");
         
        
     }
})