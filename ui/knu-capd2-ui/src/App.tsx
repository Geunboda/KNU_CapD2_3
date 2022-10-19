import React from "react";
import { Routes, Route } from "react-router-dom";
import "./App.css";
import { GlobalStyle } from "./globalstyle";
import Result from "./pages/Result";
import RequestAPI from "./pages/RequestAPI";

function App() {
  return (
    <React.Fragment>
      <GlobalStyle />
      <Routes>
        <Route path="/" element={<RequestAPI />}></Route>
        <Route path="/result" element={<Result />} />
      </Routes>
    </React.Fragment>
  );
}

export default App;
