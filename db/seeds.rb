# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create([
              { email: 'user1@example.com', password: '123456' },
              { email: 'user2@example.com', password: '123456' }
            ])

Board.create([
               { title: 'Board1', description: 'Simple board1 by user1', author_id: 1,
                 img_url: 'https://images.unsplash.com/photo-1506991458536-26f8f5885c4a'
               },
               { title: 'Board2', description: 'Simple board2 by user1', author_id: 1 },
               { title: 'Board3', description: 'Simple board3 by user2', author_id: 2 }
             ])
