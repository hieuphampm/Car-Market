import bcrypt from "bcrypt";

export const up = async (db, client) => {
  await db.collection("users").insertMany([
    { username: "admin", password: bcrypt.hashSync("1234", 10), role: "admin" },
    { username: "hieu", password: bcrypt.hashSync("1234", 10), role: "manager" },
    { username: "bao", password: bcrypt.hashSync("1234", 10), role: "manager" },
    {
      username: "demo",
      password: bcrypt.hashSync("1234", 10),
      role: "customer",
    },
    { username: "demo1", password: bcrypt.hashSync("1234", 10), role: "customer" },
  ]);
};

export const down = (db, client) => {};
