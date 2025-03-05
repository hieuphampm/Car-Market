import dotenv from "dotenv";
dotenv.config();

const config = {
  mongodb: {
    url: process.env.DATABASE_URL,
  },

  migrationsDir: "migrations",
  changelogCollectionName: "changelog",
  lockCollectionName: "changelog_lock",
  lockTtl: 0,
  migrationFileExtension: ".js",
  useFileHash: false,
  moduleSystem: "commonjs",
};

export default config;