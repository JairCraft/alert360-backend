import { pool } from "../db.js";

export const getUsers = async (req, res) => {
  const { rows } = await pool.query("SELECT * FROM users");
  res.json(rows);
};

export const getUser = async (req, res) => {
  const { userId } = req.params;
  const { rows } = await pool.query("SELECT * FROM users WHERE id = $1", [
    userId,
  ]);
  if (rows.length === 0)
    return res.status(404).json({ message: "User not found" });

  res.json(rows[0]);
};

export const saveUser = async (req, res) => {
  const data = req.body;
  try {
    if (!data.hasOwnProperty("id")) {
      await pool.query(
        "INSERT INTO users (name, email,phone, password) VALUES ($1, $2, $3, $4)",
        [data.name, data.email, data.phone, data.password]
      );
    } else {
      await pool.query(
        "UPDATE users SET name = $2, email = $3, phone = $4, password = $5 WHERE id = $1 ",
        [data.id, data.name, data.email, data.phone, data.password]
      );
    }
  } catch (e) {
    return res.status(400).json({ mesasge: e.message });
  }
  res.sendStatus(201);
};
