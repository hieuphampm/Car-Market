import mongoose from "mongoose";
let Schema = mongoose.Schema;
let String = Schema.Types.String;
let Int = Schema.Types.Number;
let Float = Schema.Types.Number;

export const AircraftSchema = new Schema(
  {
    name: String,
    manufacturer_id: Int,
    model: String,
    year: Int,
    price: Float,
    type: String,
    fuel_capacity: Int,
    max_speed: Int,
    range: Int,
    capacity: Int,
    weight: Int,
    image: String,
    description: String
  },
  { timestamps: true }
);

export const Aircraft = mongoose.model("Aircraft", AircraftSchema);
