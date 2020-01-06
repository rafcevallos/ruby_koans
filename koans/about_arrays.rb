require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrays < Neo::Koan
  def test_creating_arrays
    empty_array = Array.new
    assert_equal Array, empty_array.class # returns the type of the object
    assert_equal 0, empty_array.size # returns number of elements in array akin to .length
  end

  def test_array_literals
    array = Array.new
    assert_equal [], array

    array[0] = 1  # set the value of the 1st position in the index to 1
    assert_equal [1], array

    array[1] = 2
    assert_equal [1, 2], array

    array << 333 # << is akin to .push -- pushes elements into an array
    assert_equal [1, 2, 333], array
  end

  def test_accessing_array_elements
    array = [:peanut, :butter, :and, :jelly]

    assert_equal :peanut, array[0]
    assert_equal :peanut, array.first
    assert_equal :jelly, array[3]
    assert_equal :jelly, array.last
    assert_equal :jelly, array[-1]
    assert_equal :butter, array[-3]
  end

  def test_slicing_arrays # returns an array without sliced elements but does not affect the original array
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut], array[0,1] # array[start index, end index]
    assert_equal [:peanut, :butter], array[0,2]
    assert_equal [:and, :jelly], array[2,2]
    assert_equal [:and, :jelly], array[2,20]
    assert_equal [], array[4,0] # returns an empty array
    assert_equal [], array[4,100] # returns an empty array
    assert_equal nil, array[5,0] # nil
    # Slices are different than single indexes: array[4, 0] and array[4] point
    # to two different spots in the array. The spot that array[4,0] points to
    # is just inbounds, while the spot that array[4] points to is out of
    # bounds.
    # ex. [0 :peanut, 1 :butter, 2 :and, 3 :jelly 4]
    # array[4] = nil -- there is 'nothing' at the 4th position
    # array[4,0] = [] -- starting at the 4th index and slicing to the 0 index returns an empty array
  end

  def test_arrays_and_ranges
    assert_equal Range, (1..5).class # asserting that (1..5) is a Range class
    assert_not_equal [1,2,3,4,5], (1..5) # asserting that a range of (1..5) does not equal an array.  You must convert it.
    assert_equal [1, 2, 3, 4, 5], (1..5).to_a # convert the range to an array that includes the last value
    assert_equal [1, 2, 3, 4], (1...5).to_a # convert the range to an array that excludes the last value
  end

  def test_slicing_with_ranges
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut, :butter, :and], array[0..2]
    assert_equal [:peanut, :butter], array[0...2]
    assert_equal [:and, :jelly], array[2..-1]
    assert_equal [:and, :jelly], array[2..3] # wrote my own to see if it's the same as using -1 index
  end

  def test_pushing_and_popping_arrays
    array = [1,2]
    array.push(:last) # insert an element into the last index

    assert_equal [1,2,:last], array

    popped_value = array.pop # pop returns an array with the last element of the original array
    assert_equal :last, popped_value
    assert_equal [1,2], array
  end

  def test_shifting_arrays
    array = [1,2]
    array.unshift(:first) # inserts elements into the front of the array

    assert_equal [:first,1,2], array

    shifted_value = array.shift # removes first element in an array and returns it -- other elements are shifted
    assert_equal :first, shifted_value
    assert_equal [1,2], array
  end

end
