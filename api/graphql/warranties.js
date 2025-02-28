export const typeDef = `
    type Warranty {
        id: ID!
        aircraft_id: String!
        start_date: String!
        end_date: String!
    }

    input WarrantyInput {
        aircraft_id: String!
        start_date: String!
        end_date: String!
        }

    extend type Query {
        warranties: [Warranty]
        warranty(id: Int!): Warranty
    }

    extend type Mutation {
        deleteWarranty(id: Int!): Int
        createWarranty(input: WarrantyInput!): Warranty
        updateWarranty(id: Int!, input: WarrantyInput!): Warranty
    }
`;

export const resolvers = {
    Query: {
        warranties: (parent, args, context, info) => {
            return context.db.warranties.getAll();
        },
        warranty: (parent, args, context, info) => {
            return context.db.warranties.findById(args.id);
        },
    },

    Mutation: {
        deleteWarranty: (parent, args, context, info) => {
            return context.db.warranties.deleteById(args.id);
        },
        createWarranty: (parent, args, context, info) => {
            return context.db.warranties.create(args.input);
        },
        updateWarranty: (parent, args, context, info) => {
            return context.db.warranties.updateById(args.id, args.input);
        },
    },
};