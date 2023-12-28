namespace :demo do
  desc "TODO"
  task setup: :environment do
    # main test user
    puts "creating users...."
    tester = User.create(email: 'tester@test.com', password: 'password')

    10.times do
      User.create(email: Faker::Internet.email, password: 'password')
    end
    puts "finished creating users."

    puts "creating conversations...."
    users = User.all_except(tester)
    users.take(3).each do |user|
      conversation = Conversation.create(
        participant1_id: tester.id,
        participant2_id: user.id,
      )
      conversation.messages.create(user_id: tester.id, content: Faker::Books::Dune.saying)
      conversation.messages.create(user_id: user.id, content: Faker::Movies::PrincessBride.quote)
      conversation.messages.create(user_id: tester.id, content: Faker::Movies::Ghostbusters.quote)
    end

    puts "finished creating conversations."
    puts "finished setup script."
  end
end
