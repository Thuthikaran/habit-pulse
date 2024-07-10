if Rails.env.development?
  Habit.transaction do
    puts 'Destroying all existing habits, occurrences, and users...'

    # Destroy all existing habits, occurrences, and users
    Habit.destroy_all
    Occurrence.destroy_all
    User.destroy_all

    puts 'Creating users...'

    # Create 5 users
    users = [
      { email: "pedro@mail.com", first_name: 'Pedro', last_name: 'Leal' },
      { email: "thuthi@mail.com", first_name: 'Thuthikaran', last_name: 'Easvaran' },
      { email: "sahba@mail.com", first_name: 'Sahba', last_name: 'Azhari' },
      { email: "jeannine@mail.com", first_name: 'Jeannine', last_name: 'Vernon' },
      { email: "markcarson121@gmail.com", first_name: 'Mark', last_name: 'Carson' }
    ]

    users.each do |user_attrs|
      User.create!(user_attrs.merge(
        password: 'password',
        password_confirmation: 'password'
      ))
    end

    puts 'Creating habits...'

    # Define the 5 habits
    habits = [
      { name: 'Meditate', category: 'Mindfulness' },
      { name: 'Exercise', category: 'Health' },
      { name: 'Learn', category: 'Learning' },
      { name: 'Write', category: 'Creativity' },
      { name: 'Cook', category: 'Health' }
    ]

    # Create habits for each user
    User.all.each do |user|
      habits.each do |habit_attrs|
        habit = Habit.create!(
          habit_attrs.merge(
            priority: rand(1..3),
            start_date: 1.week.ago.to_date,  # Start date one week ago
            frequency: 'daily',
            status: 'active',
            user_id: user.id
          )
        )
        # create_occurrences(habit)
      end
    end
  end

  puts 'Seeding completed!'
end


# def create_occurrences(habit)
#   # Calculate start date one week ago
#   start_date = 1.week.ago.to_date

#   rand(1..5).times do
#     occurrence_date = Faker::Date.between(from: start_date, to: Date.today)
#     occurrence = Occurrence.new(date: occurrence_date, habit: habit)
#     occurrence.completion_status = Occurrence::COMPLETION_STATUSES.sample
#     occurrence.save!
#   end
# end
