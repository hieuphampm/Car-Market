import mongoose from "mongoose";

export async function initDatabase() {
	const DATABASE_URL = "mongodb://127.0.0.1:27017/shop";
	await mongoose.connect(DATABASE_URL );
	console.log(`Database is up and running at: ${DATABASE_URL }`);
}