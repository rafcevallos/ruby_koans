require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutIteration < Neo::Koan

  # -- An Aside ----------------d--------------------------------------
  # Ruby 1.8 stores names as strings. Ruby 1.9 and later stores names
  # as symbols. So we use a version dependent method "as_name" to
  # convert to the right format in the koans. We will use "as_name"
  # whenever comparing to lists of methods.

  in_ruby_version("1.8") do
    def as_name(name)
      name.to_s
    end
  end

  in_ruby_version("1.9", "2") do
    def as_name(name)
      name.to_sym
    end
  end

  # Ok, now back to the Koans.
  # -------------------------------------------------------------------

  def test_each_is_a_method_on_arrays
    assert_equal true, [].methods.include?(as_name(:each))
  end

  def test_iterating_with_each
    array = [1, 2, 3]
    sum = 0
    array.each do |item|
      sum += item
    end
    assert_equal 6, sum
  end

  def test_each_can_use_curly_brace_blocks_too # Ugh, so you can either use curlies or not.
    array = [1, 2, 3]
    sum = 0
    array.each { |item| sum += item }
    assert_equal 6, sum
  end

  def test_break_works_with_each_style_iterations
    array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    sum = 0
    array.each do |item|
      break if item > 3 # ignore values that are greater than 3
      sum += item
    end
    assert_equal 6, sum
  end

  def test_collect_transforms_elements_of_an_array
    array = [1, 2, 3]
    new_array = array.collect { |item| item + 10 } # collect is another name for map
    assert_equal [11, 12, 13], new_array

    # NOTE: 'map' is another name for the 'collect' operation
    another_array = array.map { |item| item + 10 }
    assert_equal [11, 12, 13], another_array
  end

  def test_select_selects_certain_items_from_an_array
    array = [1, 2, 3, 4, 5, 6]

    even_numbers = array.select { |item| (item % 2) == 0 } # Returns a new array containing all elements of +ary+ for which the given +block+ returns a true value.
    assert_equal [2, 4, 6], even_numbers

    # NOTE: 'find_all' is another name for the 'select' operation
    more_even_numbers = array.find_all { |item| (item % 2) == 0 }
    assert_equal [2, 4, 6], more_even_numbers
  end

  def test_find_locates_the_first_element_matching_a_criteria
    array = ["Jim", "Bill", "Clarence", "Doug", "Eli"]

    assert_equal "Clarence", array.find { |item| item.size > 4 } # Returns first matching item or nil if no matching element is found
    assert_equal nil, array.find { |item| item.size > 10 }
  end

  def test_inject_will_blow_your_mind
    result = [2, 3, 4].inject(0) { |sum, item| sum + item } # inject is the same as REDUCE
    assert_equal 9, result

    result2 = [2, 3, 4].inject(1) { |product, item| product * item }
    assert_equal 24, result2

    # Extra Credit:
    # Describe in your own words what inject does.

    # Link to a clear explanation: https://meaganwaller.com/rubys-inject-method/

    # 0 as the parameter to the inject is the initial value of sum and 2 will be the initial value of item
    # => the first run: sum = 0 , item = 2 (0 + 2) = 2
    # => the second run: sum = 2, item = 3 (2 + 3) = 5
    # => the third run: sum = 5, item = 4 (5 + 4) = 9

    # 1 as the parameter to the inject is the initial value of product and 2 is the initial value of item. If it was 0, this would return as 0
    # => the first run: product = 1, item = 2 | (1 * 2) = 2
    # => the second run: product = 2, item = 3 | (2 * 3) = 6
    # => the third run: product = 6, item = 4 | (6 * 4) = 24

    # The parameter for inject is optional, so if one isn't set, it'll set the value as the first item

    # The real power of inject is its ability to build new objects while looking at every element in the object individually.
    # It can get values from any Enumerable object. Use inject when you need to build something, you can use it for filtering, summing and grouping.
  end

  def test_all_iteration_methods_work_on_any_collection_not_just_arrays
    # Ranges act like a collection
    result = (1..3).map { |item| item + 10 }
    assert_equal [11, 12, 13], result

    # Files act like a collection of lines
    File.open("example_file.txt") do |file|
      upcase_lines = file.map { |line| line.strip.upcase } # pointing to a literal file in the koans | strip returns a copy of a string with whitespaces removed
      assert_equal ["THIS", "IS", "A", "TEST"], upcase_lines
    end

    # NOTE: You can create your own collections that work with each,
    # map, select, etc.
  end

  # Bonus Question:  In the previous koan, we saw the construct:
  #
  #   File.open(filename) do |file|
  #     # code to read 'file'
  #   end
  #
  # Why did we do it that way instead of the following?
  #
  #   file = File.open(filename)
  #   # code to read 'file'
  #
  # When you get to the "AboutSandwichCode" koan, recheck your answer.

  # We want to directly open a specific file and do something with it's contents. It seems extraneous
  # to set the file as a variable when we can perform actions directly onto the file. Perhaps if we needed
  # to do multiple things with the file, then setting a variable might work better.

end
