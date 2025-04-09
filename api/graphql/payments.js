export const typeDef = `
    type Payment {
        id: ID!
        order_id: Int!
        amount: Float!
        payment_date: String!
        payment_method: String!
        payment_status: String!
    }
    
    input PaymentInput { 
        order_id: Int!
        amount: Float!
        payment_date: String!
        payment_method: String!
        payment_status: String!
    }

    extend type Query {
        payments: [Payment]
        payment(id: Int!): Payment
    }

    extend type Mutation {
        deletePayment(id: Int!): Int
        createPayment(input: PaymentInput!): Payment
        updatePayment(id: Int!, input: PaymentInput!): Payment
    }
`;

export const resolvers = {
    Query: {
        payments: async () => {
            return await Payment.findAll();
        },
        payment: async (parent, args) => {
            return await Payment.findByPk(args.id);
        }
    },
    Mutation: {
        deletePayment: async (parent, args) => {
            return await Payment.destroy({ where: { id: args.id } });
        },
        createPayment: async (parent, args) => {
            return await Payment.create(args.input);
        },
        updatePayment: async (parent, args) => {
            await Payment.update(args.input, { where: { id: args.id } });
            return await Payment.findByPk(args.id);
        }
    }
};