import mongoose from "mongoose";

import { CategorySchema } from "./category.js";

export const Category = mongoose.model("category", CategorySchema);