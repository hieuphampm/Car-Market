import mongoose from "mongoose";
let Schema = mongoose.Schema;
let ObjectId = Schema.Types.ObjectId;
let DateType = Schema.Types.Date;
let StringType = Schema.Types.String;

export const WarrantySchema = new Schema(
  {
    orderId: { type: ObjectId, required: true, ref: "orders" },
    customerId: { type: ObjectId, required: true, ref: "users" },
    carId: { type: ObjectId, required: true, ref: "cars" },
    startDate: { type: DateType, required: true },
    endDate: { type: DateType, required: true },
    status: { type: StringType, required: true },
    description: { type: StringType },
  },
  {
    collection: "warranties",
  }
);
