# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
if Rails.env.development?
  Habit.destroy_all
  User.destroy_all
  Occurrence.destroy_all
end
def create_occurrences(habit)
  rand(1..5).times do
    # create or update occurrence by date
    occurrence = habit.occurrences.find_or_initialize_by(date: Faker::Date.between(from: habit.start_date,
                                                                                   to: Date.today))
    occurrence.completion_status = Occurrence::COMPLETION_STATUSES.sample
    occurrence.save!
  end
end



# rubocop:disable Metrics/MethodLength
def insert_habits
  # create 10 habits with occurrences, at lest 4 habits with occurrences
  habit = Habit.create!(name: 'Meditate',
                        priority: rand(1..3),
                        start_date: Faker::Date.between(from: 1.year.ago, to: Date.today), frequency: 'daily',
                        status: 'active',
                        user_id: User.all.sample.id,
                        category: 'Mindfulness')
  create_occurrences(habit)

  habit = Habit.create!(name: 'Read',
    priority: rand(1..3),
    start_date: Faker::Date.between(from: 1.year.ago, to: Date.today), frequency: 'daily',
    status: 'active',
    user_id: User.all.sample.id,
    category: 'Learning')

  habit = Habit.create!(name: 'Exercise',
    priority: rand(1..3),
    start_date: Faker::Date.between(from: 1.year.ago, to: Date.today), frequency: 'daily',
    status: 'active',
    user_id: User.all.sample.id,
    category: 'Health')
  create_occurrences(habit)

  habit = Habit.create!(name: 'Learn',
    priority: rand(1..3),
    start_date: Faker::Date.between(from: 1.year.ago, to: Date.today), frequency: 'daily',
    status: 'active',
    user_id: User.all.sample.id,
    category: 'Learning')

  habit = Habit.create!(name: 'Write',
    priority: rand(1..3),
    start_date: Faker::Date.between(from: 1.year.ago, to: Date.today), frequency: 'daily',
    status: 'active',
    user_id: User.all.sample.id,
    category: 'Creativity')

  habit = Habit.create!(name: 'Draw',
    priority: rand(1..3),
    start_date: Faker::Date.between(from: 1.year.ago, to: Date.today), frequency: 'daily',
    status: 'active',
    user_id: User.all.sample.id,
    category: 'Creativity')

  habit = Habit.create!(name: 'Cook',
                        priority: rand(1..3),
                        start_date: Faker::Date.between(from: 1.year.ago, to: Date.today), frequency: 'daily',
                        status: 'active',
                        user_id: User.all.sample.id,
                        category: 'Health')

  habit = Habit.create!(name: 'Code',
                        priority: rand(1..3),
                        start_date: Faker::Date.between(from: 1.year.ago, to: Date.today), frequency: 'weekly',
                        days_of_week: ['Monday', 'Thursday'],
                        status: 'active',
                        user_id: User.all.sample.id,
                        category: 'Learning')
  create_occurrences(habit)

  Habit.create!(
    name: 'Dance',
    priority: rand(1..3),
    start_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
    frequency: 'weekly',
    days_of_week: ['Tuesday', 'Friday'],
    status: 'active',
    user_id: User.all.sample.id,
    category: 'Health'
  )

  habit = Habit.create!(
    name: 'Take a cold shower',
    priority: rand(1..3),
    start_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
    frequency: 'daily',
    status: 'active',
    reminder: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :morning),
    user_id: User.all.sample.id,
    category: 'Health'
  )
  create_occurrences(habit)
end
# rubocop:enable Metrics/MethodLength

# create 5 users
User.create!(email: "pedro@mail.com",
             password: 'password',
             password_confirmation: 'password',
             first_name: 'Pedro',
             last_name: 'Leal')

User.create!(email: "thuthi@mail.com",
             password: 'password',
             password_confirmation: 'password',
             first_name: 'Thuthikaran',
             last_name: 'Easvaran')

User.create!(email: "sahba@mail.com",
             password: 'password',
             password_confirmation: 'password',
             first_name: 'Sahba',
             last_name: 'Azhari')

User.create!(email: "jeannine@mail.com",
             password: 'password',
             password_confirmation: 'password',
             first_name: 'Jeannine',
             last_name: 'Vernon')

             # insert habits if environment is development
# insert_habits if Rails.env.development?

# create habit for each user with 7 consectutive occurrences (5 compelted, 2 missed) in the last 7 days
User.all.each do |user|
  habit = Habit.create!(name: 'Meditate for 10 minutes',
                        priority: rand(1..3),
                        start_date: Faker::Date.between(from: 1.year.ago, to: Date.today), frequency: 'daily',
                        status: 'active',
                        user_id: user.id,
                        category: 'Mindfulness')
  7.times do |i|
    occurrence = habit.occurrences.find_or_initialize_by(date: Date.today - i)
    occurrence.completion_status = i < 5 ? 'completed' : 'missed'
    occurrence.save!
  end
  habit = Habit.create!(name: 'Exercise for 20 minutes',
                        priority: rand(1..3),
                        start_date: Faker::Date.between(from: 1.year.ago, to: Date.today), frequency: 'daily',
                        status: 'active',
                        user_id: user.id,
                        category: 'Health')
  6.times do |i|
    occurrence = habit.occurrences.find_or_initialize_by(date: Date.today - 1 - i)
    occurrence.completion_status = i < 5 ? 'completed' : 'completed'
    occurrence.save!
  end
end
