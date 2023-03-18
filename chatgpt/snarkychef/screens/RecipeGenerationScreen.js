import {
  StyleSheet,
  Text,
  View,
  Pressable,
  ScrollView,
  Dimensions,
} from "react-native";
import React, { useState, useEffect } from "react";
import { useRoute } from "@react-navigation/native";
import { Icon } from "@rneui/base";
import { getChatCompletion } from "../functions/gpt3.5turbo";
import TypingText from "../components/TypingText";

const { width, height } = Dimensions.get("window");

const RecipeGenerationScreen = ({ navigation }) => {
  const route = useRoute();
  const ingredientsJSON = route.params.ingredientsJSON;
  const [availableIngredients, setAvailableIngredients] = useState("");
  const [gpt35response, setGpt35Response] = useState("");
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    setIsLoading(true);
    console.log(
      "\n\nThese are the selected ingredients: \n\n",
      ingredientsJSON
    );

    const availableIngredients = ingredientsJSON
      .map((ingredient) => ingredient.name)
      .join(", ");
    setAvailableIngredients(availableIngredients);
    console.log(
      "\n\nThese are the available ingredients at hand: \n\n",
      availableIngredients
    );

    getChatCompletion(
      `I have ${availableIngredients}. Give me a recipe I can cook with these ingredients.`,
      setGpt35Response
    )
      .then(() => {
        setIsLoading(false);
      })
      .catch((error) =>
        console.error("Error fetching question response: ", error)
      );
  }, [ingredientsJSON]);

  //   useEffect(() => {
  //     getChatCompletion(
  //       "I have onions, tomatoes, olive oil, garlic and paprika. Give me a recipe I can cook with these ingredients.",
  //       setGpt35Response
  //     );
  //   }, []);

  return (
    <ScrollView>
      <Pressable
        onPress={() => {
          navigation.navigate("Home");
        }}
        style={{
          borderRadius: 20,
          borderWidth: 0.6,
          borderColor: "black",
          paddingHorizontal: 10,
          paddingVertical: 10,
          width: "50%",
          marginHorizontal: 0,
          margin: 20,
          flexDirection: "row",
          alignItems: "center",
          justifyContent: "center",
          backgroundColor: "snow",
          transform: [{ scale: 0.8 }],
        }}
      >
        <Icon name="chevron-left" iconStyle={"evilicon"} />
        <Text
          style={{
            textAlign: "center",
            fontFamily: "BonaNovaRegular",
            fontSize: 15,
          }}
        >
          Missed out an ingredient?
        </Text>
      </Pressable>
      <View style={{ padding: 10 }}>
        <Text style={{ fontFamily: "BonaNovaItalic", textAlign: "center" }}>
          Do note that if it is impossible to make a dish with just the
          ingredients you have provided, the recipe will include the minimum
          additional ingredients required to make a dish.
        </Text>
      </View>

      <View
        style={{
          margin: 10,
          borderWidth: 0.8,
          borderRadius: 20,
          height: height / 2.5,
          overflow: "hidden",
        }}
      >
        <ScrollView
          style={{ padding: 10, height: "100%", position: "relative" }}
          showsVerticalScrollIndicator={false}
        >
          {isLoading ? (
            <Text
              style={{
                margin: 5,
                marginBottom: 0,
                fontFamily: "BonaNovaBold",
              }}
            >
              Your recipe is being generated...
            </Text>
          ) : (
            <TypingText
              text={gpt35response}
              // text={"test"}
              typingSpeed={10} // Adjust this value to change typing speed
              style={{
                margin: 5,
                marginBottom: 50,
                fontFamily: "BonaNovaRegular",
              }}
            />
          )}
        </ScrollView>
      </View>
      <View
        style={{ width: "90%", justifyContent: "center", alignSelf: "center" }}
      >
        <View
          style={{
            margin: 20,
            flexDirection: "row",
            justifyContent: "space-between",
            alignItems: "center",
          }}
        >
          <Pressable
            style={{
              borderWidth: 0.8,
              borderColor: "black",
              borderRadius: 20,
              paddingHorizontal: 30,
              paddingVertical: 15,
              backgroundColor: "#cfcfcf",
            }}
          >
            <Text style={{ fontFamily: "BonaNovaRegular" }}>Save Recipe</Text>
          </Pressable>
          <Pressable
            style={{
              borderWidth: 0.8,
              borderColor: "black",
              borderRadius: 20,
              paddingHorizontal: 30,
              paddingVertical: 15,
              backgroundColor: "#c4dfff",
            }}
          >
            <Text style={{ fontFamily: "BonaNovaRegular" }}>Start Over</Text>
          </Pressable>
        </View>
      </View>
    </ScrollView>
  );
};

export default RecipeGenerationScreen;

const styles = StyleSheet.create({});
