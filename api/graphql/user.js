export const typeDef = `
    type User {
        id: ID!
        fullName: String!
        email: String!
        phone: String!
        address: String!
        userType: String!
        createdAt: String!
    } 

    input UserInput {
        fullName: String!
        email: String!
        phone: String!
        address: String!
        userType: String!
    }

    extend type Query {
        users: [User]
        user(id: ID!): User
    }

    extend type Mutation {
        createUser(input: UserInput!): User
        updateUser(id: ID!, input: UserInput!): User
        deleteUser(id: ID!): Int
    }
`;

export const resolvers = {
    Query: {
        users: (parent, args, context) => context.db.users.getAll(),
        user: (parent, args, context) => context.db.users.findById(args.id),
    },

    Mutation: {
        createUser: (parent, args, context) => context.db.users.create(args.input),
        updateUser: (parent, args, context) => context.db.users.updateById(args.id, args.input),
        deleteUser: (parent, args, context) => context.db.users.deleteById(args.id),
    },
};
