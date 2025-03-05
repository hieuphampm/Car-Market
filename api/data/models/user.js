import mongoose from "mongoose";
let Schema = mongoose.Schema;
let String = Schema.Types.String;

export const UserSchema = new Schema(
  {
    username: String,
  },
  {
    collection: "users",
  }
);