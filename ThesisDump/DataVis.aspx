<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/MasterPage1.Master" AutoEventWireup="true" CodeBehind="DataVis.aspx.cs" Inherits="ThesisDump.DataVis" %>
<asp:Content ID="Content1" ContentPlaceHolderID="GridViewContent" runat="server">
    <style>
        .container {
            display: flex;
            flex-wrap: wrap;
            margin-bottom: 20px; /* Spacing between containers */
        }

        .chart-container {
            flex: 1 1 calc(33% - 20px); /* Adjust width and spacing */
            min-width: 300px;
            display: flex;
            flex-direction: column;
            border: 1px solid pink;
            padding: 10px;
            margin: 10px; /* Spacing between chart containers */
        }

        .status-group {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin-top: 20px;
            margin-bottom: 20px; /* Spacing below status containers */
        }

        .status-container {
            flex: 1 1 calc(25% - 20px); /* Adjust width and spacing */
            background-color: #FF99FF;
            color: black;
            text-align: center;
            padding: 10px;
            margin: 10px; /* Spacing between status containers */
        }

        .status-container:last-child {
            margin-right: 0; /* Remove margin-right from the last status container */
        }

        @media (max-width: 768px) {
            .chart-container {
                flex: 1 1 100%;
                min-width: 100%; /* Full width on smaller screens */
            }

            .status-container {
                flex: 1 1 100%;
                min-width: 100%; /* Full width on smaller screens */
            }
        }
    </style>

    <div class="auto-style1">
        <!-- Middle iframe container -->
        <div class="container">
            <div class="chart-container" style="width: 100%; height: 532px;">
                <iframe src="http://localhost:8080/Map.php" style="width: 100%; height: 100%; border: 1px solid pink; display: inline-block;"></iframe>
            </div>
        </div>

        <!-- Status count containers -->
        <div class="status-group">
            <div class="status-container" style="background-color: #FF99FF; color: black;">
                <div class="status-label" style="font-size: x-large;"><strong>TOTAL</strong></div>
                <div class="status-count"><%= ResolvedCount + OngoingCount + OpenCount %></div>
            </div>
            <div class="status-container" style="background-color: #FFFF99; color: black;">
                <div class="status-label" style="font-size: x-large;"><strong>IN-PROGRESS</strong></div>
                <div class="status-count"><%= OngoingCount %></div>
            </div>
            <div class="status-container" style="background-color: #6CFDB7; color: black;">
                <div class="status-label" style="font-size: x-large;"><strong>RESOLVED</strong></div>
                <div class="status-count"><%= ResolvedCount %></div>
            </div>
            <div class="status-container" style="background-color: #b2bdfe; color: black;">
                <div class="status-label" style="font-size: x-large;"><strong>OPEN</strong></div>
                <div class="status-count"><%= OpenCount %></div>
            </div>
        </div>

        <!-- First row of charts in horizontal layout -->
        <div class="container">
            <div class="chart-container">
                <div id="rateChartFilters" style="margin-bottom: 10px;">
                    <label for="rateChartStartDate">Start Date:</label>
                    <input type="date" id="rateChartStartDate" onchange="fetchDataAndDrawRateChart()">
                    <label for="rateChartEndDate">End Date:</label>
                    <input type="date" id="rateChartEndDate" onchange="fetchDataAndDrawRateChart()">
                </div>
                <div id="rate_chart_div" class="chart-container" style="width: 100%; height: 400px;"></div>
            </div>

            <div class="chart-container">
                <div id="rateChangeChartFilters" style="margin-bottom: 10px;">
                    <label for="rateChangeChartStartDate">Start Date:</label>
                    <input type="date" id="rateChangeChartStartDate" onchange="drawRateChangeChart()">
                    <label for="rateChangeChartEndDate">End Date:</label>
                    <input type="date" id="rateChangeChartEndDate" onchange="drawRateChangeChart()">
                </div>
                <div id="rate_change_chart_div" class="chart-container" style="width: 100%; height: 400px;"></div>
            </div>

            <div class="chart-container">
                <div id="genderDonutChartFilters" style="margin-bottom: 10px;">
                    <label for="genderDonutChartStartDate">Start Date:</label>
                    <input type="date" id="genderDonutChartStartDate" onchange="drawGenderDonutChart()">
                    <label for="genderDonutChartEndDate">End Date:</label>
                    <input type="date" id="genderDonutChartEndDate" onchange="drawGenderDonutChart()">
                </div>
                <div id="genderDonutChart" class="auto-style6" style="width: 100%; height: 400px;"></div>
            </div>
        </div>

        <!-- Second row of charts and GridView -->
        <div class="container">
            <div class="chart-container">
                <div id="ageGroupChartFilters" style="margin-bottom: 10px;">
                    <label for="ageGroupChartStartDate">Start Date:</label>
                    <input type="date" id="ageGroupChartStartDate" onchange="drawAgeGroupChart()">
                    <label for="ageGroupChartEndDate">End Date:</label>
                    <input type="date" id="ageGroupChartEndDate" onchange="drawAgeGroupChart()">
                </div>
                <div id="ageGroupChart" class="auto-style5" style="width: 100%; height: 400px;"></div>
            </div>

            <div class="chart-container" style="border: 1px solid pink; padding: 10px;">
                <div class="gridview-wrapper">
                    <input type="hidden" id="MaleCountHiddenField" runat="server" />
                    <input type="hidden" id="FemaleCountHiddenField" runat="server" />

                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" ShowHeader="true" CssClass="minimalisticGridView" AllowPaging="True" PageSize="5" OnPageIndexChanging="GridView1_PageIndexChanging" Height="400px" Width="100%">
                        <Columns>
                            <asp:BoundField DataField="Address" HeaderText="Address" />
                            <asp:BoundField DataField="Count" HeaderText="Number of Cases" />
                        </Columns>
                    </asp:GridView>
                    <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>
                </div>
            </div>
        </div>

        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script type="text/javascript">
            google.charts.load('current', { 'packages': ['corechart'] });

            google.charts.setOnLoadCallback(function () {
                fetchDataAndDrawRateChart();
                drawRateChangeChart();
                drawGenderDonutChart();
                drawAgeGroupChart();
            });

            function fetchDataAndDrawRateChart() {
                var startDate = document.getElementById('rateChartStartDate').value;
                var endDate = document.getElementById('rateChartEndDate').value;

                $.ajax({
                    url: 'http://localhost:8080/WelfareRate.php',
                    type: 'GET',
                    data: {
                        startDate: startDate,
                        endDate: endDate
                    },
                    dataType: 'json',
                    success: function (data) {
                        drawRateChart(data);
                    },
                    error: function (xhr, status, error) {
                        console.error('Error fetching data:', error);
                    }
                });
            }

            function drawRateChart(data) {
                var dataArray = [['Address', 'Welfare Rate']];
                for (var i = 0; i < data.length; i++) {
                    dataArray.push([data[i].Address, parseFloat(data[i].WelfareRate)]);
                }

                var chartData = google.visualization.arrayToDataTable(dataArray);

                var options = {
                    title: 'Welfare Rate by Address',
                    width: '100%',
                    height: 400,
                    vAxis: {
                        minValue: 0
                    },
                    legend: { position: 'none' }
                };

                var chart = new google.visualization.BarChart(document.getElementById('rate_chart_div'));
                chart.draw(chartData, options);
            }

            function drawRateChangeChart() {
                var startDate = document.getElementById('rateChangeChartStartDate').value;
                var endDate = document.getElementById('rateChangeChartEndDate').value;

                // Fetch and draw the rate change chart here using the date range
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Location');
                data.addColumn('number', 'Change');

                data.addRows([
                    ['Binagbag', 5],
                    ['Dayap', -2],
                    ['Ibabang Kinagunan', 3],
                    ['Ilayang Kinagunan', -4],
                    ['Kanlurang Calutan', 2],
                    ['Kanlurang Maligaya', 3],
                    ['Salvacion', -5],
                    ['Silangang Calutan', 5],
                    ['Silangang Maligaya', 2],
                    ['Sildora', 3],
                    ['Poblacion I', -5],
                    ['Poblacion II', 2]
                ]);

                var options = {
                    title: 'Rate of Change in Welfare Rate by Location',
                    hAxis: { title: 'Location', titleTextStyle: { color: '#333' } },
                    vAxis: { minValue: 0 },
                    legend: { position: 'none' }
                };

                var chart = new google.visualization.LineChart(document.getElementById('rate_change_chart_div'));
                chart.draw(data, options);
            }

            function drawGenderDonutChart() {
                var startDate = document.getElementById('genderDonutChartStartDate').value;
                var endDate = document.getElementById('genderDonutChartEndDate').value;

                var maleCountField = document.getElementById('<%= MaleCountHiddenField.ClientID %>');
                var femaleCountField = document.getElementById('<%= FemaleCountHiddenField.ClientID %>');

                if (maleCountField && femaleCountField && maleCountField.value !== "" && femaleCountField.value !== "") {
                    var maleCount = parseInt(maleCountField.value);
                    var femaleCount = parseInt(femaleCountField.value);

                    var data = new google.visualization.DataTable();
                    data.addColumn('string', 'Gender');
                    data.addColumn('number', 'Cases');
                    data.addRows([
                        ['Male', maleCount],
                        ['Female', femaleCount]
                    ]);

                    var options = {
                        title: 'Gender Distribution',
                        pieHole: 0.4,
                        colors: ['#4682B4', '#FF69B4']
                    };

                    var chart = new google.visualization.PieChart(document.getElementById('genderDonutChart'));
                    chart.draw(data, options);
                } else {
                    console.error("Male or female count field is missing or empty.");
                }
            }

            function drawAgeGroupChart() {
                var startDate = document.getElementById('ageGroupChartStartDate').value;
                var endDate = document.getElementById('ageGroupChartEndDate').value;

                // Fetch and draw the age group chart here using the date range
            }
        </script>
    </div>
</asp:Content>
