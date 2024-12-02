# Créer un utilisateur
user = User.first || User.create!(name: "Default User", email: "default@example.com")

# Créer des publications associées à cet utilisateur
Post.create([
  { title: 'Première publication', description: 'Voici ma première photo', image: 'https://via.placeholder.com/150', likes: 10, user: user },
  { title: 'Deuxième publication', description: 'Une autre belle photo', image: 'https://via.placeholder.com/150', likes: 20, user: user }
])
