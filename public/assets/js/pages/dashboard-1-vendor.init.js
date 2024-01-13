/*var colors = ["#f1556c"],
    dataColors = $("#total-revenue").data("colors");
dataColors && (colors = dataColors.split(","));
var options = {
        series: [68],
        chart: {
            height: 242,
            type: "radialBar"
        },
        plotOptions: {
            radialBar: {
                hollow: {
                    size: "65%"
                }
            }
        },
        colors: colors,
        labels: ["Revenue"]
    },
    chart = new ApexCharts(document.querySelector("#total-revenue"), options);*/
//chart.render();
colors = ["#1abc9c", "#4a81d4"];
(dataColors = $("#sales-analytics").data("colors")) && (colors = dataColors.split(","));
$(document).ready(function() {

    // var data_line_chart;

    getUrl=window.location;
    var baseUrl = getUrl.protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];

    line_chart_url=baseUrl+"/line-chart";
    // Line Chart
    $.ajax({

        url:line_chart_url,

    }).done(function(data) {
        console.log(Object.values(data.order_amount));
        console.log(data.order_amount);
        console.log(data.date_format);
        options = {
            series: [{
                name: "الارباح",
                type: "column",
                data: Object.values(data.order_amount)
            }, {
                name: "المبيعات",
                type: "line",
                data: Object.values(data.order)
            }],
            chart: {
                height: 378,
                type: "line",
                offsetY: 10
            },
            stroke: {
                width: [2, 3]
            },
            plotOptions: {
                bar: {
                    columnWidth: "50%"
                }
            },
            colors: colors,
            dataLabels: {
                enabled: !0,
                enabledOnSeries: [1]
            },
            labels:Object.values(data.date_format),
            xaxis: {
                type: "datetime"
            },
            legend: {
                offsetY: 7
            },
            grid: {
                padding: {
                    bottom: 20
                }
            },
            fill: {
                type: "gradient",
                gradient: {
                    shade: "light",
                    type: "horizontal",
                    shadeIntensity: .25,
                    gradientToColors: void 0,
                    inverseColors: !0,
                    opacityFrom: .75,
                    opacityTo: .75,
                    stops: [0, 0, 0]
                }
            },
            yaxis: [{
                title: {
                    text: "الارباح"
                }
            }, {
                opposite: !0,
                title: {
                    text: "المبيعات"
                }
            }]
        };
       // chart = new ApexCharts(document.querySelector("#total-revenue"), options);
       // chart.render();
        (chart = new ApexCharts(document.querySelector("#sales-analytics"), options)).render(), $("#dash-daterange").flatpickr({
            altInput: !0,
            mode: "range",
            altFormat: "F j, y",
            defaultDate: "today"
        });
    });
});


