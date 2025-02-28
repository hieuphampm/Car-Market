import { createSchema } from "graphql-yoga";
import _ from "lodash";

import {typeDef as aircrafts, resolvers as aircraftsResolvers,} from "./aircrafts.js";
import {typeDef as categories, resolvers as categoriesResolvers,} from "./categories.js";
import { typeDef as customers, resolvers as customersResolvers } from "./customers.js";
import { typeDef as delivery, resolvers as deliveryResolvers } from "./deliveries.js";
import { typeDef as orders, resolvers as ordersResolvers } from "./orders.js";
import { typeDef as payments, resolvers as paymentsResolvers } from "./payments.js";
import {typeDef as reviews, resolvers as reviewsResolvers,} from "./reviews.js";
import { typeDef as warranties, resolvers as warrantiesResolvers } from "./warranties.js";

const query = `
  type Query {
    _empty: String
  }

  type Mutation {
    _emptyAction: String
  }
`;
const typeDefs = [query, categories, aircrafts, reviews, customers, delivery, orders, payments, warranties];
const resolvers = _.merge(categoriesResolvers, aircraftsResolvers, reviewsResolvers, customersResolvers, deliveryResolvers, ordersResolvers, paymentsResolvers, warrantiesResolvers);

export const schema = createSchema({
  typeDefs: typeDefs,
  resolvers: resolvers,
});