file = File.open('input.txt')
sequences = file.readlines.map(&:chomp)
sequences.map! { |sequence| sequence.split(' ').map!(&:to_i) }

predicted_values = []

sequences.each do |sequence|
  diff_arrs = [sequence]

  while diff_arrs.size == 0 || diff_arrs[-1].any? { |e| e != 0 }
    curr_arr = diff_arrs[-1]
    diff_arr = []
    (0...(curr_arr.size - 1)).each do |i|
      diff_arr << curr_arr[i + 1] - curr_arr[i]
    end
    diff_arrs << diff_arr
  end

  predicted_value = 0
  i = diff_arrs.size - 2

  while i >= 0
    predicted_value += diff_arrs[i][-1]
    i -= 1
  end

  predicted_values << predicted_value
end

p predicted_values.sum