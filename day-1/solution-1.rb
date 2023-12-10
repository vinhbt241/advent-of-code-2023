file = File.open('input.txt')
lines = file.readlines.map(&:chomp)

cv = lines.reduce(0) do |sum, line|
  i = 0
  j = line.length - 1
  regex = /[0-9]/

  while (line[i] =~ regex).nil? || (line[j] =~ regex).nil?
    i += 1 if (line[i] =~ regex).nil?
    j -= 1 if (line[j] =~ regex).nil?
  end

  sum += (line[i].to_i * 10 + line[j].to_i)
  sum
end

puts cv