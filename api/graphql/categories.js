export const typeDef = `
    type Category {
        id: ID!
        name: String! 
    } 

    input CategoryInput {
      name: String!
    }

    extend type Query {
        categories: [Category]
        category(id: Int!): Category
    }

    extend type Mutation {
      deleteCategory(id: Int!): Int
      createCategory(input: CategoryInput!): Category
      updateCategory(id: Int!, input: CategoryInput!): Category
    }
`;

export const resolvers = {
  Query: {
    categories: (parent, args, context, info) => {
      return context.db.categories.getAll();
    },
    category: (parent, args, context, info) => {
      return context.db.categories.findById(args.id);
    },
  },

  Mutation: { 
    deleteCategory: (parent, args, context, info) => {
      return context.db.categories.deleteById(args.id);
    },
    createCategory: (parent, args, context, info) => {
      return context.db.categories.create(args.input);
    },
    updateCategory: (parent, args, context, info) => {
      return context.db.categories.updateById(args.id, args.input);
    },
  },
};
