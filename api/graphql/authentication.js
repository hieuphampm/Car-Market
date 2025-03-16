import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import { User } from "../data/models/user.js"; 

export const typeDef = `
    type LoginResult {
        jwt: String!
    }

    type LoginResponse {
        success: Boolean!
        message: String!
        data: LoginResult
    }

    input LoginInput {
      username: String!
      password: String!
    }

    extend type Mutation {
        login(input: LoginInput): LoginResponse
    }
`;

export const resolvers = {
  Mutation: {
    login: async (_, { input }) => {
      const { username, password } = input;
      if (!username || !password) {
        return {
          success: false,
          message: "Username or password cannot be empty",
        };
      }

      // Tìm người dùng trong database bằng Mongoose
      const user = await User.findOne({ username });

      if (!user) {
        return {
          success: false,
          message: "Invalid username or password",
        };
      }

      // Kiểm tra mật khẩu
      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) {
        return {
          success: false,
          message: "Invalid username or password",
        };
      }

      if (!process.env.JWT_SECRET) {
        throw new Error("JWT_SECRET is not defined in environment variables");
      }

      // Tạo token JWT
      const token = jwt.sign(
        {
          id: user._id,
          username: user.username,
          role: user.role || "user",
        },
        process.env.JWT_SECRET,
        { expiresIn: "24h" }
      );

      return {
        success: true,
        message: "Login successful",
        data: {
          jwt: token,
        },
      };
    },
  },
};
