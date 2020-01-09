require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutKeywordArguments < Neo::Koan

  def method_with_keyword_arguments(one: 1, two: 'two')
    [one, two]
  end

  def test_keyword_arguments
    assert_equal Array, method_with_keyword_arguments.class
    assert_equal [1, "two"], method_with_keyword_arguments
    assert_equal ["one", "two"], method_with_keyword_arguments(one: 'one')
    assert_equal [1, 2], method_with_keyword_arguments(two: 2)
  end

  def method_with_keyword_arguments_with_mandatory_argument(one, two: 2, three: 3) # one is a mandatory argument. the others are optional
    [one, two, three]
  end

  def test_keyword_arguments_with_wrong_number_of_arguments
    exception = assert_raise (ArgumentError) do
      method_with_keyword_arguments_with_mandatory_argument
    end
    assert_match(/given 0, expected 1/, exception.message)
  end

  # THINK ABOUT IT:
  #
  # Keyword arguments always have a default value, making them optional to the caller
  # Link to a helpful article: https://thoughtbot.com/upcase/videos/ruby-keyword-arguments

  # Benefits from the aforementioned article:
  # With positional arguments, position matters. If we remove one or move it around, the meaning changes.
  # Keyword arguments don't care about position, which makes adding a new argument easy, especially if it has a default value (since callers don't have to change).
  # Keyword arguments also go well with positional arguments.
  # One pattern thoughtbot uses is a positional argument as the first, "main" argument, with "secondary" arguments as keyword arguments after it.

end
