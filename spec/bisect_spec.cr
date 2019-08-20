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

  describe "searching sorted arrays" do
    scores = [33, 70, 77, 89, 89, 90, 99, 100]

    describe ".find_gt" do
      it "should return left most value greater than x" do
        Bisect.find_gt(scores, 65).should eq 70
        Bisect.find_gt(scores, 70).should eq 77
        Bisect.find_gt(scores, 89).should eq 90

        scores.find_gt(65).should eq 70
        scores.find_gt(70).should eq 77
        scores.find_gt(89).should eq 90
      end

      it "should return nil if value greatr than x does not exist" do
        Bisect.find_gt(scores, 101).should be_nil

        scores.find_gt(101).should be_nil
      end
    end

    describe ".find_ge" do
      it "should return left most value greater than or equal to x" do
        Bisect.find_ge(scores, 65).should eq 70
        Bisect.find_ge(scores, 70).should eq 70
        Bisect.find_ge(scores, 89).should eq 89

        scores.find_ge(65).should eq 70
        scores.find_ge(70).should eq 70
        scores.find_ge(89).should eq 89
      end

      it "should return nil if value greater than or equal to x does not exist" do
        Bisect.find_ge(scores, 101).should be_nil

        scores.find_ge(101).should be_nil
      end
    end

    describe ".find_lt" do
      it "should return rightmost value less than x" do
        Bisect.find_lt(scores, 65).should eq 33
        Bisect.find_lt(scores, 70).should eq 33
        Bisect.find_lt(scores, 89).should eq 77

        scores.find_lt(65).should eq 33
        scores.find_lt(70).should eq 33
        scores.find_lt(89).should eq 77
      end

      it "raises an error if value less than x does not exist" do
        Bisect.find_lt(scores, 32).should be_nil

        scores.find_lt(32).should be_nil
      end
    end

    describe ".find_le" do
      it "should return rightmost value less than or equal to x" do
        Bisect.find_le(scores, 65).should eq 33
        Bisect.find_le(scores, 70).should eq 70
        Bisect.find_le(scores, 89).should eq 89

        scores.find_le(65).should eq 33
        scores.find_le(70).should eq 70
        scores.find_le(89).should eq 89
      end

      it "should return nil if value less than or equal to x does not exist" do
        Bisect.find_le(scores, 32).should be_nil

        scores.find_le(32).should be_nil
      end
    end
  end

end
