export const typeDef = `
    type Category {
        id: Int!
        name: String! 
    } 
    extend type Query {
        categories: [Category]
        category(id: Int!): Category
    }
`;

export const resolvers = {
  Query: {
    categories: (parent, args, context, info) => {
      return context.db.categories.getAll();
    },
    category: (parent, args, context, info) => {
        return context.db.categories.findById(args.id);
      }
  },
};