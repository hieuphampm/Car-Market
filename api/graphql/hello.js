import { GraphQLError } from "graphql";
import _ from "lodash";

export const typeDef = `
  extend type Query {
    hello: String
  }
`;

export const resolvers = {
  Query: {
    hello: (parent, args, context, info) => {
      if (!_.has(context, "secret")) {
        return new GraphQLError("A secret is required.");
      }

      return `Hello World! ${context.secret}`;
    },
  },
};