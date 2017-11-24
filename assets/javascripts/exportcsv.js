function exportCSV() {
	var titles = [];
	var data = [];

	$('th').each(function() {
		if(!$(this).hasClass("unexportable")){
			titles.push($(this).text());			
		}
	});

	$('td').each(function() {
		data.push($(this).text().trim());
		var colspan = $(this).prop("colSpan")
		if(colspan > 1){
			for(i=1 ; i< colspan; i++){
				data.push("");
			}
		}
	});


	var csv = convertRow2CSV(titles, titles.length);
	csv += convertRow2CSV(data, titles.length);

	var downloadLink = document.createElement("a");
	var blob = new Blob(["\ufeff", csv]);
	var url = URL.createObjectURL(blob);
	downloadLink.href = url;
	downloadLink.download = "data.csv";


	document.body.appendChild(downloadLink);
	downloadLink.click();
	document.body.removeChild(downloadLink);

}

function convertRow2CSV(array, size) {
	var row = ''; 
	var delimeter = ';'; 
	var newLine = '\r\n';
	var plainArr = splitArray(array, size);
	plainArr.forEach(function(arrItem) {
		arrItem.forEach(function(item, idx) {
			row += item + ((idx + 1) === arrItem.length ? '' : delimeter);
		});
		row += newLine;
	});
	return row;
}	

function splitArray(array, size) {
	var splitted = [];
	var result = [];
	array.forEach(function(item, idx) {
		if ((idx + 1) % size === 0) {
			splitted.push(item);
			result.push(splitted);
			splitted = [];
		} else {
			splitted.push(item);
		}
	});
	return result;
}
