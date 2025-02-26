import { createServer } from "node:http";
import { createYoga } from "graphql-yoga";
import { schema } from "./schema.js";

const yoga = createYoga({ 
    schema,
    graphqlEndpoint: "/",
 });
const server = createServer(yoga);

const PORT = 4000; // process.env.PORT
server.listen(PORT, () => {
  console.info(`Server is running on http://localhost:${PORT}`);
});