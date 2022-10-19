import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import styled from "styled-components";
import "../App.css";

const Div = styled.div`
  width: 100vw;
  height: 100vh;
  background-color: #5b1a2a;
  display: flex;
  padding: 5%;
  padding-top: 2%;
  justify-content: center;
  align-items: center;
  flex-direction: column;
`;

const Intro = styled.h1`
  color: white;
  font-size: 2rem;
  margin-bottom: 20px;
  font-weight: bold;
  letter-spacing: 1px;
`;
const Input = styled.textarea`
  width: 70%;
  height: 80%;
  border-radius: 8px;
  border: none;
  padding: 20px 20px;
  &:focus {
    outline-color: #a36f89;
  }
`;

const Button = styled.button`
  background-color: #a36f89;
  width: 15%;
  height: 10%;
  color: white;
  font-size: 2rem;
  border: none;
  border-radius: 8px;
  box-shadow: 3px 3px 3px #574144;
  letter-spacing: 2px;
  position: absolute;
  bottom: 2%;
  right: 18.5%;
`;
function RequestAPI() {
  const [input, setInput] = useState("");
  let navigate = useNavigate();
  function inputChange(e: any) {
    setInput(e.target.value);
  }

  async function requestButton() {
    await fetch("/api/dump", {
      method: "POST",
      body: JSON.stringify(JSON.parse(input)),
      headers: { "Content-type": "application/json" },
    })
      .then((res) => res.text())
      .then((message) => console.log(message));
    await navigate("/result");
  }

  return (
    <Div>
      <Intro>
        Enter the Java thread dump data and Click the Request button🆘
      </Intro>
      <Input onChange={inputChange}></Input>
      <Button onClick={requestButton}>request!</Button>
    </Div>
  );
}

export default RequestAPI;
