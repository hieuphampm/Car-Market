const mockData = {
    categories: [
      { id: 1, name: "Asus" },
      { id: 2, name: "Dell" },
      { id: 3, name: "HP" },
      { id: 4, name: "MSI" },
    ],
  };
  
  const db = {
    categories: {
      getAll: () => mockData.categories,
      findById: (id) => mockData.categories.find((item) => item.id == id),
    },
  };
  
  export { db };
  