import mongoose from "mongoose";
let Schema = mongoose.Schema;
let String = Schema.Types.String;

export const CustomerSchema = new Schema(
  {
    name: String,
    email: String,
    phone: String,
    address: String,
    city: String,
    company_name: String,
    customer_type: String,
  },
  {
    collection: "customers",
  }
);
