import { pool } from "../db.js";

export const getContacts = async (req, res) => {
  const { rows } = await pool.query(
    "SELECT * FROM emergency_contact WHERE user_id = $1",
    [req.params.userId]
  );
  res.json(rows);
};

export const saveContact = async (req, res) => {
  const data = req.body;
  try {
    if (!data.hasOwnProperty("id")) {
      await pool.query(
        "INSERT INTO emergency_contact (user_id, contact_user_id, relation) VALUES ($1, $2, $3)",
        [data.user_id, data.contact_user_id, data.relation]
      );
    } else {
      await pool.query(
        "UPDATE emergency_contact SET contact_user_id=$2, relation = $3, state = $4, response_date = NOW() WHERE id = $1 ",
        [data.id, data.contact_user_id, data.relation, data.state]
      );
    }
  } catch (e) {
    return res.status(400).json({ mesasge: e.message });
  }
  res.sendStatus(201);
};
