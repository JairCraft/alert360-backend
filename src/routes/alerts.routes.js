import { Router } from "express";
import {
  getAlerts,
  saveAlert,
  sendNotifications,
} from "../controllers/alert.controller.js";

const router = Router();

router.get("/alerts/:userId", getAlerts);

router.post("/alerts", saveAlert);

router.post("/send-notification", sendNotifications);

export default router;
