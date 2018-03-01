		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type ="text/css" > .center {text-align: center;} body { font-family: "Helvetica Neue", Helvetica, Arial; font-size: 14px; line-height: 20px; font-weight: 400; color: #3b3b3b; -webkit-font-smoothing: antialiased; font-smoothing: antialiased;} .wrapper { margin: 0 auto; padding: 40px; max-width: 800px; } .table { margin: 0 0 40px 0; width: 100%; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2); display: table; } @media screen and (max-width: 580px) { .table { display: block; } } .row { display: table-row; background: #f6f6f6; } .row:nth-of-type(odd) { background: #e9e9e9; } .row.header { font-weight: 900; color: #ffffff; background: #ea6153; } .row.green { background: #27ae60; } .row.blue { background: #2980b9; } @media screen and (max-width: 580px) { .row { padding: 8px 0; display: block; } } .cell { padding: 6px 12px; display: table-cell; } @media screen and (max-width: 580px) { .cell { padding: 2px 12px; display: block; } } </style>		
	<head> 
	<div >
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {

        var data = google.visualization.arrayToDataTable([
          ['Users', 'View percentage'],
          <c:forEach items="${data}" var="entry">
          ['${entry.key}', ${entry.value}],
          </c:forEach>
        ]);

        var options = {
          title: 'Usage Distribution of top 10 users'
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

        chart.draw(data, options);
      }
    </script>
	</head>
	
	<h1 class= "center">-------Tarun Sunkaraneni's Log File User Analyzer--------</h1>
	<div class="center">
		<form method="POST" enctype="multipart/form-data" action="/">
		<h2> Upload your file here:<p><a href="/log/log.log">Sample Log File</a></p></h2>
			<table align="center">
				<tr><td></td><td><input type="file" name="file" /></td></tr>
				<tr><td></td><td><input type="submit" value="Upload" /></td></tr>
			</table>
		</form>
	</div>
	<div style="display:${display};" align="center" >
	<div id="piechart" style="width: 600px; height: 350px;"></div>
		<div align="center" >
			<div class="row header">
				<h2 class="cell">Username</h2>
				<h2 class="cell">Page Views</h2>
			</div>
			<c:forEach items="${data}" var="entry">
				<div class="row">
			    		<h3 class="cell">${entry.key}</h3> 
			    		<h3 class="cell">${entry.value}</h3>
			    	</div>
			</c:forEach>
		<div>
	</div>
