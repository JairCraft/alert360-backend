import { CognitoUserPool } from "amazon-cognito-identity-js";
import dotenv from "dotenv";

dotenv.config();

const poolData = {
  UserPoolId: process.env.COGNITO_USER_POOL_ID, // Reemplaza con tu User Pool ID
  ClientId: process.env.COGNITO_CLIENT_ID, // Reemplaza con tu App Client ID
};

const Pool = new CognitoUserPool(poolData);

export function registerUser(name, email, password, phone) {
  return new Promise((resolve, reject) => {
    const userAttributes = [{ Name: "custom:phone", Value: phone }];
    console.log(email);
    Pool.signUp(email, password, userAttributes, null, (err, data) => {
      if (err) {
        console.error(err);
        reject(err);
      } else {
        console.log(data);
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

export function logoutUser() {
  const user = Pool.getCurrentUser();
  if (user) {
    user.signOut();
  }
}
