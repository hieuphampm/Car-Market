import mongoose from "mongoose";

export const UserSchema = new mongoose.Schema(
  {
    fullName: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    phone: { type: String },
    address: { type: String },
    username: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    role: { type: String, enum: ["admin", "manager", "customer", "seller"], default: "customer" },
  },
  { collection: "users" }
);

export const User = mongoose.model("User", UserSchema);
