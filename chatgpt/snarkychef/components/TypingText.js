import React, { useState, useEffect } from "react";
import { Text } from "react-native";

const TypingText = ({ text, typingSpeed, style }) => {
  const [displayedText, setDisplayedText] = useState("");

  useEffect(() => {
    let index = 0;
    const interval = setInterval(() => {
      if (index < text.length) {
        setDisplayedText((prevText) => prevText + text[index]);
        index++;
      } else {
        clearInterval(interval);
      }
    }, typingSpeed);

    return () => clearInterval(interval);
  }, [text]);

  return <Text style={style}>{displayedText}</Text>;
};

export default TypingText;
