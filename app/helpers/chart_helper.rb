module ChartHelper
	def display_pie_chart title, list
		data = ""
		list.each do |label, value|
			data << "['#{label}',#{value}],"
		end
		js = """
		  google.charts.load('current', {packages:['corechart']});
		  google.charts.setOnLoadCallback(drawChart);
		  function drawChart() {
			var data = google.visualization.arrayToDataTable([
			  ['Task', '#{title}'],
			  #{data}
			]);

			var options = {
			  title: '#{title}',
			  is3D: true,
			};

			var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
			chart.draw(data, options);
		  }
		
		"""
		javascript_tag js, defer: 'defer'
	end
end