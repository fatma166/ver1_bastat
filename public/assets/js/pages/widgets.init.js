function hexToRGB(t,i){var a=parseInt(t.slice(1,3),16),e=parseInt(t.slice(3,5),16),o=parseInt(t.slice(5,7),16);return i?"rgba("+a+", "+e+", "+o+", "+i+")":"rgb("+a+", "+e+", "+o+")"}$(document).ready(function(){function i(){var t=["#00acc1","#f1556c"],i=$("#lifetime-sales").data("colors");i&&(t=i.split(",")),$("#lifetime-sales").sparkline([0,23,43,35,44,45,56,37,40],{type:"line",width:"100%",height:"220",chartRangeMax:50,lineColor:t[0],fillColor:hexToRGB(t[0],.3),highlightLineColor:"rgba(0,0,0,.1)",highlightSpotColor:"rgba(0,0,0,.2)",maxSpotColor:!1,minSpotColor:!1,spotColor:!1,lineWidth:1}),$("#lifetime-sales").sparkline([25,23,26,24,25,32,30,24,19],{type:"line",width:"100%",height:"220",chartRangeMax:40,lineColor:t[1],fillColor:hexToRGB(t[1],.3),composite:!0,highlightLineColor:"rgba(0,0,0,.1)",highlightSpotColor:"rgba(0,0,0,.2)",maxSpotColor:!1,minSpotColor:!1,spotColor:!1,lineWidth:1}),t=["#00acc1"],(i=$("#income-amounts").data("colors"))&&(t=i.split(",")),$("#income-amounts").sparkline([3,6,7,8,6,4,7,10,12,7,4,9,12,13,11,12],{type:"bar",height:"220",barWidth:"10",barSpacing:"3",barColor:t}),t=["#00acc1","#4b88e4","#e3eaef","#fd7e14"],(i=$("#total-users").data("colors"))&&(t=i.split(",")),$("#total-users").sparkline([20,40,30,10],{type:"pie",width:"220",height:"220",sliceColors:t})}var a;i(),$(window).resize(function(t){clearTimeout(a),a=setTimeout(function(){i()},300)})}),$('[data-plugin="peity-pie"]').each(function(t,i){var a=$(this).attr("data-colors")?$(this).attr("data-colors").split(","):[],e=$(this).attr("data-width")?$(this).attr("data-width"):20,o=$(this).attr("data-height")?$(this).attr("data-height"):20;$(this).peity("pie",{fill:a,width:e,height:o})}),$('[data-plugin="peity-donut"]').each(function(t,i){var a=$(this).attr("data-colors")?$(this).attr("data-colors").split(","):[],e=$(this).attr("data-width")?$(this).attr("data-width"):20,o=$(this).attr("data-height")?$(this).attr("data-height"):20;$(this).peity("donut",{fill:a,width:e,height:o})}),$('[data-plugin="peity-donut-alt"]').each(function(t,i){$(this).peity("donut")}),$('[data-plugin="peity-line"]').each(function(t,i){$(this).peity("line",$(this).data())}),$('[data-plugin="peity-bar"]').each(function(t,i){var a=$(this).attr("data-colors")?$(this).attr("data-colors").split(","):[],e=$(this).attr("data-width")?$(this).attr("data-width"):20,o=$(this).attr("data-height")?$(this).attr("data-height"):20;$(this).peity("bar",{fill:a,width:e,height:o})}),$('[data-plugin="knob"]').each(function(t,i){$(this).knob()});