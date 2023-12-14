file = File.open('input.txt')
lines = file.readlines.map(&:chomp)

time_data = lines[0].split(':')[1].split(' ').join('').to_i
distance_data = lines[1].split(':')[1].split(' ').join('').to_i

n = 0
(1...time_data).each do |t_hold|
  n += 1 if t_hold * (time_data - t_hold) > distance_data
end

p n
