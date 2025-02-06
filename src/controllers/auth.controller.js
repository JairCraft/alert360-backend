import {
  CognitoUserPool,
  CognitoUser,
  AuthenticationDetails,
} from "amazon-cognito-identity-js";
import dotenv from "dotenv";
import { pool } from "../db.js";

dotenv.config();

const poolData = {
  UserPoolId: process.env.COGNITO_USER_POOL_ID, // Reemplaza con tu User Pool ID
  ClientId: process.env.COGNITO_CLIENT_ID, // Reemplaza con tu App Client ID
};

const Pool = new CognitoUserPool(poolData);

export function registerUser(name, email, password, phone) {
  return new Promise((resolve, reject) => {
    const userAttributes = [{ Name: "custom:phone", Value: phone }];
    Pool.signUp(email, password, userAttributes, null, async (err, data) => {
      if (err) {
        console.error(err);
        reject(err);
      } else {
        console.log(data);
        await pool.query(
          "INSERT INTO users (name, email,phone, password) VALUES ($1, $2, $3, $4)",
          [name, email, phone, password]
        );
        resolve(data);
      }
    });
  });
}

export function loginUser(email, password) {
  return new Promise((resolve, reject) => {
    const user = new CognitoUser({ Username: email, Pool });
    const authDetails = new AuthenticationDetails({
      Username: email,
      Password: password,
    });

    user.authenticateUser(authDetails, {
      onSuccess: (data) => {
        console.log("onSuccess:", data);
        resolve(data);
      },
      onFailure: (err) => {
        console.error("onFailure:", err);
        reject(err);
      },
    });
  });
}

export function logoutUser(res) {
  const user = Pool.getCurrentUser();
  if (user) {
    user.signOut();
    return res.status(200).send({ message: "User signed out successfully" });
  }
  return res.status(201).send({ message: "No user to sign out" });
}

export function confirmUserEmail(email, verificationCode) {
  return new Promise((resolve, reject) => {
    const user = new CognitoUser({ Username: email, Pool });

    user.confirmRegistration(verificationCode, true, (err, data) => {
      if (err) {
        console.error("Error confirming email:", err);
        reject(err);
      } else {
        console.log("Email confirmed:", data);
        resolve(data);
      }
    });
  });
}
