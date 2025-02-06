import { Router } from "express";
import {
  getContacts,
  saveContact,
} from "../controllers/contacts.controller.js";

const router = Router();

router.get("/contacts/:userId", getContacts);

router.post("/contacts", saveContact);

export default router;
