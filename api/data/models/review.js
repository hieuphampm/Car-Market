import mongoose from "mongoose";
let Schema = mongoose.Schema;
let ObjectId = Schema.Types.ObjectId;
let DateType = Schema.Types.Date;
let NumberType = Schema.Types.Number;
let StringType = Schema.Types.String;

export const ReviewSchema = new Schema(
  {
    carId: { type: ObjectId, required: true, ref: "cars" },
    userId: { type: ObjectId, required: true, ref: "users" },
    rating: { type: NumberType, required: true, min: 1, max: 5 },
    comment: { type: StringType },
    createdAt: { type: DateType, default: Date.now },
  },
  {
    collection: "reviews",
  }
);
