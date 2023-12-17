step_file = File.open('steps.txt')
direction_file = File.open('map.txt')

steps = step_file.readlines.map(&:chomp)[0]
direction_lines = direction_file.readlines.map(&:chomp)

directions = {}
direction_lines.each do |direction_line|
  current_pos = direction_line[0..2]
  left_dir = direction_line[7..9]
  right_dir = direction_line[12..14]

  directions[current_pos] = [left_dir, right_dir]
end

total_steps = 0
current_pos = 'AAA'

while current_pos != 'ZZZ'
  next_step = steps[total_steps % steps.size]

  current_pos = directions[current_pos][next_step == 'L' ? 0 : 1]

  total_steps += 1
end

p total_steps
