require "spec"
require "../src/bisect/ext"

class Tests
  def self.values
    [
      {:right, [] of Int32, 1, 0},
      {:right, [1], 0, 0},
      {:right, [1], 1, 1},
      {:right, [1], 2, 1},
      {:right, [1, 1], 0, 0},
      {:right, [1, 1], 1, 2},
      {:right, [1, 1], 2, 2},
      {:right, [1, 1, 1], 0, 0},
      {:right, [1, 1, 1], 1, 3},
      {:right, [1, 1, 1], 2, 3},
      {:right, [1, 1, 1, 1], 0, 0},
      {:right, [1, 1, 1, 1], 1, 4},
      {:right, [1, 1, 1, 1], 2, 4},
      {:right, [1, 2], 0, 0},
      {:right, [1, 2], 1, 1},
      {:right, [1, 2], 1.5, 1},
      {:right, [1, 2], 2, 2},
      {:right, [1, 2], 3, 2},
      {:right, [1, 1, 2, 2], 0, 0},
      {:right, [1, 1, 2, 2], 1, 2},
      {:right, [1, 1, 2, 2], 1.5, 2},
      {:right, [1, 1, 2, 2], 2, 4},
      {:right, [1, 1, 2, 2], 3, 4},
      {:right, [1, 2, 3], 0, 0},
      {:right, [1, 2, 3], 1, 1},
      {:right, [1, 2, 3], 1.5, 1},
      {:right, [1, 2, 3], 2, 2},
      {:right, [1, 2, 3], 2.5, 2},
      {:right, [1, 2, 3], 3, 3},
      {:right, [1, 2, 3], 4, 3},
      {:right, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 0, 0},
      {:right, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 1, 1},
      {:right, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 1.5, 1},
      {:right, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 2, 3},
      {:right, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 2.5, 3},
      {:right, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 3, 6},
      {:right, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 3.5, 6},
      {:right, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 4, 10},
      {:right, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 5, 10},

      {:left, [] of Int32, 1, 0},
      {:left, [1], 0, 0},
      {:left, [1], 1, 0},
      {:left, [1], 2, 1},
      {:left, [1, 1], 0, 0},
      {:left, [1, 1], 1, 0},
      {:left, [1, 1], 2, 2},
      {:left, [1, 1, 1], 0, 0},
      {:left, [1, 1, 1], 1, 0},
      {:left, [1, 1, 1], 2, 3},
      {:left, [1, 1, 1, 1], 0, 0},
      {:left, [1, 1, 1, 1], 1, 0},
      {:left, [1, 1, 1, 1], 2, 4},
      {:left, [1, 2], 0, 0},
      {:left, [1, 2], 1, 0},
      {:left, [1, 2], 1.5, 1},
      {:left, [1, 2], 2, 1},
      {:left, [1, 2], 3, 2},
      {:left, [1, 1, 2, 2], 0, 0},
      {:left, [1, 1, 2, 2], 1, 0},
      {:left, [1, 1, 2, 2], 1.5, 2},
      {:left, [1, 1, 2, 2], 2, 2},
      {:left, [1, 1, 2, 2], 3, 4},
      {:left, [1, 2, 3], 0, 0},
      {:left, [1, 2, 3], 1, 0},
      {:left, [1, 2, 3], 1.5, 1},
      {:left, [1, 2, 3], 2, 1},
      {:left, [1, 2, 3], 2.5, 2},
      {:left, [1, 2, 3], 3, 2},
      {:left, [1, 2, 3], 4, 3},
      {:left, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 0, 0},
      {:left, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 1, 0},
      {:left, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 1.5, 1},
      {:left, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 2, 1},
      {:left, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 2.5, 3},
      {:left, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 3, 3},
      {:left, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 3.5, 6},
      {:left, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 4, 6},
      {:left, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 5, 10},
    ]
  end
end

describe Bisect do
  it "should bisect an array" do
    Tests.values.each do |test|
      direction, array, element, result = test

      case direction
      when :left
        Bisect.bisect_left(array, element).should eq(result)
      when :right
        Bisect.bisect_right(array, element).should eq(result)
      else
        raise "wtf?!"
      end
    end
  end

  it "should insort a sorted array" do
    array = [] of Int32
    500.times do
      digit = rand(10)
      if digit % 2 == 0
        Bisect.insort_left(array, digit)
      else
        Bisect.insort_right(array, digit)
      end
      array.should eq(array.sort)
    end
  end

  it "should insort directly on an array" do
    array = [] of Int32
    500.times do
      digit = rand(10)
      if digit % 2 == 0
        array.insort_left(digit)
      else
        array.insort_right(digit)
      end
      array.should eq(array.sort)
    end

    Tests.values.each do |test|
      direction, array, element, result = test

      case direction
      when :left
        array.bisect_left(element).should eq(result)
      when :right
        array.bisect_right(element).should eq(result)
      else
        raise "wtf?!"
      end
    end
  end
end
