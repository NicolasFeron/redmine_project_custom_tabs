var queries = document.getElementById("tab_setting_query_id");

var url = document.getElementById("tab_setting_tab_url");

queries.addEventListener("change", clear_url);

url.addEventListener("change", clear_query);


function clear_query() {
	queries.selectedIndex = "0";
}
function clear_url() {
	url.value = "";
}