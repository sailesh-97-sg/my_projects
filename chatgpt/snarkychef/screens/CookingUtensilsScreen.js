import {
  StyleSheet,
  Text,
  View,
  Pressable,
  FlatList,
  Dimensions,
} from "react-native";
import React, { useState, useRef } from "react";
import { SearchBar, CheckBox } from "@rneui/base";
import { uniqueUtensils as utensils } from "../models/utensilsModel";
import { useRoute } from "@react-navigation/native";
import { Icon } from "@rneui/base";

const { width, height } = Dimensions.get("window");

const UtensilItem = ({ utensil, checked, onPress }) => {
  return (
    <View
      style={{ flexDirection: "row", alignItems: "center", marginVertical: 0 }}
    >
      <CheckBox checked={checked} onPress={onPress} />
      <Text style={{ marginLeft: 16, fontFamily: "BonaNovaRegular" }}>
        {utensil.name}
      </Text>
    </View>
  );
};

const CookingUtensilsScreen = ({ navigation }) => {
  const route = useRoute();
  const ingredientsJSON = route.params.ingredientsJSON;

  const [checkedItems, setCheckedItems] = useState({});
  const [searchText, setSearchText] = useState("");
  const flatListRef = useRef(null);
  const [selectedUtensils, setSelectedUtensils] = useState([]);

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

      // Filter the checked items from the utensils array
      const selectedUtensils = utensils.filter((_, i) => newCheckedItems[i]);

      setSelectedUtensils(selectedUtensils);

      // Log the checked items
      console.log("Selected utensils:", selectedUtensils);

      return newCheckedItems;
    });
  };

  const renderItem = ({ item }) => (
    <UtensilItem
      utensil={item}
      checked={checkedItems[item.originalIndex] || false}
      onPress={() => handleCheck(item.originalIndex)}
    />
  );
  // Filter the utensils based on the search text
  const filteredUtensils = utensils
    .map((utensil, index) => ({ ...utensil, originalIndex: index }))
    .filter((utensil) =>
      utensil.name.toLowerCase().includes(searchText.toLowerCase())
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

  const sortedUtensils = [
    ...filteredUtensils.checked,
    ...filteredUtensils.unchecked,
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
          placeholder="Find cookware..."
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
        <View style={{ flexDirection: "row", justifyContent: "space-between" }}>
          <Text
            style={{ marginLeft: 10, fontFamily: "BonaNovaBold", fontSize: 20 }}
          >
            Select utensils (optional)
          </Text>
          <Pressable
            onPress={() => {
              setCheckedItems({});
              handleSearchFocus();
            }}
          >
            <Icon name={"refresh"} iconStyle={"evilicons"} />
          </Pressable>
        </View>
        <View
          style={{
            borderColor: "black",
            borderWidth: 0.5,
            borderRadius: 20,
            height: "76%",
            marginTop: 20,
            position: "relative",
          }}
        >
          <FlatList
            data={sortedUtensils}
            renderItem={renderItem}
            keyExtractor={(_, index) => index.toString()}
            style={{ marginVertical: 5 }}
            ref={flatListRef}
          />
          <Pressable
            onPress={handleSearchFocus}
            style={{
              position: "absolute",
              right: 20,
              bottom: 20,
              borderWidth: 0.6,
              borderColor: "black",
              backgroundColor: "lightblue",
              borderRadius: 20,
              paddingHorizontal: 20,
              paddingVertical: 10,
              elevation: 2,
            }}
          >
            <Text>Go Up</Text>
          </Pressable>
        </View>
      </View>
      <Pressable
        onPress={() => {
          navigation.navigate("Home");
        }}
        style={{
          alignItems: "center",
          justifyContent: "center",
          width: 90,
          height: 50,
          backgroundColor: "lightgreen",
          borderWidth: 0.6,
          borderColor: "black",
          borderRadius: 25,
          position: "absolute",
          bottom: 30,
          left: 20,
        }}
      >
        <Text>Back</Text>
      </Pressable>

      <Pressable
        onPress={() => {
          navigation.navigate("Recipe", {
            utensilsJSON: selectedUtensils,
            ingredientsJSON: ingredientsJSON,
          });
        }}
        style={{
          alignItems: "center",
          justifyContent: "center",
          width: 90,
          height: 50,
          backgroundColor: "#2196F3",
          borderWidth: 0.6,
          borderColor: "black",
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

export default CookingUtensilsScreen;

const styles = StyleSheet.create({});
