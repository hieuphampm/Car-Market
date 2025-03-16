export const typeDef = `
    type Car {
        id: ID!
        sellerId: ID! 
        brand: String!
        model: String!
        year: Int!
        mileage: Int!
        price: Float!
        transmission: String!
        fuelType: String!
        engine: String!
        condition: String!
        description: String
        mainImage: String 
        status: String!
        createdAt: String!
    }

    input CarInput {
        sellerId: ID!  
        brand: String!
        model: String!
        year: Int!
        mileage: Int!
        price: Float!
        transmission: String!
        fuelType: String!
        engine: String!
        condition: String!
        description: String
        mainImage: String  # Thêm mainImage vào input CarInput
        status: String!
    }

    extend type Query {
        cars: [Car]
        car(id: ID!): Car
    }

    extend type Mutation {
        createCar(input: CarInput!): Car
        updateCar(id: ID!, input: CarInput!): Car
        deleteCar(id: ID!): Int
    }
`;

export const resolvers = {
    Query: {
        cars: (parent, args, context) => context.db.cars.getAll(),
        car: (parent, args, context) => context.db.cars.findById(args.id),
    },

    Mutation: {
        createCar: (parent, args, context) => context.db.cars.create(args.input),
        updateCar: (parent, args, context) => context.db.cars.updateById(args.id, args.input),
        deleteCar: (parent, args, context) => context.db.cars.deleteById(args.id),
    },
};
