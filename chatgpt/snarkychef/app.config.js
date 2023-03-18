import "dotenv/config";

export default {
  // Your existing configuration, if any
  android: {
    package: "com.example.myapp", // Add your unique package name here
  },
  extra: {
    apiKey: process.env.OPENAI_API_KEY,
    eas: {
      projectId: "bba339f0-cb13-41cf-a252-f56c83baba4b",
    },
  },
};
