class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 1
    pivot = array.first
    left = array.select { |el| pivot > el }
    right = array.select { |el| pivot < el }
    sort1(left) + pivot + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |x,y| x<=>y }
    return array if length < 2
    pivot_idx = partition(array, start, length, &prc)
    left = pivot_idx - start
    right = length - (left+1)
    sort2!(array, start, left, &prc)
    sort2!(array, pivot_idx+1, right, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x,y| x<=>y }
    pivot_idx, pivot = start, array[start]
    ((start+1)...(start+length)).each do |idx|
      val = array[idx]
      if prc.call(pivot, val) >= 1
        array[idx] = array[pivot_idx+1]
        array[pivot_idx+1] = pivot
        array[pivot_idx] = val
        pivot_idx += 1
      end
    end
    pivot_idx
  end
end
