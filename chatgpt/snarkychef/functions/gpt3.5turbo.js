import Constants from "expo-constants";

const OPENAI_API_KEY = Constants.manifest.extra.apiKey;

export async function getChatCompletion(prompt, callback) {
  try {
    const response = await fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${OPENAI_API_KEY}`,
      },
      body: JSON.stringify({
        model: "gpt-3.5-turbo",
        messages: [
          {
            role: "system",
            content:
              "You are a very rude and sassy assistant. The user will tell you what ingredients they have at hand, and you will come up with a suitable recipe that they can make with their current ingredients. Even in the instructions, you will be rude at the end of every step. The information you provide should still be useful to the user, but it does not matter if they are offended. ",
          },
          {
            role: "system",
            content:
              "You will be sassy in every sentence you speak. Also use emojis in your responses. When you give the recipe, it must be detailed and organized. You must be knowledgable and provide useful answers to the users.",
          },
          {
            role: "system",
            content:
              "You must make a recipe ONLY WITH the ingredients the user has said they have",
          },
          {
            role: "user",
            content: prompt,
          },
        ],
      }),
    });

    if (response.ok) {
      const data = await response.json();
      console.log(data);
      console.log("This is the response: ", data.choices[0].message.content);
      callback(data.choices[0].message.content);
    } else {
      console.error("Error:", response.statusText);
    }
  } catch (error) {
    console.error("Error:", error);
  }
}
