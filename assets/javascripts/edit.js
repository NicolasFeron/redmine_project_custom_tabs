$( document ).ready(function() {
	var project = $("#tab_setting_project_id");
	var queries = $("#tab_setting_query_id");
	var url = $("#tab_setting_tab_url");
	var models = $("#tab_setting_tab_setting_model_id");
	var save = $("#save_button");
	var model = $("#tab_setting_model_zone");
	
	save.prop('disabled', true);
	project.prop('required', true);
	model.hide()
	
	if(url.val() != ""){
		model.hide();
	}
	queries.change(function() {
		url.val("");
		model.show();
		if(queries.val() == ""){
			model.hide();
		}		
		can_save(queries);	
	});
	url.change(function() {
		$('#tab_setting_query_id option:first').prop('selected',true);
		$('#tab_setting_tab_setting_model_id option:first').prop('selected',true);
		model.hide();
		can_save(url);
	});
	
	function can_save(element){
		save.prop('disabled', false);
		if(element.val() == ""){
			save.prop('disabled', true);
		}	
	}
	
});	