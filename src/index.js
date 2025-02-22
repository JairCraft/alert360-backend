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
import admin from "firebase-admin";
import { createRequire } from "module";
dotenv.config();

const app = express();

app.use(morgan("dev"));
app.use(express.json());
const auxreq = createRequire(import.meta.url);
const serviceAccount = auxreq(
  "./alert-360-35d87-firebase-adminsdk-fbsvc-c114606168.json"
);
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

app.use(cors());
app.use(authRoutes);
app.post("/send-notification", async (req, res) => {
  const { token, title, body } = req.body;

  const message = {
    token: token, // Device FCM token
    notification: {
      title: title,
      body: body,
    },
    data: {
      customData: "Some extra data",
    },
  };

  try {
    const response = await admin.messaging().send(message);
    console.log("Successfully sent message:", response);
    res.json({ success: true, response });
  } catch (error) {
    console.error("Error sending message:", error);
    res.status(500).json({ success: false, error });
  }
});

app.use(verifyToken);
app.use(deviceRoutes);
app.use(alertRoutes);
app.use(contactRoutes);
app.use(userRoutes);

app.get("/", (req, res) => {
  res.send("Y si lo tiene prendalo, el radio");
});

app.listen(PORT, () => {
  console.log("Server is running on http://localhost:" + PORT);
});
