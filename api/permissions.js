import { GraphQLError } from "graphql";

const hasGoodSecret = async (next, parent, args, ctx, info) => {
  const secret = ctx.secret;
  const good = secret.length >= 8;

  if (!good) {
    throw new GraphQLError(`Not a good secret!`);
  }

  return next();
};

export const permissions = {
  Query: {
    salute: hasGoodSecret,
  },
};