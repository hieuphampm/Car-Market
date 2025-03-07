export const typeDef = `
    type Order {
        id: ID!
        buyerId: ID!   
        car: Car!
        orderDate: String!
        totalAmount: Float!
        status: String!
    }

    input OrderInput {
        buyerId: ID!
        carId: ID!
        totalAmount: Float!
        status: String!
    }

    extend type Query {
        orders: [Order]
        order(id: ID!): Order
    }

    extend type Mutation {
        createOrder(input: OrderInput!): Order
        updateOrder(id: ID!, input: OrderInput!): Order
        deleteOrder(id: ID!): Int
    }
`;

export const resolvers = {
    Query: {
        orders: (parent, args, context) => context.db.orders.getAll(),
        order: (parent, args, context) => context.db.orders.findById(args.id),
    },

    Mutation: {
        createOrder: (parent, args, context) => context.db.orders.create(args.input),
        updateOrder: (parent, args, context) => context.db.orders.updateById(args.id, args.input),
        deleteOrder: (parent, args, context) => context.db.orders.deleteById(args.id),
    },
};
