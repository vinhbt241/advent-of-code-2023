file = File.open('input.txt')
lines = file.readlines.map(&:chomp)

cards = {}

lines.size.times do |i|
  cards["card_#{i}".to_sym] = 1
end

lines.each_with_index do |line, i|
  winning_numbers, current_numbers = line.split(':')[1].split('|')
  winning_numbers = winning_numbers.split(' ').map(&:to_i)
  current_numbers = current_numbers.split(' ').map(&:to_i)

  same_numbers = winning_numbers & current_numbers
  total_match = same_numbers.size

  cards["card_#{i}".to_sym].times do
    total_match.times do |n|
      cards["card_#{i + n + 1}".to_sym] = cards["card_#{i + n + 1}".to_sym] + 1
    end
  end
end

sum = 0
cards.each do |k, v|
  sum += v
end

puts sum