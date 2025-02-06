import { pool } from "../db.js";

export const getDevices = async (req, res) => {
  const { rows } = await pool.query(
    "SELECT * FROM user_devices WHERE user_id = $1",
    [req.params.userId]
  );
  res.json(rows);
};

export const saveDevice = async (req, res) => {
  const data = req.body;
  try {
    const result = await pool.query(
      "INSERT INTO user_devices (user_id, endpoint_arn, device_id, platform) VALUES ($1, $2, $3, $4)",
      [data.user_id, data.endpoint_arn, data.device_id, data.platform]
    );
  } catch (e) {
    return res.status(400).json({ mesasge: e.message });
  }
  res.sendStatus(201);
};

export const deleteDevice = async (req, res) => {
  const data = req.body;
  try {
    await pool.query("DELETE FROM user_devices WHERE id = $1", [
      req.params.deviceId,
    ]);
  } catch (e) {
    return res.status(400).json({ mesasge: e.message });
  }
  res.sendStatus(201);
};
