import mongoose from "mongoose";
let Schema = mongoose.Schema;
let ObjectId = Schema.Types.ObjectId;
let DateType = Schema.Types.Date;
let NumberType = Schema.Types.Number;
let StringType = Schema.Types.String;

export const PaymentSchema = new Schema(
  {
    orderId: { type: ObjectId, required: true, ref: "orders" },
    amount: { type: NumberType, required: true },
    paymentMethod: { type: StringType, required: true },
    paymentDate: { type: DateType, default: Date.now },
    status: { type: StringType, required: true },
  },
  {
    collection: "payments",
  }
);
