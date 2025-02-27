import mongoose from "mongoose";
let Schema = mongoose.Schema;
let String = Schema.Types.String;

export const CategorySchema = new Schema(
  {
    name: String,
  },
  {
    collection: "categories",
  }
);