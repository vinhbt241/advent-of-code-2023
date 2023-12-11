def part?(arr, r1, c1, r2, c2)
  if r1 >= 0
    cx = [c1, 0].max
    cy = [c2, arr[0].size - 1].min

    return true if arr[r1][cx..cy].any? { |e| e != '.' && (e =~ /\d/).nil? }
  end

  if r2 < arr.size
    cx = [c1, 0].max
    cy = [c2, arr[0].size - 1].min

    return true if arr[r2][cx..cy].any? { |e| e != '.' && (e =~ /\d/).nil? }
  end

  if c1 >= 0
    return true if arr[r1 + 1][c1] != '.' && (arr[r1 + 1][c1] =~ /\d/).nil?
  end

  if c2 < arr[0].size
    return true if arr[r1 + 1][c2] != '.' && (arr[r1 + 1][c1] =~ /\d/).nil?
  end

  false
end


file = File.open('input.txt')
lines = file.readlines.map(&:chomp)

arr = lines.inject([]) do |arr, line|
  arr << line.split('')
  arr
end

sum = 0

(0...arr.size).each do |i|
  row = arr[i]

  j = 0
  while j < row.size
    unless (row[j] =~ /\d/).nil?
      s = ''
      r1 = i - 1
      c1 = j - 1

      while j < row.size && (row[j] =~ /\d/)
        s += row[j]
        j += 1
      end

      r2 = i + 1
      c2 = j

      if part?(arr, r1, c1, r2, c2)
        sum += s.to_i
      end
    end

    j += 1
  end
end

puts sum
