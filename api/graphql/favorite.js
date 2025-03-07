export const typeDef = `
    type Favorite {
        id: ID!
        userId: ID!
        carId: ID!
        createdAt: String!
    }

    input FavoriteInput {
        userId: ID!
        carId: ID!
    }

    extend type Query {
        favorites: [Favorite]
        favorite(id: ID!): Favorite
    }

    extend type Mutation {
        createFavorite(input: FavoriteInput!): Favorite
        deleteFavorite(id: ID!): Int
    }
`;

export const resolvers = {
    Query: {
        favorites: (parent, args, context) => context.db.favorites.getAll(),
        favorite: (parent, args, context) => context.db.favorites.findById(args.id),
    },

    Mutation: {
        createFavorite: (parent, args, context) => context.db.favorites.create(args.input),
        deleteFavorite: (parent, args, context) => context.db.favorites.deleteById(args.id),
    },
};
