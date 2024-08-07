require "open-uri"

def get_start_date(habit, index)
  if [5,6].include?(index)
    Date.new(2024, 6, 1)
  elsif index == 7
    Date.new(2024, 6, 10)
  elsif index == 8
    Date.new(2024, 6, 13)
  else
    1.week.ago.to_date
  end
end

def get_description(index)
    if index == 8
      "1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29"
    elsif index == 5
      "5 kilometers in under 30 minutes requires maintaining a pace of around 6 minutes per kilometer, combining speed and endurance effectively."
    else
      ''
    end
end

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
    { email: "markcarson121@gmail.com", first_name: 'Mark', last_name: 'Carson' } ,
    { email: "jessica@mail.com", first_name: 'Jessica', last_name: 'Carvalho' }
  ]
  attachments = [
    { io: URI.open('https://avatars.githubusercontent.com/u/13469222?v=4'), filename: '13469222.JPG', content_type: 'image/jpg' },
    { io: URI.open('https://avatars.githubusercontent.com/u/86117226?v=4'), filename: '86117226.JPG', content_type: 'image/jpg' },
    { io: URI.open('https://avatars.githubusercontent.com/u/105825256?v=4'), filename: '105825256.JPG', content_type: 'image/jpg' },
    { io: URI.open('https://avatars.githubusercontent.com/u/154748078?v=4'), filename: '154748078.JPG', content_type: 'image/jpg' },
    { io: URI.open('https://avatars.githubusercontent.com/u/74406984?v=4'), filename: '74406984.png', content_type: 'image/png' },
    { io: URI.open('https://avatars.githubusercontent.com/u/68972820?v=4'), filename: '68972820.JPG', content_type: 'image/jpg' }
  ]

  users.each_with_index do |user_attrs, index|
    user = User.create!(user_attrs.merge(
      password: 'password',
      password_confirmation: 'password'
    ))
    user.photo.attach(attachments[index])
    user.save!
  end

  puts 'Creating habits...'

  # Define the 5 habits
  habits = [
    { name: 'Drink two litres of water every day', category: 'Health' },
    { name: 'Eat my five a day', category: 'Nutrition' },
    { name: 'Meditate for twenty minutes', category: 'Mindfulness' },
    { name: 'Go for a walk', category: 'Outdoor' },
    { name: 'Quit smoking', category: 'Quit a bad habit' },
    { name: '5 km run under 30 minutes', category: 'Sports' },
    { name: 'Make the bed first thing in the morning', category: 'Home' },
    { name: 'Reading a chapter', category: 'Learning' },
    { name: 'Incremental Push Ups', category: 'Sports' }
  ]

  # Create habits for each user
  User.all.each do |user|
    habits.each_with_index do |habit_attrs, index|
      next if user.first_name != 'Thuthikaran' && [5,6,7,8].include?(index)

      habit = Habit.create!(
        habit_attrs.merge(
          priority: rand(1..3),
          start_date: get_start_date(habit, index),  # Start date one week ago
          end_date: index == 9 ? Date.new(2024, 7, 13) : 1.week.from_now.to_date, # End date one week from now
          frequency: index == 5 ? "weekly" : "daily",
          days_of_week: index == 5 ?  ["Monday", "Wednesday", "Saturday"] : %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday],
          status: 'active',
          user_id: user.id,
          description: get_description(index)
        )
      )




    habit.occurrences.each do |occurrence|
      next if occurrence.date > Date.today

      if occurrence.date == Date.today
        occurrence.update(completion_status: 'pending')
      elsif occurrence.date < Date.today
        if [6,8].include?(index)
          status = 'completed'
        else
          status = ['completed', 'pending'].sample
        end
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
