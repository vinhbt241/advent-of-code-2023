file = File.open('input.txt')
lines = file.readlines.map(&:chomp)

arr = lines.map do |line|
  line.split('')
end

point_coordinates = []

arr.each_with_index do |row, i|
  row.each_with_index do |col, j|
    point_coordinates << [i, j] if col == '#'
  end
end

rows_contain_points = point_coordinates.map do |coordinate|
  coordinate[0]
end
rows_contain_points.uniq!.sort!

cols_contain_points = point_coordinates.map do |coordinate|
  coordinate[1]
end
cols_contain_points.uniq!.sort!

sum = 0
(0...(point_coordinates.size - 1)).each do |i|
  r1, c1 = point_coordinates[i]

  ((i + 1)...point_coordinates.size).each do |j|
    r2, c2 = point_coordinates[j]

    r_min = [r1, r2].min
    r_max = [r1, r2].max

    ((r_min + 1)..r_max).each do |r|
      if rows_contain_points.include?(r)
        sum += 1
      else
        sum += 1000000
      end
    end

    c_min = [c1, c2].min
    c_max = [c1, c2].max

    ((c_min + 1)..c_max).each do |c|
      if cols_contain_points.include?(c)
        sum += 1
      else
        sum += 1000000
      end
    end
  end
end

p sum