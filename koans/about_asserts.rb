#!/usr/bin/env ruby
# -*- ruby -*-

require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutAsserts < Neo::Koan

  # We shall contemplate truth by testing reality, via asserts.
  def test_assert_truth
    assert true                # This should be true
  end

  # Enlightenment may be more easily achieved with appropriate
  # messages.
  def test_assert_with_message
    assert true, "This should be true -- Please fix this"
  end

  # To understand reality, we must compare our expectations against
  # reality.
  def test_assert_equality
    expected_value = __
    actual_value = 1 + 1

    assert expected_value != actual_value
  end

  # Some ways of asserting equality are better than others.
  def test_a_better_way_of_asserting_equality
    expected_value = __
    actual_value = 1 + 1

    assert_equal 2, actual_value
  end

  # Sometimes we will ask you to fill in the values
  def test_fill_in_values
    assert_equal 2, 1 + 1
  end
end

=begin
NOTES
--Assertions are boolean expressions used to identify bugs and make testing more effective
--Assertions must be excecuted to provide any meaningful information

--Assuming the code is being properly tested, assertions do several USEFUL things:
    Detect subtle errors that might otherwise go undetected
    Detect errors sooner after they occur than they might otherwise be detected
    Make a statement about the effects of the code that is guaranteed to be true

--A bug in an assertion will likely cause one of these problems:
    Reporting an error where none exists
    Failing to report a bug that does exist
    Not being side-effect free

--Assertions Can Impact Performance
    Take time to execute
    Take up extra memory

--Assertions May Block Testing

--Keep in mind that Some Things Are Difficult to Check For
=end
