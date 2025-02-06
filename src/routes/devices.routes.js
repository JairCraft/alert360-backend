import { Router } from "express";
import { getDevices, saveDevice } from "../controllers/devices.controller.js";

const router = Router();

router.get("/devices/:userId", getDevices);

router.post("/devices", saveDevice);

router.delete("/devices/:deviceId");

export default router;
