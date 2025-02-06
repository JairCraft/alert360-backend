import pg from "pg";
import { DB_CONFIG } from "./config.js";

export const pool = new pg.Pool(DB_CONFIG);
