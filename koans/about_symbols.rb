require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutSymbols < Neo::Koan
  def test_symbols_are_symbols
    symbol = :ruby
    assert_equal true, symbol.is_a?(Symbol)
  end

  def test_symbols_can_be_compared
    symbol1 = :a_symbol
    symbol2 = :a_symbol
    symbol3 = :something_else

    assert_equal true, symbol1 == symbol2
    assert_equal false, symbol1 == symbol3
  end

  def test_identical_symbols_are_a_single_internal_object
    symbol1 = :a_symbol
    symbol2 = :a_symbol

    assert_equal true, symbol1 == symbol2
    assert_equal true, symbol1.object_id == symbol2.object_id
  end

  def test_method_names_become_symbols
    symbols_as_strings = Symbol.all_symbols.map { |x| x.to_s } # map returns an array much like JS map
    assert_equal true, symbols_as_strings.include?("test_method_names_become_symbols")
  end

  # THINK ABOUT IT:
  #
  # Why do we convert the list of symbols to strings and then compare against the string value rather than against symbols?
  # From Stack Overflow:
  # 1. Only one of a symbol exists
  # 2. Symbol is just a number referred to by a name e.g. :symbol_thing
  # 3. So, when you compare symbols, you're actually comparing their object ids and NOT the content of the idenitifier
  # 4. Symbols are objects that represent names and some strings

  in_ruby_version("mri") do
    RubyConstant = "What is the sound of one hand clapping?"
    def test_constants_become_symbols
      all_symbols_as_strings = Symbol.all_symbols.map { |x| x.to_s }

      assert_equal false, all_symbols_as_strings.include?(RubyConstant) #
    end
  end

  def test_symbols_can_be_made_from_strings
    string = "catsAndDogs"
    assert_equal :catsAndDogs, string.to_sym # return the value of the string as a symbol
  end

  def test_symbols_with_spaces_can_be_built
    symbol = :"cats and dogs"

    assert_equal :"cats and dogs".to_sym, symbol
  end

  def test_symbols_with_interpolation_can_be_built
    value = "and"
    symbol = :"cats #{value} dogs"

    assert_equal :"cats #{value} dogs".to_sym, symbol
  end

  def test_to_s_is_called_on_interpolated_symbols
    symbol = :cats
    string = "It is raining #{symbol} and dogs."

    assert_equal "It is raining cats and dogs.", string
  end

  def test_symbols_are_not_strings
    symbol = :ruby
    assert_equal false, symbol.is_a?(String)
    assert_equal false, symbol.eql?("ruby")
  end

  def test_symbols_do_not_have_string_methods
    symbol = :not_a_string
    assert_equal false, symbol.respond_to?(:each_char) # each_char iterates over each character in a string -- symbols aren't strings
    assert_equal false, symbol.respond_to?(:reverse) # reverses a string
  end

  # It's important to realize that symbols are not "immutable strings", though they are immutable.
  # None of the interesting string operations are available on symbols. SAD

  def test_symbols_cannot_be_concatenated
    # Exceptions will be pondered further down the path
    assert_raise(Exception) do
      :cats + :dogs
    end
  end

  def test_symbols_can_be_dynamically_created
    assert_equal :catsdogs, ("cats" + "dogs").to_sym
  end

  # THINK ABOUT IT:
  #
  # Why is it not a good idea to dynamically create a lot of symbols?

  # From Stack Overflow

  # If you are using Ruby 2.2.0 or later, it should usually be OK to dynamically create a lot of symbols
  # because they will be garbage collected according to the Ruby 2.2.0-preview1 announcement,
  # which has a link to more details about the new symbol GC.
  # However, if you pass your dynamic symbols to some kind of code that converts it to
  # an ID (an internal Ruby implementation concept used in the C source code),
  # then in that case it will get pinned and never get garbage collected. I'm not sure how commonly that happens.

  # You can think of symbols as a name of something, and strings (roughly) as a sequence of characters.
  # In many cases you could use either a symbol or a string, or you could use a mixture of the two.
  # Symbols are immutable, which means they can't be changed after being created.
  # The way symbols are implemented, it is very efficient to compare two symbols to see if they are equal,
  # so using them as keys to hashes should be a little faster than using strings.
  # Symbols don't have a lot the methods that strings do, such as start_with?
  # so you would have to use to_s to convert the symbol into a string before calling those methods.

  # You can read more about symbols here in the documentation:

  # http://www.ruby-doc.org/core-2.1.3/Symbol.html
end
