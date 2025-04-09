import mongoose from "mongoose";
let Schema = mongoose.Schema;
let String = Schema.Types.String;

export const UserSchema = new Schema(
  {
    fullName: String,
    email: String,
    phone: String,
    address: String,
    userType: String, // e.g., "buyer" or "seller"
    createdAt: { type: Date, default: Date.now },
  },
  {
    collection: "users",
  }
);
