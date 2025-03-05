import mongoose from "mongoose";
let Schema = mongoose.Schema;
let String = Schema.Types.String;
let Int = Schema.Types.Number;

export const ReviewSchema = new Schema(
  {
    aircraft_id: String,
    review_date: String,
    rating: Int,
    review: String,
  },
  {
    collection: "reviews",
  }
);
