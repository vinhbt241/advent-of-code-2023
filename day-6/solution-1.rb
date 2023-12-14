file = File.open('input.txt')
lines = file.readlines.map(&:chomp)

time_data = lines[0].split(':')[1].split(' ').map(&:to_i)
distance_data = lines[1].split(':')[1].split(' ').map(&:to_i)

ans = 1

time_data.each_with_index do |t, i|
  d = distance_data[i]

  n = 0

  (1...t).each do |t_hold|
    n += 1 if t_hold * (t - t_hold) > d
  end

  ans *= n
end

p ans