import express from "express";
import { PORT } from "./config.js";
import userRoutes from "./routes/users.routes.js";
import authRoutes from "./routes/auth.routes.js";
import contactRoutes from "./routes/contacts.routes.js";
import alertRoutes from "./routes/alerts.routes.js";
import deviceRoutes from "./routes/devices.routes.js";
import { verifyToken } from "./middleware/authMiddleware.js";
import morgan from "morgan";
import dotenv from "dotenv";
import cors from "cors";

dotenv.config();

const app = express();

app.use(morgan("dev"));
app.use(express.json());

app.use(cors());

app.get("/", (req, res) => {
  res.send("Y si lo tiene prendalo, el radio");
});

app.use(authRoutes);
app.use(verifyToken);
app.use(deviceRoutes);
app.use(alertRoutes);
app.use(contactRoutes);
app.use(userRoutes);

app.listen(PORT, () => {
  console.log("Server is running on http://localhost:" + PORT);
});
