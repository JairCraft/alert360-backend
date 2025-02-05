import { Router } from "express";
import {
  getUser,
  getUsers,
  saveUser,
} from "../controllers/users.controller.js";

const router = Router();

router.get("/users", getUsers);

router.get("/users/:userId", getUser);

router.post("/users", saveUser);

router.put("/users", saveUser);

export default router;
