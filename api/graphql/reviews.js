export const typeDef = `
    type Review {
        id: ID!
        aircraft_id: String!
        review_date: String!
        rating: Int!
        review: String!
    }

    input ReviewInput {
        aircraft_id: String!
        review_date: String!
        rating: Int!
        review: String!
        }

    extend type Query {
        reviews: [Review]
        review(id: Int!): Review
    }

    extend type Mutation {
        deleteReview(id: Int!): Int
        createReview(input: ReviewInput!): Review
        updateReview(id: Int!, input: ReviewInput!): Review
    }
`;

export const resolvers = {
    Query: {
        reviews: (parent, args, context, info) => {
            return context.db.reviews.getAll();
        },
        review: (parent, args, context, info) => {
            return context.db.reviews.findById(args.id);
        },
    },

    Mutation: {
        deleteReview: (parent, args, context, info) => {
            return context.db.reviews.deleteById(args.id);
        },
        createReview: (parent, args, context, info) => {
            return context.db.reviews.create(args.input);
        },
        updateReview: (parent, args, context, info) => {
            return context.db.reviews.updateById(args.id, args.input);
        },
    },
};