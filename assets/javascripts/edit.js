$( document ).ready(function() {
	var queries = $("#tab_setting_query_id");
	var url = $("#tab_setting_tab_url");
	var models = $("#tab_setting_tab_setting_model_id");
	if(url.val() != ""){
		$("#tab_setting_model_zone").hide();
	}
	queries.change(function() {
		url.val("");
		$("#tab_setting_model_zone").show();
	});
	url.change(function() {
		$('#tab_setting_query_id option:first').prop('selected',true);
		$('#tab_setting_tab_setting_model_id option:first').prop('selected',true);
		$("#tab_setting_model_zone").hide();
	});
});	