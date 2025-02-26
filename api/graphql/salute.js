export const typeDef = `
  extend type Query {
    salute (
        name: String
    ): String 
  }
`;

export const resolvers = {
  Query: {
    salute: (parent, args, context, info) => {
      return `Hello ${args.name} ${context.secret}`;
    },
  },
};