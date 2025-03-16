export const typeDef = `
    type Payment {
        id: ID!
        orderId: ID!   # Thay thế Order! bằng ID!
        amount: Float!
        paymentMethod: String!
        paymentDate: String!
        status: String!
    }

    input PaymentInput {
        orderId: ID!
        amount: Float!
        paymentMethod: String!
        status: String!
    }

    extend type Query {
        payments: [Payment]
        payment(id: ID!): Payment
    }

    extend type Mutation {
        createPayment(input: PaymentInput!): Payment
        updatePayment(id: ID!, input: PaymentInput!): Payment
        deletePayment(id: ID!): Int
    }
`;

export const resolvers = {
    Query: {
        payments: (parent, args, context) => context.db.payment.getAll(),
        payment: (parent, args, context) => context.db.payment.findById(args.id),
    },

    Mutation: {
        createPayment: (parent, args, context) => context.db.payment.create(args.input),
        updatePayment: (parent, args, context) => context.db.payment.updateById(args.id, args.input),
        deletePayment: (parent, args, context) => context.db.payment.deleteById(args.id),
    },
};
