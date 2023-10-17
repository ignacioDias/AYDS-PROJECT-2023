# Level.destroy_all
# Category.destroy_all
# #Para no tener errores por el Foreign Key
# RecordLevel.destroy_all

Category.create(name: "Artes", description: "Cultura y Arte Argentino")

Level.create(name: "Level1", numLevel: 1, category_id: 1)
Level.create(name: "Level2", numLevel: 2, category_id: 1)
Level.create(name: "Level3", numLevel: 3, category_id: 1)

Category.create(name: "Comida", description: "Las mejores comidas Argentinas")

Level.create(name: "Level1", numLevel: 1, category_id: 2)
Level.create(name: "Level2", numLevel: 2, category_id: 2)
Level.create(name: "Level3", numLevel: 3, category_id: 2)

Category.create(name: "Geografia", description: "Regiones y el Mapa Argentino")

Level.create(name: "Level1", numLevel: 1, category_id: 3)
Level.create(name: "Level2", numLevel: 2, category_id: 3)
Level.create(name: "Level3", numLevel: 3, category_id: 3)

Category.create(name: "Historia", description: "La Historia Argentina")

Level.create(name: "Level1", numLevel: 1, category_id: 4)
Level.create(name: "Level2", numLevel: 2, category_id: 4)
Level.create(name: "Level3", numLevel: 3, category_id: 4)

Category.create(name: "Deporte", description: "Todo del Deporte Argentino")


Level.create(name: "Level1", numLevel: 1, category_id: 5)
Level.create(name: "Level2", numLevel: 2, category_id: 5)
Level.create(name: "Level3", numLevel: 3, category_id: 5)
