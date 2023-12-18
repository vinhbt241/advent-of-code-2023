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

possible_loops = []
possible_loops << [[s_row, s_col], :up] if s_row > 0 && ['|', '7', 'F'].include?(arr[s_row - 1][s_col])
possible_loops << [[s_row, s_col], :down] if s_row + 1 < arr.size && ['|', 'J', 'L'].include?(arr[s_row + 1][s_col])
possible_loops << [[s_row, s_col], :left] if s_col > 0 && ['-', 'L', 'F'].include?(arr[s_row][s_col - 1])
possible_loops << [[s_row, s_col], :right] if s_col + 1 < arr[0].size && ['-', 'J', '7'].include?(arr[s_row][s_col + 1])

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

possible_loops.select! do |possible_loop|
  possible_loop[-1][-1] == 'S'
end

ans = possible_loops.max do |possible_loop|
  possible_loop.size
end

p (ans.size - 1) / 2