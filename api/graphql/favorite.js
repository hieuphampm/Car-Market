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
        favorites: async (parent, args, { db }) => {
            return await db.favorite.getAll();
        },
        
        favorite: async (parent, { id }, { db }) => {
            return await db.favorite.findById(id);
        }        
    },

    Mutation: {
        createFavorite: async (parent, { input }, { db }) => {
            return await db.favorite.create({
                userId: input.userId,
                carId: input.carId,
                createdAt: new Date(),
            });
        },
        
        deleteFavorite: async (parent, { id }, { db }) => {
            return await db.favorite.deleteById(id);
        }
        
    }
};
