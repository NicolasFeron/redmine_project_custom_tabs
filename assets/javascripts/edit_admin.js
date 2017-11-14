function fill(project_id) {
	var queries = $("#tab_setting_query_id");
	queries.empty();	

	$.getJSON( location.origin + "/tab_setting/queries.json?project_id=" + project_id,function( data ) {	
		$.each( data, function(i, query) {
			queries.append($('<option>', {value: query.id, text: query.name }));
		});
	});
}

$( document ).ready(function() {
	$("#tab_setting_project_id").change(function() {
		fill($(this).val());
	});
});