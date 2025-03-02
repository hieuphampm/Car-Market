import _ from "lodash";

const mockData = {

};

const generateCrudFunctions = (data) => ({
  getAll: () => data,
  findById: (id) => data.find((item) => item.id == id),
  deleteById: (id) => {
    const item = data.find((item) => item.id == id);
    if (item) {
      _.remove(data, (item) => item.id == id);
      return id;
    }
    return null;
  },
  create: (input) => {
    const id = data.length + 1;
    const newItem = { id, ...input };
    data.push(newItem);
    return newItem;
  },
  updateById: (id, input) => {
    const index = data.findIndex((item) => item.id == id);
    if (index >= 0) {
      Object.assign(data[index], input);
      return data[index];
    }
    return null;
  },
});

const db = {
  categories: generateCrudFunctions(mockData.categories),
  aircrafts: generateCrudFunctions(mockData.aircrafts),
  customers: generateCrudFunctions(mockData.customers),
  deliveries: generateCrudFunctions(mockData.deliveries),
  orders: generateCrudFunctions(mockData.orders),
  payments: generateCrudFunctions(mockData.payments),
  reviews: generateCrudFunctions(mockData.reviews),
  warranties: generateCrudFunctions(mockData.warranties),
};

export { db };
