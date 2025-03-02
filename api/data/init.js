import mongoose from "mongoose";
import dotenv from "dotenv";
dotenv.config();

export async function initDatabase() {
	const DATABASE_URL = process.env.DATABASE_URL;
	await mongoose.connect(DATABASE_URL );
	console.log(`Database is up and running at: ${DATABASE_URL }`);
}