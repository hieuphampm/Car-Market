export const typeDef = `
    type Aircraft {
        id: ID!
        name: String! 
        manufacturer_id: Int!
        model: String!
        year: Int!
        price: Float!
        type: String!
        fuel_capacity: Int!
        max_speed: Int!
        range: Int!
        capacity: Int!
        weight: Int!
        image: String!
    } 

    input AircraftInput {
        name: String!
        manufacturer_id: Int!
        model: String!
        year: Int!
        price: Float!
        type: String!
        fuel_capacity: Int!
        max_speed: Int!
        range: Int!
        capacity: Int!
        weight: Int!
        image: String!
    }

    extend type Query {
        aircrafts: [Aircraft]
        aircraft(id: Int!): Aircraft
    }

    extend type Mutation {
      deleteAircraft(id: Int!): Int
      createAircraft(input: AircraftInput!): Aircraft
      updateAircraft(id: Int!, input: AircraftInput!): Aircraft
    }
`;

export const resolvers = { 
    Query: {
        aircrafts: (parent, args, context, info) => {
        return context.db.aircrafts.getAll();
        },
        aircraft: (parent, args, context, info) => {
        return context.db.aircrafts.findById(args.id);
        },
    },
    
    Mutation: { 
        deleteAircraft: (parent, args, context, info) => {
        return context.db.aircrafts.deleteById(args.id);
        },
        createAircraft: (parent, args, context, info) => {
        return context.db.aircrafts.create(args.input);
        },
        updateAircraft: (parent, args, context, info) => {
        return context.db.aircrafts.updateById(args.id, args.input);
        },
    },
};