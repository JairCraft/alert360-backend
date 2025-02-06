import { Router } from "express";
import { getAlerts, saveAlert } from "../controllers/alert.controller.js";

const router = Router();

router.get("/alerts/:userId", getAlerts);

router.post("/alerts", saveAlert);

export default router;
