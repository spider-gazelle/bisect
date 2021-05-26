# A direct port of the Python bisect standard library.
#
# http://svn.python.org/view/python/branches/py3k/Lib/bisect.py?view=markup&pathrev=70846
#
module Bisect
  extend self

  # Insert item x in list a, and keep it sorted assuming a is sorted.
  #
  # If x is already in a, insert it to the right of the rightmost x.
  #
  # Optional args lo (default 0) and hi (default len(a)) bound the
  # slice of a to be searched.
  def insort_right(a, x, lo = 0, hi = a.size)
    index = bisect_right(a, x, lo, hi)
    a.insert(index, x)
  end

  def insort(a, x, lo = 0, hi = a.size)
    insort_right(a, x, lo, hi)
  end

  # Return the index where to insert item x in list a, assuming a is sorted.
  #
  # The return value i is such that all e in a[:i] have e <= x, and all e in
  # a[i:] have e > x.  So if x already appears in the list, a.insert(x) will
  # insert just after the rightmost x already there.
  #
  # Optional args lo (default 0) and hi (default len(a)) bound the
  # slice of a to be searched.
  def bisect_right(a, x, lo = 0, hi = a.size)
    raise ArgumentError.new("lo must be non-negative") if lo < 0

    while lo < hi
      mid = (lo + hi) // 2
      if x < a[mid]
        hi = mid
      else
        lo = mid + 1
      end
    end

    lo
  end

  def bisect(a, x, lo = 0, hi = a.size)
    bisect_right(a, x, lo, hi)
  end

  # Insert item x in list a, and keep it sorted assuming a is sorted.
  #
  # If x is already in a, insert it to the left of the leftmost x.
  #
  # Optional args lo (default 0) and hi (default len(a)) bound the
  # slice of a to be searched.
  def insort_left(a, x, lo = 0, hi = a.size)
    index = bisect_left(a, x, lo, hi)
    a.insert(index, x)
  end

  # Return the index where to insert item x in list a, assuming a is sorted.
  #
  # The return value i is such that all e in a[:i] have e < x, and all e in
  # a[i:] have e >= x.  So if x already appears in the list, a.insert(x) will
  # insert just before the leftmost x already there.
  #
  # Optional args lo (default 0) and hi (default len(a)) bound the
  # slice of a to be searched.
  def bisect_left(a, x, lo = 0, hi = a.size)
    raise ArgumentError.new("lo must be non-negative") if lo < 0

    while lo < hi
      mid = (lo + hi) // 2
      if a[mid] < x
        lo = mid + 1
      else
        hi = mid
      end
    end

    lo
  end

  # Find leftmost value greater than x
  def find_gt(a, x)
    i = bisect_right(a, x)
    i != a.size ? a[i] : nil
  end

  # Find leftmost item greater than or equal to x
  def find_ge(a, x)
    i = bisect_left(a, x)
    i != a.size ? a[i] : nil
  end

  # Find rightmost value less than x
  def find_lt(a, x)
    i = bisect_left(a, x)
    i > 0 ? a[i - 1] : nil
  end

  # Find rightmost value less than or equal to x
  def find_le(a, x)
    i = bisect_right(a, x)
    i > 0 ? a[i - 1] : nil
  end
end
