require "../bisect"

module Bisect::Helper
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

  def find_gt(x)   
    Bisect.find_gt(self, x)
  end

  def find_ge(x)   
    Bisect.find_ge(self, x)
  end

  def find_lt(x)   
    Bisect.find_lt(self, x)
  end

  def find_le(x)   
    Bisect.find_le(self, x)
  end
end
