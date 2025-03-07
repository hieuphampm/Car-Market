import { Car, Favorite, Order, Review, Warranty, Payment, User } from "./models/index.js";

const generateMongoRepo = (Model) => ({
  getAll: async () => {
    return await Model.find();
  },
  findById: async (id) => {
    return await Model.findById(id);
  },
  create: async (input) => {
    return await Model.create(input);
  },
  updateById: async (id, input) => {
    return await Model.findByIdAndUpdate(id, input, { new: true });
  },
  deleteById: async (id) => {
    const deleted = await Model.findByIdAndDelete(id);
    return deleted ? id : null;
  },
});

const db = {
  car: generateMongoRepo(Car),
  favorite: generateMongoRepo(Favorite),
  order: generateMongoRepo(Order),
  payment: generateMongoRepo(Payment),
  review: generateMongoRepo(Review),
  warranty: generateMongoRepo(Warranty),
  users: {
    findOne: async (username) => {
      return await User.findOne({ username }).lean();
    },
  },
};

export { db };
