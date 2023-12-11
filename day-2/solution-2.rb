file = File.open('input.txt')
lines = file.readlines.map(&:chomp)

sum = 0

lines.each_with_index do |line, i|
  sets = line.split(':')[1].gsub(/[,;]/, '').split(' ')

  r = 0
  g = 0
  b = 0

  (0...sets.length).step(2) do |n|
    num_cubes = sets[n].to_i

    if sets[n + 1] == 'red' && num_cubes > r
      r = num_cubes
    elsif sets[n + 1] == 'green' && num_cubes > g
      g = num_cubes
    elsif sets[n + 1] == 'blue' && num_cubes > b
      b = num_cubes
    end
  end

  p [r, g, b]

  sum += (r * g * b)
end

puts sum