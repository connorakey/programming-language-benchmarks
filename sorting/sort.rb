def quicksort(arr)
  return arr if arr.length <= 1
  
  pivot = arr[arr.length / 2]
  left = arr.select { |x| x < pivot }
  middle = arr.select { |x| x == pivot }
  right = arr.select { |x| x > pivot }
  
  quicksort(left) + middle + quicksort(right)
end

def main
  size = 1000000
  arr = []
  
  srand(42)
  size.times do
    arr << rand(1..1000000)
  end
  
  sorted = quicksort(arr)
  
  puts "First 10: #{sorted.first(10).join(' ')}"
  puts "Last 10: #{sorted.last(10).join(' ')}"
end

main
