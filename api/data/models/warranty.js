import mongoose from "mongoose";
let Schema = mongoose.Schema;
let String = Schema.Types.String;

export const WarrantySchema = new Schema(
  {
    aircraft_id: String,
    start_date: String,
    end_date: String,
  },
  {
    collection: "warranties",
  }
);
