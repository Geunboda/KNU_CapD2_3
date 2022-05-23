import React, { useEffect, useState } from "react";
import * as am4core from "@amcharts/amcharts4/core";
import * as am4charts from "@amcharts/amcharts4/charts";

function Chart() {
  useEffect(() => {
    //chart instance 생성
    let chart = am4core.create("chartdiv", am4charts.PieChart);
    chart.data = [
      { label: "coyote-http", prob: 90 },
      { label: "coyote-http2", prob: 25 },
      { label: "cubrid", prob: 10 },
      { label: "arjuna", prob: 8 },
      { label: "empty", prob: 5 },
      { label: "hazelcast", prob: 3 },
      { label: "hazelcast-wait", prob: 1 },
      { label: "coyote-1", prob: 0.77 },
      { label: "coyote-ajp", prob: 0.3 },
      { label: "ibatis-1", prob: 0.222 },
    ];

    //series 추가 및 설정
    let pieSeries = chart.series.push(new am4charts.PieSeries());
    pieSeries.dataFields.value = "prob";
    pieSeries.dataFields.category = "label";

    chart.innerRadius = am4core.percent(55);

    chart.legend = new am4charts.Legend();
    chart.legend.valueLabels.template.text = "{value.value}" + "%";

    pieSeries.labels.template.disabled = true;
    pieSeries.ticks.template.disabled = true;

    pieSeries.slices.template.tooltipText = "{category}: {value.value}" + "%";

    pieSeries.colors.list = [
      am4core.color("#5B1A2A"),
      am4core.color("#AF3B57"),
      am4core.color("#EE7290"),
      am4core.color("#ECA0B3"),
      am4core.color("#F0CDD6"),
      am4core.color("#F91C52"),
      am4core.color("#FF8042"),
      am4core.color("#AC1B3E"),
      am4core.color("#DB9FAE"),
      am4core.color("#FF003F"),
    ];
  }, []);
  return <div id="chartdiv" style={{ width: "100%", height: "80%" }}></div>;
}

export default Chart;
