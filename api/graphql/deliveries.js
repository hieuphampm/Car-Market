export const typeDef = `
    type Delivery {
        id: ID!
        order_id: String!
        delivery_date: String!
        status: String!
    }

    input DeliveryInput {
        order_id: String!
        delivery_date: String!
        status: String!
        }

    extend type Query {
        deliveries: [Delivery]
        delivery(id: Int!): Delivery
    }

    extend type Mutation {
        deleteDelivery(id: Int!): Int
        createDelivery(input: DeliveryInput!): Delivery
        updateDelivery(id: Int!, input: DeliveryInput!): Delivery
    } 
`;

export const resolvers = {
    Query: {
        deliveries: (parent, args, context, info) => {
            return context.db.deliveries.getAll();
        },
        delivery: (parent, args, context, info) => {
            return context.db.deliveries.findById(args.id);
        },
    },

    Mutation: {
        deleteDelivery: (parent, args, context, info) => {
            return context.db.deliveries.deleteById(args.id);
        },
        createDelivery: (parent, args, context, info) => {
            return context.db.deliveries.create(args.input);
        },
        updateDelivery: (parent, args, context, info) => {
            return context.db.deliveries.updateById(args.id, args.input);
        },
    },
};