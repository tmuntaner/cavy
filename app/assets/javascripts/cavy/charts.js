$(document).ready(function() {

  // Load Google visualization library if a chart element exists
  if ($('[data-chart]').length > 0) {
    $.getScript('https://www.google.com/jsapi', function (data, textStatus) {
      google.load('visualization', '1.0', { 'packages': ['corechart'], 'callback': function () {
        // Google visualization library loaded

        $('[data-chart]').each(function () {
          var div = $(this)
          // Fetch chart data
          $.getJSON(div.data('chart'), function (data) {
            // Create DataTable from received chart data
            var table = new google.visualization.DataTable();
            $.each(data.cols, function () { table.addColumn.apply(table, this); });
            table.addRows(data.rows);


            // Draw the chart
            var chart = new google.visualization.ChartWrapper();
            chart.setChartType(data.type);
            chart.setDataTable(table);
            chart.setOptions(data.options);

            var width   = $('#overview').width();
            var height  = width*0.40;

            // chart.setOption('backgroundColor', $('body').css('background-color') );
            chart.setOption('width', width);
            chart.setOption('height', height);
            chart.draw(div.get(0));
          });
        });
      }});
    });
  }
});