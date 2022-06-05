import React, { useEffect, useState } from "react";
import styled from "styled-components";
import "./App.css";
import { GlobalStyle } from "./globalstyle";
import * as am4core from "@amcharts/amcharts4/core";
import * as am4charts from "@amcharts/amcharts4/charts";

const Div = styled.div`
  width: 100vw;
  height: 100vh;
  background-color: #5b1a2a;
  display: flex;
  padding: 5%;
  justify-content: center;
  align-items: center;
`;
const Content = styled.div`
  width: 50%;
  height: 100%;
  background-color: white;
  border-radius: 15px;
  position: relative;
`;

const TitleDiv = styled.div`
  font-size: 1.8rem;
  font-weight: bold;
  display: flex;
  width: 100%;
  height: 15%;
  align-items: center;
  justify-content: center;
  margin-bottom: -15px;
`;

const ResultDiv = styled.div`
  font-size: 1.4rem;
  display: flex;
  width: 100%;
  height: 8%;
  align-items: center;
  justify-content: center;
`;

const Logos = styled.div`
  width: 100%;
  height: 5%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 50px;
  position: absolute;
  bottom: 20px;
`;
const Logo = styled.img`
  width: 20%;
`;
function App() {
  const [data, setData] = useState<any[]>([]);
  useEffect(() => {
    async function fetchData() {
      await fetch("/predict")
        .then((response) => response.json())
        .then((result) => setData(result));
    }
    fetchData();
  }, []);

  function Chart() {
    useEffect(() => {
      //chart instance 생성
      let chart = am4core.create("chartdiv", am4charts.PieChart);
      chart.data = data;

      //series 추가 및 설정
      let pieSeries = chart.series.push(new am4charts.PieSeries());
      pieSeries.dataFields.value = "classScore";
      pieSeries.dataFields.category = "className";

      chart.innerRadius = am4core.percent(55);

      chart.legend = new am4charts.Legend();
      chart.legend.valueLabels.template.text = "{value.percent}%";

      pieSeries.labels.template.disabled = true;
      pieSeries.ticks.template.disabled = true;

      pieSeries.slices.template.tooltipText = "{category}: {value.percent}%";

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

  return (
    <React.Fragment>
      <GlobalStyle />
      <Div className="App">
        <Content style={{ marginRight: "8%" }}>
          <TitleDiv>
            <h1 style={{ marginRight: "25%" }}>Patterns</h1>
            <h1>probability</h1>
          </TitleDiv>
          {data?.map((result, index) => (
            <ResultDiv key={index}>
              <h1 style={{ width: "150px", marginRight: "14%" }}>
                {result["className"]}
              </h1>
              <h1 style={{ width: "155px" }}>
                {(result["classScore"] * 100).toFixed(10)}%
              </h1>
            </ResultDiv>
          ))}
        </Content>
        <Content style={{ width: "40%" }}>
          <Chart />
          <Logos>
            <Logo src={require("./image/knuLogo.jpg")}></Logo>
            <Logo src={require("./image/googleLogo.png")}></Logo>
            <Logo src={require("./image/openmaruLogo.png")}></Logo>
          </Logos>
        </Content>
      </Div>
      ;
    </React.Fragment>
  );
}

export default App;

const ModelResult = [
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
