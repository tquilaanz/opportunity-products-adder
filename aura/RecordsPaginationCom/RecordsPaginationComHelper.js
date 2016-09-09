({
	updateRecordView : function(component, pageNumber) {
        pageNumber --;
        
        var allRecords = component.get("v.allRecords");        
        var numPerPage = component.get("v.numPerPage");
        
        
	    var totalSize = allRecords.length;
        var totalPages = Math.floor(totalSize/numPerPage);
        if(totalSize%numPerPage > 0){
            totalPages ++;
        }
        var recordsOfCurrentPage = allRecords.slice(pageNumber * numPerPage , (pageNumber + 1) * numPerPage);
        
        component.set("v.totalPages", totalPages);
        component.set("v.totalSize", totalSize);  
        component.set("v.recordsOfCurrentPage", recordsOfCurrentPage); 		
	}
})