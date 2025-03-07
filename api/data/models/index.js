import mongoose from "mongoose";

import { CarSchema } from "./car.js";
import { FavoriteSchema } from "./favorite.js";
import { OrderSchema } from "./order.js";
import { ReviewSchema } from "./review.js";
import { WarrantySchema } from "./warranty.js";
import { PaymentSchema } from "./payment.js";
import { UserSchema } from "./user.js";


export const User = mongoose.model("user", UserSchema);
export const Car = mongoose.model("car", CarSchema);
export const Favorite = mongoose.model("favorite", FavoriteSchema);
export const Order = mongoose.model("order", OrderSchema);
export const Review = mongoose.model("review", ReviewSchema);
export const Warranty = mongoose.model("warranty", WarrantySchema);
export const Payment = mongoose.model("payment", PaymentSchema);