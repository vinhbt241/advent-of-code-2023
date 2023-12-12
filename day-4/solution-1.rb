file = File.open('input.txt')
lines = file.readlines.map(&:chomp)

sum = 0

lines.each do |line|
  winning_numbers, current_numbers = line.split(':')[1].split('|')
  winning_numbers = winning_numbers.split(' ').map(&:to_i)
  current_numbers = current_numbers.split(' ').map(&:to_i)

  same_numbers = winning_numbers & current_numbers

  sum += (2 ** (same_numbers.size - 1)) if same_numbers.size > 0
end

puts sum