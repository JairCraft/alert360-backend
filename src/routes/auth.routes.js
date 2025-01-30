import { Router } from "express";
import e from "express";
import {
  registerUser,
  confirmUserEmail,
} from "../controllers/auth.controller.js";

const router = Router();
router.use(e.json());

router.post("/auth/register", (req, res) => {
  try {
    const { name, email, password, phone } = req.body;
    registerUser(name, email, password, phone)
      .then((data) => res.status(201).send(data))
      .catch((err) => res.status(400).send(err));
  } catch (err) {
    res.status(500).send(err);
  }
});

router.post("/auth/confirmEmail", (req, res) => {
  try {
    const { email, verificationCode } = req.body;
    confirmUserEmail(email, verificationCode)
      .then((data) => res.status(200).send(data))
      .catch((err) => res.status(400).send(err));
  } catch (err) {
    console.error(err);
    res.status(500).send(err);
  }
});

export default router;
