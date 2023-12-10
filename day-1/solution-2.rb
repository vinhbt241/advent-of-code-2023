file = File.open('input.txt')
lines = file.readlines.map(&:chomp)

words = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']

ans = lines.inject(0) do |sum, line|
  first_digit = -1
  last_digit = -1

  (0...line.length).each do |i|
    if line[i] =~ /\d/
      first_digit = line[i].to_i
      break
    end

    first_digit = -1
    words.each do |word|
      if line[i...(i + word.length)] == word
        first_digit = words.index(word)
        break
      end
    end

    break if first_digit != -1
  end

  reverse_line = line.reverse
  (0...reverse_line.length).each do |i|
    if reverse_line[i] =~ /\d/
      last_digit = reverse_line[i].to_i
      break
    end

    last_digit = -1
    words.each do |word|
      if reverse_line[i...(i + word.length)] == word.reverse
        last_digit = words.index(word)
        break
      end
    end

    break if last_digit != -1
  end

  sum += (first_digit * 10 + last_digit)
  sum
end

puts ans