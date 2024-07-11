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
      { name: 'Drink two litres of water every day', category: 'Health' },
      { name: 'Eat my five a day', category: 'Nutrition' },
      { name: 'Meditate for twenty minutes', category: 'Mindfulness' },
      { name: 'Go for a walk', category: 'Outdoor' },
      { name: 'Quit smoking', category: 'Quit a bad habit' }
    ]

    # Create habits for each user
    User.all.each do |user|
      habits.each do |habit_attrs|
        habit = Habit.create!(
          habit_attrs.merge(
            priority: rand(1..3),
            start_date: 1.week.ago.to_date,  # Start date one week ago
            end_date: 1.week.from_now.to_date,  # End date one week from now
            frequency: 'daily',
            status: 'active',
            user_id: user.id
          )
        )

      habit.occurrences.each do |occurrence|
        next if occurrence.date > Date.today

        if occurrence.date == Date.today
          occurrence.update(completion_status: 'pending')
        elsif occurrence.date < Date.today
          status = ['completed', 'pending'].sample
          occurrence.update(completion_status: status)
        end
      end

      total_occurrences = habit.occurrences.where('date <= ?', Date.today).count
      completed_occurrences = habit.occurrences.where('date <= ? AND completion_status = ?', Date.today, 'completed').count
      missed_occurrences = habit.occurrences.where('date <= ? AND completion_status = ?', Date.today, 'pending').count

      habit.habit_static.update(
        total_occurrences: total_occurrences,
        completed_occurrences: completed_occurrences,
        missed_occurrences: missed_occurrences
      )
      end
    end
  end

  puts 'Seeding completed!'
end
