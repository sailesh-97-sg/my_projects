import Constants from "expo-constants";

const OPENAI_API_KEY = Constants.manifest.extra.apiKey;

export async function questionResponse(prompt, callback) {
  try {
    const response = await fetch(`https://api.openai.com/v1/completions`, {
      body: JSON.stringify({
        model: "text-davinci-003",
        prompt: prompt,
        temperature: 1,
        max_tokens: 4000,
      }),
      method: "POST",
      headers: {
        "content-type": "application/json",
        Authorization: `Bearer ${OPENAI_API_KEY}`,
      },
    });

    if (response.ok) {
      const json = await response.json();
      const responseText = json.choices[0].text;
      callback(responseText);
    } else {
      throw new Error("Network response was not ok");
    }
  } catch (error) {
    console.log(error);
    throw error;
  }
}
