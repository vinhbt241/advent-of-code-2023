file = File.open('input.txt')
lines = file.readlines.map(&:chomp)

sum = 0

lines.each_with_index do |line, i|
  sets = line.split(':')[1].gsub(/[,;]/, '').split(' ')

  can_sum = true

  (0...sets.length).step(2) do |n|
    num_cubes = sets[n].to_i

    if (sets[n + 1] == 'red' && num_cubes > 12) ||
       (sets[n + 1] == 'green' && num_cubes > 13) ||
       (sets[n + 1] == 'blue' && num_cubes > 14)
      can_sum = false
      break
    end
  end

  sum += (i + 1) if can_sum
end

puts sum