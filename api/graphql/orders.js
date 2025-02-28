export const typeDef = `
    type Order {
        id: ID!
        custommer_id: Int!
        aircraft_id: Int!
        order_date: String!
        order_status: String!
    } 

    input OrderInput {
      custommer_id: Int!
      aircraft_id: Int!
      order_date: String!
      order_status: String!
    }

    extend type Query {
        orders: [Order]
        order(id: Int!): Order
    }

    extend type Mutation {
      deleteOrder(id: Int!): Int
      createOrder(input: OrderInput!): Order
      updateOrder(id: Int!, input: OrderInput!): Order
    }
`;

export const resolvers = {
    Query: {
        orders: (parent, args, context, info) => {
        return context.db.orders.getAll();
        },
        order: (parent, args, context, info) => {
        return context.db.orders.findById(args.id);
        },
    },
    
    Mutation: { 
        deleteOrder: (parent, args, context, info) => {
        return context.db.orders.deleteById(args.id);
        },
        createOrder: (parent, args, context, info) => {
        return context.db.orders.create(args.input);
        },
        updateOrder: (parent, args, context, info) => {
        return context.db.orders.updateById(args.id, args.input);
        },
    },  
};