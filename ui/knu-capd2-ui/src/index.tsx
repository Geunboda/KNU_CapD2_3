import { StrictMode } from "react";
import ReactDom, { createRoot } from "react-dom/client";
import App from "./App";

// ReactDOM.render(
//   <React.StrictMode>
//     <App />
//   </React.StrictMode>,
//   document.getElementById("root")
// );
const rootElement = document.getElementById("root");
const root = ReactDom.createRoot(rootElement as HTMLElement);

root.render(
  <StrictMode>
    <App />
  </StrictMode>
);
