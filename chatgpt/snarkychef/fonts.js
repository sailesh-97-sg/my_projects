import { useFonts } from "expo-font";

const useLoadFonts = () => {
  const [fontsLoaded] = useFonts({
    CourgetteRegular: require("./assets/fonts/Courgette-Regular.ttf"),
    BonaNovaRegular: require("./assets/fonts/BonaNova-Regular.ttf"),
    BonaNovaItalic: require("./assets/fonts/BonaNova-Italic.ttf"),
    BonaNovaBold: require("./assets/fonts/BonaNova-Bold.ttf"),
  });

  return fontsLoaded;
};

export default useLoadFonts;
