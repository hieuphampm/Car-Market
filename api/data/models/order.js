import mongoose from "mongoose";
let Schema = mongoose.Schema;
let String = Schema.Types.String;
let Int = Schema.Types.Number;

export const OrderSchema = new Schema(
  {
    customer_id: Int,
    aircraft_id: Int,
    order_date: String,
    order_status: String,
  },
  {
    collection: "orders",
  }
);

