import { StyleSheet, Text, View, ActivityIndicator } from "react-native";
import React, { useEffect, useState } from "react";
import Constants from "expo-constants";
import { getChatCompletion } from "./functions/gpt3.5turbo";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import { createDrawerNavigator } from "@react-navigation/drawer";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { NavigationContainer } from "@react-navigation/native";
import HomeScreen from "./screens/HomeScreen";
import useLoadFonts from "./fonts";
import RecipeGenerationScreen from "./screens/RecipeGenerationScreen";
import SavedRecipesScreen from "./screens/SavedRecipesScreen";

const Stack = createNativeStackNavigator();
const Drawer = createDrawerNavigator();
const Tab = createBottomTabNavigator();

const StackNav = () => {
  return (
    <Stack.Navigator>
      <Stack.Screen
        name="Home"
        component={HomeScreen}
        options={{ headerShown: false }}
      />
      <Stack.Screen
        name="Recipe"
        component={RecipeGenerationScreen}
        options={{ headerShown: false }}
      />
    </Stack.Navigator>
  );
};

export default function App() {
  const [davinciResponse, setDavinciResponse] = useState("");
  const [isLoading, setIsLoading] = useState(true);
  const [gpt35response, setGpt35Response] = useState("");

  // Uncomment the below code to make use of text-davici-003 to generate responses.

  // useEffect(() => {
  //   setIsLoading(true);
  //   questionResponse("Please give me a random Indian recipe.", setDavinciResponse)
  //     .then(() => setIsLoading(false))
  //     .catch((error) =>
  //       console.error("Error fetching question response: ", error)
  //     );
  // }, []);

  // Uncomment the below code to make use of gpt3.5 turbo to generate responses. Do note that gpt3.5 turbo is as good, but at just 10% of the price of text-davinci-003 so it makes more sense to use this.

  // useEffect(() => {
  //   getChatCompletion(
  //     "I have onions, tomatoes, olive oil, garlic and paprika. Give me a recipe I can cook with these ingredients.",
  //     setGpt35Response
  //   );
  // }, []);

  const fontsLoaded = useLoadFonts();

  if (!fontsLoaded) {
    return null;
  } else
    return (
      <NavigationContainer>
        <Drawer.Navigator
          screenOptions={{
            headerStyle: { backgroundColor: "black" },
            headerTitle: () => (
              <View
                style={{
                  flexDirection: "row",
                  marginHorizontal: 4,
                  alignItems: "center",
                }}
              >
                {/* insert an image here of the logo */}
                <Text
                  style={{
                    color: "white",
                    fontSize: 20,
                    fontFamily: "CourgetteRegular",
                  }}
                >
                  Snarkychef
                </Text>
              </View>
            ),
          }}
        >
          <Drawer.Screen
            name="Select Ingredients"
            component={StackNav}
            options={{}}
          />
          <Drawer.Screen name="Saved Recipes" component={SavedRecipesScreen} />
        </Drawer.Navigator>
      </NavigationContainer>
    );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "center",
  },
});
