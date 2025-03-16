import mongoose from "mongoose";

let Schema = mongoose.Schema;
let ObjectId = Schema.Types.ObjectId;
let DateType = Schema.Types.Date;

export const FavoriteSchema = new Schema(
  {
    userId: { type: ObjectId, ref: "users", required: true },
    carId: { type: ObjectId, ref: "cars", required: true },
    createdAt: { type: DateType, default: Date.now },
  },
  {
    collection: "favorites",
  }
);
