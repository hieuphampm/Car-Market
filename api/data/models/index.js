import mongoose from "mongoose";

import { AircraftSchema } from "./aircraft.js";
import { CustomerSchema } from "./customer.js";
import { DeliverySchema } from "./delivery.js";
import { OrderSchema } from "./order.js";
import { PaymentSchema } from "./payment.js";
import { ReviewSchema } from "./review.js";
import { WarrantySchema } from "./warranty.js";
import { UserSchema } from "./user.js";

export const Aircraft = mongoose.model("Aircraft", AircraftSchema);
export const Customer = mongoose.model("Customer", CustomerSchema);
export const Delivery = mongoose.model("Delivery", DeliverySchema);
export const Order = mongoose.model("Order", OrderSchema);
export const Payment = mongoose.model("Payment", PaymentSchema);
export const Review = mongoose.model("Review", ReviewSchema);
export const Warranty = mongoose.model("Warranty", WarrantySchema);
export const User = mongoose.model("user", UserSchema);