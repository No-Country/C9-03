# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Category.create!([{name: "Helados"}, {name: "Hamburgueserías"}, {name: "Café"}, {name: "Pizzerías"}, {name: "Vegetariano"}])
Store.create!([{name: "Freddo", category_id: 1, url: 'locales/freddo.jpg', ratings:[1,1,1]}, {name: "McDonalds", category_id: 1, url: 'locales/mc.png', ratings:[3,3,3,3]}, {name: "Starbucks", category_id: 3, url: 'locales/starbucks.png', ratings:[5,4,5,4]}, {name: "Kentucky", category_id: 4, url: 'locales/kentucky.jpg', ratings:[3,3,5,3,2,4]}, {name: "Veggie Life", category_id: 5, url: 'locales/veggielife.png', ratings:[5,5,5,5,1]}])
Address.create!([{street: "Av. Cabildo 2569, CABA", store_id: 1}, {street: "Av. del Libertador 7112, CABA", store_id: 2}, {street: "Av. Melián 4602, CABA", store_id: 3}, {street: " Av. Corrientes 1502, CABA", store_id: 4}, {street: " Av. Monroe 3548, CABA", store_id: 5}])
Food.create!([{name: "Cucurucho", price: 550, store_id: 1}, {name: "Kg de Helado", price: 3500, store_id: 1}, {name: "Big Mac", price: 1500, store_id: 2}, {name: "Cajita feliz", price: 2600, store_id: 2}, {name: "Napolitana", price: 2000, store_id: 4}, {name: "Empanada", price: 550, store_id: 4}, {name: "Latte", price: 750, store_id: 3}, {name: "Capuchino", price: 800, store_id: 3}, {name: "Wrap", price: 500, store_id: 5}, {name: "Ensalada", price: 700, store_id: 5}])

