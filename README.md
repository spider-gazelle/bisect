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


Core ext
========

These methods are also available directly on Arrays

```ruby
require "bisect/ext"
a = [1, 2, 4]
a.insort(3)
a == [1, 2, 3, 4]
```
