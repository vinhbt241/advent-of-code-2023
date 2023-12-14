seed_file = File.open('data/seeds.txt')
seeds = seed_file.readlines.map(&:chomp)[0].split(' ').map(&:to_i)

[
  'data/seed-to-soil.txt',
  'data/soil-to-fertilizer.txt',
  'data/fertilizer-to-water.txt',
  'data/water-to-light.txt',
  'data/light-to-temperature.txt',
  'data/temperature-to-humidity.txt',
  'data/humidity-to-location.txt'
].each do |file_name|
  file = File.open(file_name)
  mappings = file.readlines.map(&:chomp)
  mappings.map! do |mapping|
    mapping.split(" ").map(&:to_i)
  end


  seeds.map! do |seed|
    mappings.each do |mapping|
      dest, src, rng = mapping

      if seed >= src && seed < src + rng
        seed = dest + (seed - src)
        break
      end
    end

    seed
  end
end

puts seeds.min
