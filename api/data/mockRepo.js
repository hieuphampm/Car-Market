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
      deleteById: (id) => {
        const item = mockData.categories.find((item) => item.id == id);
        if (item) {
          _.remove(mockData.categories, (item) => item.id == id);
          return id;
        }
        return null;
      },
      create: (input) => {
        const id = mockData.categories.length + 1;
        const item = {
          id: id,
          name: input.name,
        };
        mockData.categories.push(item);
        return item;
      },
      updateById: (id, input) => {
        const index = mockData.categories.findIndex((item) => item.id == id);
        if (index >= 0) {
          Object.keys(input).map((key) => {
            const value = input[key];
            mockData.categories[index][key] = value;
          });
          return mockData.categories[index];
        }
        return null;
      },
    },
  };
  
  export { db };
  