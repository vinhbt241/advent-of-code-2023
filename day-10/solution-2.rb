# symbol : direction
#   |    :    North -> South                                  N
#   -    :    West -> East                                    |
#   L    :    North -> East                               W -- -- E
#   J    :    North -> West                                   |
#   7    :    South -> West                                   S
#   F    :    South -> East
#   .    :    Ground
#   S    :    Starting position


possible_moves = {
  up: ['7', 'F', '|'],
  down: ['J', 'L', '|'],
  left: ['L', 'F', '-'],
  right: ['J', '7', '-']
}

file = File.open('input.txt')
lines = file.readlines.map(&:chomp)

arr = lines.map do |line|
  line.split('')
end

# Locate starting position
s_row = 0
s_col =0
arr.each_with_index do |row, i|
  row.each_with_index do |col, j|
    if col == 'S'
      s_row = i
      s_col = j
      break
    end
  end
end

# Add first coordinate and direction
possible_loops = []
possible_loops << [[s_row, s_col], :up] if s_row > 0 && ['|', '7', 'F'].include?(arr[s_row - 1][s_col])
possible_loops << [[s_row, s_col], :down] if s_row + 1 < arr.size && ['|', 'J', 'L'].include?(arr[s_row + 1][s_col])
possible_loops << [[s_row, s_col], :left] if s_col > 0 && ['-', 'L', 'F'].include?(arr[s_row][s_col - 1])
possible_loops << [[s_row, s_col], :right] if s_col + 1 < arr[0].size && ['-', 'J', '7'].include?(arr[s_row][s_col + 1])

# Add next coordinates and directions
possible_loops.map! do |possible_loop|
  curr_loop = [possible_loop]

  while(true)
    coordinates, direction = curr_loop[-1]
    row, col = coordinates

    case direction
    when :up
      row -= 1
    when :down
      row += 1
    when :left
      col -= 1
    else
      col += 1
    end

    if row < 0 || row >= arr.size || col < 0 || col >= arr[0].size
      curr_loop << nil
      break
    end

    if arr[row][col] == 'S'
      curr_loop << [[row, col], 'S']
      break
    end

    if arr[row][col] == '.' || !possible_moves[direction].include?(arr[row][col])
      curr_loop << nil
      break
    end

    case direction
    when :up
      case arr[row][col]
      when '7'
        curr_loop << [[row, col], :left]
      when 'F'
        curr_loop << [[row, col], :right]
      when '|'
        curr_loop << [[row, col], :up]
      end
    when :down
      case arr[row][col]
      when 'J'
        curr_loop << [[row, col], :left]
      when 'L'
        curr_loop << [[row, col], :right]
      when '|'
        curr_loop << [[row, col], :down]
      end
    when :left
      case arr[row][col]
      when 'L'
        curr_loop << [[row, col], :up]
      when 'F'
        curr_loop << [[row, col], :down]
      when '-'
        curr_loop << [[row, col], :left]
      end
    when :right
      case arr[row][col]
      when 'J'
        curr_loop << [[row, col], :up]
      when '7'
        curr_loop << [[row, col], :down]
      when '-'
        curr_loop << [[row, col], :right]
      end
    end
  end

  curr_loop
end

# Select the one that end with 'S' - complete loop
possible_loops.select! do |possible_loop|
  possible_loop[-1][-1] == 'S'
end

# Select biggest loop
biggest_loop = []
possible_loops.each do |possible_loop|
  if possible_loop.size > biggest_loop.size
    biggest_loop = possible_loop
  end
end

# Remove the S element at the end of array
biggest_loop.pop

biggest_loop.map! do |bl|
  bl[0]
end

cols_in_same_row = []
biggest_loop.each do |bl|
  row, col = bl

  if cols_in_same_row[row].nil?
    cols_in_same_row[row] = [col]
  else
    cols_in_same_row[row] << col
  end
end

cols_in_same_row = cols_in_same_row
cols_in_same_row.map! do |cols|
  cols.sort
end

tiles = 0
cols_in_same_row.each do |cols|
  (cols[0]..cols[-1]).each do |i|
    next if cols.include?(i)

    n = 0
    ((i + 1)..cols[-1]).each do |j|
      n += 1 if cols.include?(j)
    end

    tiles += 1 if n.odd?
  end
end

p tiles
# For some reasons this answer is mistaken for others - It could be wrong though