import { createSchema } from "graphql-yoga";
import _ from "lodash";

// Import typeDefs and resolvers
import { typeDef as car, resolvers as carResolvers } from "./car.js";
import { typeDef as review, resolvers as reviewResolvers } from "./review.js";
import { typeDef as favorite, resolvers as favoriteResolvers } from "./favorite.js";
import { typeDef as order, resolvers as orderResolvers } from "./order.js";
import { typeDef as warranty, resolvers as warrantyResolvers } from "./warranty.js";
import { typeDef as payment, resolvers as paymentResolvers } from "./payment.js";

import {typeDef as login, resolvers as loginResolvers} from "./authentication.js";

// Define the base query and mutation
const query = `
  type Query {
    _empty: String
    salute: String  # Ensure salute exists in the schema
  }

  type Mutation {
    _emptyAction: String
  }
`;

// Resolver for salute
const saluteResolver = {
  Query: {
    salute: () => "Hello from GraphQL!",
  },
};

// Merge typeDefs and resolvers
const typeDefs = [query, car, review, favorite, order, warranty, payment, login];
const resolvers = _.merge(
  carResolvers,
  reviewResolvers,
  favoriteResolvers,
  orderResolvers,
  warrantyResolvers,
  paymentResolvers,
  saluteResolver,
  loginResolvers
);

export const schema = createSchema({
  typeDefs: typeDefs,
  resolvers: resolvers,
});
