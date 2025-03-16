import mongoose from "mongoose";

let Schema = mongoose.Schema;
let String = Schema.Types.String;
let Number = Schema.Types.Number;
let ObjectId = Schema.Types.ObjectId;
let DateType = Schema.Types.Date;

export const CarSchema = new Schema(
  {
    sellerId: { type: ObjectId, ref: "users", required: true },  
    brand: { type: String, required: true },
    model: { type: String, required: true },
    year: { type: Number, required: true },
    mileage: { type: Number, required: true, min: 0 },
    price: { type: Number, required: true, min: 0 },
    transmission: { type: String, required: true },
    fuelType: { type: String, required: true },
    engine: { type: String, required: true },
    condition: { type: String, required: true },
    description: { type: String },
    mainImage: { type: String, required: false },  
    status: { type: String, enum: ["available", "sold", "reserved"], default: "available" }, 
    createdAt: { type: DateType, default: Date.now },
  },
  {
    collection: "cars",
    timestamps: true,  
  }
);
