import express from "express";
import { PORT } from "./config.js";
import userRoutes from "./routes/users.routes.js";

const app = express();

app.use(userRoutes);

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.listen(PORT, () => {
  console.log("Server is running on http://localhost:" + PORT);
});
