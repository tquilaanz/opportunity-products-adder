({
	updateRecordView : function(component) {
        var paginationInfo = component.get("v._pagination_info");
        var records = component.get("v._records");
        var numPerPage = paginationInfo.numPerPage;
        var pageNumber = paginationInfo.pageNumber;      
	    var totalSize = paginationInfo.totalSize;
        
        var recordsOfCurrentPage = records.slice((pageNumber-1) * numPerPage , (pageNumber) * numPerPage);        
        component.set("v._display_items", recordsOfCurrentPage); 		
	},
    initiatePaginationInfo: function(component){
        var records = component.get("v._records");
        var numPerPage = component.get("v._num_per_page");
        
        var totalSize = records.length;
		var totalPages = Math.floor(totalSize/numPerPage);

        if(totalSize%numPerPage > 0){
            totalPages ++;
        }
        if(!totalPages){
           totalPages = 0; 
        }
        var paginationInfo = {
            "numPerPage": numPerPage,
            "pageNumber": 1,
            "totalPages": totalPages,
            "totalSize": totalSize,
            "recordNumSelected": 0
        };
		component.set("v._pagination_info",paginationInfo);
    }
})