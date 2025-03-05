import { createSchema } from "graphql-yoga";
import _ from "lodash";

// Import typeDefs and resolvers
import { typeDef as aircrafts, resolvers as aircraftsResolvers } from "./aircrafts.js";
import { typeDef as customers, resolvers as customersResolvers } from "./customers.js";
import { typeDef as delivery, resolvers as deliveryResolvers } from "./deliveries.js";
import { typeDef as orders, resolvers as ordersResolvers } from "./orders.js";
import { typeDef as payments, resolvers as paymentsResolvers } from "./payments.js";
import { typeDef as reviews, resolvers as reviewsResolvers } from "./reviews.js";
import { typeDef as warranties, resolvers as warrantiesResolvers } from "./warranties.js";
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
const typeDefs = [query, , aircrafts, reviews, customers, delivery, orders, payments, warranties, login];
const resolvers = _.merge(
  aircraftsResolvers,
  reviewsResolvers,
  customersResolvers,
  deliveryResolvers,
  ordersResolvers,
  paymentsResolvers,
  warrantiesResolvers,
  saluteResolver,
  loginResolvers
);

export const schema = createSchema({
  typeDefs: typeDefs,
  resolvers: resolvers,
});
