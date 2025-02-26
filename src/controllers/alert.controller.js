import { pool } from "../db.js";
import admin from "firebase-admin";
import { createRequire } from "module";

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

const auxreq = createRequire(import.meta.url);
const serviceAccount = auxreq(
  "../alert-360-35d87-firebase-adminsdk-fbsvc-8fcfe364b0.json"
);
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

export const sendNotifications = async (req, res) => {
  const { user_id, title, body, location } = req.body;

  const { rows } = await pool.query(
    "SELECT DISTINCT ud.device_id FROM emergency_contact ec JOIN user_devices ud ON ec.contact_user_id = ud.user_id WHERE ec.user_id = $1",
    [user_id]
  );

  for (const row of rows) {
    const message = {
      token: row.device_id, // Device FCM token
      notification: {
        title: title,
        body: body,
      },
      //data: { location: location },
    };

    try {
      const response = await admin.messaging().send(message);
      console.log("Successfully sent message:", response);
      res.json({ success: true, response });
    } catch (error) {
      console.error("Error sending message:", error);
      res.status(500).json({ success: false, error });
    }
  }

  /*
  const message = {
    token: token, // Device FCM token
    notification: {
      title: title,
      body: body,
    },
  };

  try {
    const response = await admin.messaging().send(message);
    console.log("Successfully sent message:", response);
    res.json({ success: true, response });
  } catch (error) {
    console.error("Error sending message:", error);
    res.status(500).json({ success: false, error });
  }*/
};
