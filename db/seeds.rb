require 'faker'

# Generate seed data for 'attendances' table
attendance_seeds = []

# Set current date
current_date = Date.new(2024, 6, 11)

# Define the range for random times
time_range = (1..10).to_a

# Number of seed records to generate
number_of_records = 5

number_of_records.times do
  hour = time_range.sample
  minute = Faker::Number.between(from: 0, to: 59)
  second = Faker::Number.between(from: 0, to: 59)
  time_check = Time.new(current_date.year, current_date.month, current_date.day, hour, minute, second)

  puts "Generated time_check: #{time_check.strftime('%H:%M:%S')}" # Debugging statement

  attendance_seeds << {
    date: current_date,
    user_id: 47,
    attendance_type_id: 1,
    created_at: Time.now,
    time_check: time_check.strftime('%H:%M:%S')
  }
end

# Insert seed data into the 'attendances' table
attendance_seeds.each do |seed|
  puts "Inserting seed: #{seed}"
  Attendance.create(seed)
end

puts "Seed data inserted successfully!"
