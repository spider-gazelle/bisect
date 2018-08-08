require "../bisect"

class Array
  def insort_left(x, lo = 0, hi = self.size)
    Bisect.insort_left(self, x, lo, hi)
  end

  def insort_right(x, lo = 0, hi = self.size)
    Bisect.insort_right(self, x, lo, hi)
  end

  def insort(x, lo = 0, hi = self.size)
    Bisect.insort_right(self, x, lo, hi)
  end

  def bisect_left(x, lo = 0, hi = self.size)
    Bisect.bisect_left(self, x, lo, hi)
  end

  def bisect_right(x, lo = 0, hi = self.size)
    Bisect.bisect_right(self, x, lo, hi)
  end

  def bisect(x, lo = 0, hi = self.size)
    Bisect.bisect_right(self, x, lo, hi)
  end
end
