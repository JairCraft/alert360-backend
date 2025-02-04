import pg from "pg";
import { DB_CONFIG } from "./config";

export const pool = new pg.Pool(DB_CONFIG);
