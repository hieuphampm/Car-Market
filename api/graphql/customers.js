export const typeDef = `
    type Customer {
        id: ID!
        name: String! 
        email: String!
        phone: String!
        address: String!
        city: String!
        company_name: String!
        customer_type: String!
    } 
    
    input CustomerInput {
        name: String!
        email: String!
        phone: String!
        address: String!
        city: String!
        company_name: String!
        customer_type: String!
    }

    extend type Query {
        customers: [Customer]
        customer(id: Int!): Customer
    }

    extend type Mutation {
      deleteCustomer(id: Int!): Int
      createCustomer(input: CustomerInput!): Customer
      updateCustomer(id: Int!, input: CustomerInput!): Customer
    }
`;

export const resolvers = {
    Query: {
        customers: (parent, args, context, info) => {
        return context.db.customers.getAll();
        },
        customer: (parent, args, context, info) => {
        return context.db.customers.findById(args.id);
        },
    },
    
    Mutation: { 
        deleteCustomer: (parent, args, context, info) => {
        return context.db.customers.deleteById(args.id);
        },
        createCustomer: (parent, args, context, info) => {
        return context.db.customers.create(args.input);
        },
        updateCustomer: (parent, args, context, info) => {
        return context.db.customers.updateById(args.id, args.input);
        },
    },
};