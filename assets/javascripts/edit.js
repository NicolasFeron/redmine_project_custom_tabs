$( document ).ready(function() {
	var queries = $("#tab_setting_query_id");
	var url = $("#tab_setting_tab_url");
	queries.change(function() {
		url.val("");
	});
	url.change(function() {
		$('#tab_setting_query_id option:first').prop('selected',true);
	});
});	