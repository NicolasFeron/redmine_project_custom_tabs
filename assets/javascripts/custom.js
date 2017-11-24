function toggleRow(el) {
	var tr = $(el).parents('tr').first();
	var n = tr.next();
	tr.toggleClass('open');
	while (n.length && !n.hasClass('group')) {
		n.toggle();
		n = n.next('tr');
	}
	$(".close").hide();
}

$( document ).ready(function() {
	$("#content_model").empty()
	$("#content_model").load( location.href.replace("default","custom_model_html"), function() {
	});
});	