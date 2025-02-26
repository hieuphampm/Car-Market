import { createSchema } from "graphql-yoga";

const typeDefs = `
   type Query {
   # ... Ghi chú này sẽ không xuất hiện trong tài liệu mô tả API
      """
      Lời chào cho biết server đang hoạt động
      """
      hello: String

      """
      Chào hỏi một người dùng cụ thể
      """
      salute (
        "Tên của người dùng"
        name: String!
      ): String 
   }
`;

const resolvers = {
  Query: {
    hello: () => "Hello World!",
    salute: (parent, args, context, info) => `Hello ${args.name}`,
  },
};

export const schema = createSchema({
  typeDefs: typeDefs,
  resolvers: resolvers,
});