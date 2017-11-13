$( window ).load(fill);

var projects = document.getElementById("tab_setting_project_id");
var queries = document.getElementById("tab_setting_query_id");
projects.addEventListener("change", fill);

function fill() {
	while (queries.firstChild) 
		queries.removeChild(queries.firstChild);
	
	$.getJSON( location.origin + "/queries.json", function( data ) {	
		queries.add(document.createElement("option"));
		$.each( data.queries, function( k, v ) {
			if (v.project_id == projects.value) {
				var option = document.createElement("option");
				option.text = v.name;
				option.value = v.id;
				queries.add(option);
			}
		});
	});
}