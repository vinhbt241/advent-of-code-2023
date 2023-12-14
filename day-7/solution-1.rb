file = File.open('input.txt')
lines = file.readlines.map(&:chomp)

def rank(cards)
  return 1 if cards.size == 5
  return 2 if cards.size == 4
  return 3 if cards.size == 3 && cards.values.include?(2)
  return 4 if cards.size == 3 && cards.values.include?(3)
  return 5 if cards.size == 2 && cards.values.include?(3)
  return 6 if cards.size == 2 && cards.values.include?(4)

  7
end

def hand_to_code(hand)
  characters = %w(2 3 4 5 6 7 8 9 T J Q K A)

  char_values = hand.split('').map do |c|
    v = characters.index(c)
    "#{v < 10 ? '0' : ''}#{v}"
  end

  char_values.join('')
end

ranks = []
bids = []
lines.each do |line|
  hand, bid = line.split(' ')
  bid = bid.to_i

  cards = Hash.new(0)

  hand.split('').each do |c|
    cards[c] += 1
  end

  ranks << "#{rank(cards)}#{hand_to_code(hand)}".to_i
  bids << bid
end

pos = []
i = 1
while(ranks.min != 99999999999)
  m = ranks.min
  m_index = ranks.index(m)

  ranks[m_index] = 99999999999
  pos[m_index] = i
  i += 1
end

ans = 0
(0...pos.size).each do |i|
  ans += (pos[i] * bids[i])
end

p ans
