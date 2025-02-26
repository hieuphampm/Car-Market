import { createServer } from "node:http";
import { createYoga } from "graphql-yoga";
import { schema } from "./graphql/schema.js";
import { useGraphQLMiddleware } from "@envelop/graphql-middleware";
import { permissions } from "./permissions.js";

const mockData = {
  categories: [
    { id: 1, name: "Asus" },
    { id: 2, name: "Dell" },
    { id: 3, name: "HP" },
    { id: 4, name: "MSI" },
  ],
};

const mockDb = {
  categories: {
    getAll: () => mockData.categories,
    findById: (id) => mockData.categories.find((item) => item.id == id),
  },
};

const yoga = createYoga({
  schema,
  graphqlEndpoint: "/",
  plugins: [useGraphQLMiddleware([permissions])],
  context: async ({ request }) => {
    return {
      db: mockDb,
      secret: request.headers.get("secret") ?? "",
    };
  },
});
const server = createServer(yoga);

const PORT = 4000;
server.listen(PORT, () => {
  console.info(`Server is running on http://localhost:${PORT}`);
});