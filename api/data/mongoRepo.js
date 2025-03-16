import { Cars, Favorites, Orders, Reviews, Warranties, Payments, User } from "./models/index.js";

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
  cars: generateMongoRepo(Cars),
  favorite: generateMongoRepo(Favorites),
  order: generateMongoRepo(Orders),
  payment: generateMongoRepo(Payments),
  review: generateMongoRepo(Reviews),
  warranty: generateMongoRepo(Warranties),
  users: {
    findOne: async (username) => {
      return await User.findOne({ username }).lean();
    },
  },
};

export { db };
