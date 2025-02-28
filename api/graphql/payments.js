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