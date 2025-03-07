export const typeDef = `
    type Warranty {
        id: ID!
        orderId: ID!
        customerId: ID!
        carId: ID!
        startDate: String!
        endDate: String!
        status: String!
        description: String
    } 

    input WarrantyInput {
        orderId: ID!
        customerId: ID!
        carId: ID!
        startDate: String!
        endDate: String!
        status: String
        description: String
    }

    extend type Query {
        warranties: [Warranty]
        warranty(id: ID!): Warranty
    }

    extend type Mutation {
      deleteWarranty(id: ID!): ID
      createWarranty(input: WarrantyInput!): Warranty
      updateWarranty(id: ID!, input: WarrantyInput!): Warranty
    }
`;

export const resolvers = {
    Query: {
        warranties: (parent, args, context) => context.db.warranties.getAll(),
        warranty: (parent, args, context) => context.db.warranties.findById(args.id),
    },

    Mutation: {
        createWarranty: (parent, args, context) => context.db.warranties.create(args.input),
        updateWarranty: (parent, args, context) => context.db.warranties.updateById(args.id, args.input),
        deleteWarranty: (parent, args, context) => context.db.warranties.deleteById(args.id),
    },
};
