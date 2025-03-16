import mongoose from "mongoose";
import { User } from "./user.js";
import { CarSchema } from "./cars.js";
import { FavoriteSchema } from "./favorites.js";
import { OrderSchema } from "./orders.js";
import { ReviewSchema } from "./reviews.js";
import { WarrantySchema } from "./warranties.js";
import { PaymentSchema } from "./payments.js";

export { User };
export const Cars = mongoose.model("cars", CarSchema);
export const Favorites = mongoose.model("favorites", FavoriteSchema);
export const Orders = mongoose.model("orders", OrderSchema);
export const Reviews = mongoose.model("reviews", ReviewSchema);
export const Warranties = mongoose.model("warranties", WarrantySchema);
export const Payments = mongoose.model("payments", PaymentSchema);