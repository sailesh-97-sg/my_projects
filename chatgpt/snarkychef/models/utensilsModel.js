export const utensils = [
  {
    name: "Bamboo shoots",
    category: "Canned goods",
  },
];

export const uniqueUtensils = Object.values(
  utensils.reduce((acc, curr) => {
    if (!acc[curr.name]) {
      acc[curr.name] = curr;
    }
    return acc;
  }, {})
);
