import {
  StyleSheet,
  Text,
  View,
  ScrollView,
  Pressable,
  FlatList,
} from "react-native";
import React, { useState, useRef } from "react";
import { SearchBar, CheckBox } from "@rneui/base";
import { uniqueIngredients as ingredients } from "../models/ingredientsModel";

const IngredientItem = ({ ingredient, checked, onPress }) => {
  return (
    <View
      style={{ flexDirection: "row", alignItems: "center", marginVertical: 0 }}
    >
      <CheckBox checked={checked} onPress={onPress} />
      <Text style={{ marginLeft: 16, fontFamily: "BonaNovaRegular" }}>
        {ingredient.name}
      </Text>
    </View>
  );
};

const HomeScreen = ({ navigation }) => {
  const [checkedItems, setCheckedItems] = useState({});
  const [searchText, setSearchText] = useState("");
  const flatListRef = useRef(null);
  const [selectedIngredients, setSelectedIngredients] = useState([]);

  const handleSearchFocus = () => {
    if (flatListRef.current) {
      flatListRef.current.scrollToOffset({ offset: 0, animated: true });
    }
  };

  const handleCheck = (index) => {
    setCheckedItems((prevState) => {
      const newCheckedItems = {
        ...prevState,
        [index]: !prevState[index],
      };

      // Filter the checked items from the ingredients array
      const selectedIngredients = ingredients.filter(
        (_, i) => newCheckedItems[i]
      );

      setSelectedIngredients(selectedIngredients);

      // Log the checked items
      console.log("Selected ingredients:", selectedIngredients);

      return newCheckedItems;
    });
  };

  const renderItem = ({ item }) => (
    <IngredientItem
      ingredient={item}
      checked={checkedItems[item.originalIndex] || false}
      onPress={() => handleCheck(item.originalIndex)}
    />
  );
  // Filter the ingredients based on the search text
  const filteredIngredients = ingredients
    .map((ingredient, index) => ({ ...ingredient, originalIndex: index }))
    .filter((ingredient) =>
      ingredient.name.toLowerCase().includes(searchText.toLowerCase())
    )
    .reduce(
      (acc, item) => {
        if (checkedItems[item.originalIndex]) {
          acc.checked.push(item);
        } else {
          acc.unchecked.push(item);
        }
        return acc;
      },
      { checked: [], unchecked: [] }
    );

  const sortedIngredients = [
    ...filteredIngredients.checked,
    ...filteredIngredients.unchecked,
  ];

  return (
    <View
      style={{
        backgroundColor: "white",
        flex: 1,
      }}
    >
      <View>
        <SearchBar
          placeholder="Find ingredient..."
          onChangeText={setSearchText}
          onFocus={handleSearchFocus}
          value={searchText}
          containerStyle={{
            borderRadius: 20,
            backgroundColor: "transparent",
            borderBottomWidth: 0,
            borderTopWidth: 0,
            marginHorizontal: 0,
          }}
          inputContainerStyle={{ borderRadius: 20 }}
          inputStyle={{ fontFamily: "BonaNovaRegular" }}
        />
      </View>
      <View style={{ margin: 20 }}>
        <Text
          style={{ marginLeft: 10, fontFamily: "BonaNovaBold", fontSize: 20 }}
        >
          Select ingredients
        </Text>
        <View
          style={{
            borderColor: "black",
            borderWidth: 0.5,
            borderRadius: 20,
            height: "76%",
            marginTop: 20,
          }}
        >
          <FlatList
            data={sortedIngredients}
            renderItem={renderItem}
            keyExtractor={(_, index) => index.toString()}
            style={{ marginVertical: 5 }}
            ref={flatListRef}
          />
        </View>
      </View>

      <Pressable
        onPress={() => {
          navigation.navigate("Recipe", {
            ingredientsJSON: selectedIngredients,
          });
        }}
        style={{
          alignItems: "center",
          justifyContent: "center",
          width: 80,
          height: 50,
          backgroundColor: "#2196F3",
          borderRadius: 25,
          position: "absolute",
          bottom: 30,
          right: 20,
          zIndex: 100,
        }}
      >
        <Text>Next</Text>
      </Pressable>
    </View>
  );
};

export default HomeScreen;

const styles = StyleSheet.create({});
