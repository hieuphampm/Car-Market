import { Aircraft, Customer, Delivery, Order, Payment, Review, Warranty, User } from "./models/index.js";

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
  aircrafts: generateMongoRepo(Aircraft),
  customers: generateMongoRepo(Customer),
  deliveries: generateMongoRepo(Delivery),
  orders: generateMongoRepo(Order),
  payments: generateMongoRepo(Payment),
  reviews: generateMongoRepo(Review),
  warranties: generateMongoRepo(Warranty),
  users: {
    findOne: async (username) => {
      return await User.findOne({ username }).lean();
    },
  },
};

export { db };
