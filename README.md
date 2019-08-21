# Crystal Lang Bisect

Provides helpers for dealing with sorted Arrays.
It uses binary search to reduce the number of comparisons.

[![Build Status](https://travis-ci.org/spider-gazelle/bisect.svg?branch=master)](https://travis-ci.org/spider-gazelle/bisect)


Usage
=====

There are two primary functions that you need to know about `Bisect.insort` and `Bisect.bisect`.

`Bisect.insort` adds a new element to the Array, but keeps the Array sorted:

```ruby
require "bisect"
a = [1, 2, 4]
Bisect.insort(a, 3)
a == [1, 2, 3, 4]
```

`Bisect.bisect` gives you the index at which the element would have been inserted:

```ruby
require "bisect"
a = ['a', 'b', 'd']
Bisect.bisect(a, 'c') == 2
```

If there are equal elements in the Array then `insort` will insert the element after the last equal element. Similarly `bisect` will return the index one higher than the last equal element. If you'd like to add new elements before equal elements, use `insort_left` and `bisect_left`. If you need to be explicit then `insort_right` and `bisect_right` are aliases for `insort` and `bisect`.

The above methods are useful for finding insertion points but can be tricky or awkward to use for common searching tasks. Hence the following methods focus on searching for specific values:

`Bisect.find_gt(a, x)` return left most value greater than `x` otherwise `nil` if no value greater than `x` exists:
```ruby
scores = [33, 70, 77, 89, 89, 90, 99, 100]
Bisect.find_gt(scores, 65)  #=> 70
Bisect.find_gt(scores, 70)  #=> 77
Bisect.find_gt(scores, 101) #=> nil
```

`Bisect.find_ge(a, x)` returns left most value greater than or equal to `x` otherwise `nil` if no value greater than or equal to `x` exists:
```ruby
Bisect.find_ge(scores, 65)  #=> 70
Bisect.find_ge(scores, 70)  #=> 70
Bisect.find_ge(scores, 101) #=> nil
```

`Bisect.find_lt` returns rightmost value less than `x` otherwise `nil` if no value less than `x` exists:
```ruby
Bisect.find_lt(scores, 65)  #=> 33
Bisect.find_lt(scores, 70)  #=> 33
Bisect.find_lt(scores, 32)  #=> nil
```

`Bisect.find_le` returns rightmost value less than or equal to `x` otherwise `nil` if no value less than or equal to `x` exists:
```ruby
Bisect.find_le(scores, 65)  #=> 33
Bisect.find_le(scores, 70)  #=> 70
Bisect.find_le(scores, 32)  #=> nil
```

Core ext
========

These methods are also available directly on Arrays

```ruby
require "bisect/ext"
a = [1, 2, 4]
a.insort(3)
a == [1, 2, 3, 4]

scores = [33, 70, 77, 89, 89, 90, 99, 100]
scores.find_gt(70) #=> 77
scores.find_ge(70) #=> 70
scores.find_lt(70) #=> 33
scores.find_le(70) #=> 70
```

