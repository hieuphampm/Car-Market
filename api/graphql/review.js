export const typeDef = `
    type Review {
        id: ID!
        carId: ID!    
        userId: ID!   
        rating: Int!
        comment: String
        createdAt: String!
    }

    input ReviewInput {
        carId: ID!
        userId: ID!
        rating: Int!
        comment: String
    }

    extend type Query {
        reviews: [Review]
        review(id: ID!): Review
    }

    extend type Mutation {
        createReview(input: ReviewInput!): Review
        updateReview(id: ID!, input: ReviewInput!): Review
        deleteReview(id: ID!): Int
    }
`;

export const resolvers = {
    Query: {
        reviews: (parent, args, context) => context.db.reviews.getAll(),
        review: (parent, args, context) => context.db.reviews.findById(args.id),
    },

    Mutation: {
        createReview: (parent, args, context) => context.db.reviews.create(args.input),
        updateReview: (parent, args, context) => context.db.reviews.updateById(args.id, args.input),
        deleteReview: (parent, args, context) => context.db.reviews.deleteById(args.id),
    },
};
