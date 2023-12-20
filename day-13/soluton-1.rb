file = File.open('input.txt')
content = file.read

patterns = content.split("\n\n")
patterns.map! do |pattern|
  pattern = pattern.split("\n")
  pattern = pattern.map! do |row|
    row.split('')
  end
end

sum = 0

patterns.each do |pattern|
  # Search for horizontal reflections
  (1..(pattern.size - 1)).each do |num_rows|
    consider_rows = [num_rows, pattern.size - num_rows].min

    up_pattern = pattern[((num_rows - 1 - (consider_rows - 1))..(num_rows - 1))]
    down_pattern = pattern[(num_rows..(num_rows + consider_rows - 1))]

    if up_pattern == down_pattern.reverse
      sum += num_rows * 100
    end
  end

  # Search for vertial reflections
  transpose_pattern = pattern.transpose
  (1..(transpose_pattern.size - 1)).each do |num_rows|
    consider_rows = [num_rows, transpose_pattern.size - num_rows].min

    up_pattern = transpose_pattern[((num_rows - 1 - (consider_rows - 1))..(num_rows - 1))]
    down_pattern = transpose_pattern[(num_rows..(num_rows + consider_rows - 1))]

    if up_pattern == down_pattern.reverse
      sum += num_rows
    end
  end
end

p sum