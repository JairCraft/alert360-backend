import { pool } from "../db.js";

export const getAlerts = async (req, res) => {
  const { rows } = await pool.query("SELECT * FROM alerts WHERE user_id = $1", [
    req.params.userId,
  ]);
  res.json(rows);
};

export const saveAlert = async (req, res) => {
  const data = req.body;
  try {
    const result = await pool.query(
      "INSERT INTO alerts (user_id, description) VALUES ($1, $2) RETURNING id",
      [data.user_id, data.description]
    );
    await pool.query(
      "INSERT INTO locations (alert_id, latitude, longitude) VALUES ($1, $2, $3)",
      [result.rows[0].id, data.latitude, data.longitude]
    );
  } catch (e) {
    return res.status(400).json({ mesasge: e.message });
  }
  res.sendStatus(201);
};
