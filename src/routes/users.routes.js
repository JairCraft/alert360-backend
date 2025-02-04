import { Router } from "express";
import { pool } from "../db.js";

const router = Router();

router.get("/users", async (req, res) => {
  const { rows } = await pool.query("SELECT * FROM users");
  res.json(rows);
});

router.get("/users/:userId", async (req, res) => {
  const { userId } = req.params;
  const { rows } = await pool.query("SELECT * FROM users WHERE id = $1", [
    userId,
  ]);
  if (rows.length === 0)
    return res.status(404).json({ message: "User not found" });

  res.json(rows[0]);
});

router.post("/users", async (req, res) => {
  const data = req.body;
  try {
    await pool.query(
      "INSERT INTO users (name, email,phone, password) VALUES ($1, $2, $3, $4)",
      [data.name, data.email, data.phone, data.password]
    );
  } catch (e) {
    return res.status(400).json({ message: e.detail });
  }
  res.sendStatus(201);
});

router.put("/users", (req, res) => {
  res.send("main users");
});

export default router;
