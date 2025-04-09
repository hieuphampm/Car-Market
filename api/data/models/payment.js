import mongoose from "mongoose";
let Schema = mongoose.Schema;
let String = Schema.Types.String;
let Int = Schema.Types.Number;
let Float = Schema.Types.Number;

export const PaymentSchema = new Schema(
  {
    order_id: Int,
    amount: Float,
    payment_date: String,
    payment_method: String,
    payment_status: String,
  },
  {
    collection: "payments",
  }
);
