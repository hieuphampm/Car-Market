import mongoose from "mongoose";
let Schema = mongoose.Schema;
let String = Schema.Types.String;

export const DeliverySchema = new Schema(
  {
    order_id: String,
    delivery_date: String,
    status: String,
  },
  {
    collection: "deliveries",
  }
);
