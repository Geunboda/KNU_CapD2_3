import React from "react";
import styled from "styled-components";
import "./App.css";
import { GlobalStyle } from "./globalstyle";
import Chart from "./components/Chart";

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
  font-size: 1.5rem;
  font-weight: bold;
  display: flex;
  width: 100%;
  height: 15%;
  align-items: center;
  justify-content: center;
`;

const ResultDiv = styled.div`
  font-size: 1.3rem;
  display: flex;
  width: 100%;
  height: 8%;
  align-items: center;
  justify-content: space-around;
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
  return (
    <React.Fragment>
      <GlobalStyle />
      <Div className="App">
        <Content style={{ marginRight: "8%" }}>
          <TitleDiv>
            <h1 style={{ marginRight: "30%" }}>Patterns</h1>
            <h1>probability</h1>
          </TitleDiv>
          {ModelResult.map((result, index) => (
            <ResultDiv>
              <h1>{result.label}</h1>
              <h1>{result.prob}%</h1>
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
