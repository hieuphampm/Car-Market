import bcrypt from "bcryptjs";

export const up = async (db, client) => {
  await db.collection("users").insertMany([
    {
      fullName: "Admin User",
      email: "admin@example.com",
      phone: "123456789",
      address: "Admin Street",
      username: "admin",
      password: bcrypt.hashSync("1234", 10),
    },
    {
      fullName: "Hieu Manager",
      email: "hieu@example.com",
      phone: "987654321",
      address: "Hieu Street",
      username: "manager",
      password: bcrypt.hashSync("1234", 10),
    },
    {
      fullName: "Bao Manager",
      email: "bao@example.com",
      phone: "1122334455",
      address: "Bao Street",
      username: "manager",
      password: bcrypt.hashSync("1234", 10),
    },
    {
      fullName: "Demo Customer",
      email: "customer@example.com",
      phone: "555666777",
      address: "Demo Street",
      username: "customer",
      password: bcrypt.hashSync("1234", 10),
    },
    {
      fullName: "Demo Seller",
      email: "seller@example.com",
      phone: "888999000",
      address: "Demo1 Street",
      username: "seller",
      password: bcrypt.hashSync("1234", 10),
    },
  ]);
};

export const down = (db, client) => {};
