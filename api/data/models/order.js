import mongoose from "mongoose";
let Schema = mongoose.Schema;
let ObjectId = Schema.Types.ObjectId;
let DateType = Schema.Types.Date;
let NumberType = Schema.Types.Number;
let StringType = Schema.Types.String;

export const OrderSchema = new Schema(
  {
    buyerId: { type: ObjectId, required: true },
    carId: { type: ObjectId, required: true, ref: "cars" },
    orderDate: { type: DateType, default: Date.now },
    totalAmount: { type: NumberType, required: true },
    status: { type: StringType, required: true },
  },
  {
    collection: "orders",
  }
);
