import ReactDom, { createRoot } from "react-dom/client";
import App from "./App";

const rootElement = document.getElementById("root");
const root = ReactDom.createRoot(rootElement as HTMLElement);

root.render(<App />);
