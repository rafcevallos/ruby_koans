# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutRegularExpressions < Neo::Koan
  def test_a_pattern_is_a_regular_expression
    assert_equal Regexp, /pattern/.class
  end

  def test_a_regexp_can_search_a_string_for_matching_content
    assert_equal "match", "some matching content"[/match/]
  end

  def test_a_failed_match_returns_nil
    assert_equal nil, "some matching content"[/missing/]
  end

  # ------------------------------------------------------------------

  def test_question_mark_means_optional
    assert_equal "ab", "abbcccddddeeeee"[/ab?/]
    assert_equal "a", "abbcccddddeeeee"[/az?/]
  end

  def test_plus_means_one_or_more
    assert_equal "bccc", "abbcccddddeeeee"[/bc+/]
  end

  def test_asterisk_means_zero_or_more
    assert_equal "abb", "abbcccddddeeeee"[/ab*/]
    assert_equal "a", "abbcccddddeeeee"[/az*/]
    assert_equal "", "abbcccddddeeeee"[/z*/]
    assert_equal nil, "abbcccddddeeeee"[/za*/] # this fails because it can't find z and thus doesn't even bother looking for a

    # THINK ABOUT IT:
    #
    # When would * fail to match?
    # If using the example string above, the * operator would fail if the first search isn't found
  end

  # THINK ABOUT IT:
  #
  # We say that the repetition operators above are "greedy."
  #
  # Why?

  # ------------------------------------------------------------------

  def test_the_left_most_match_wins
    assert_equal "a", "abbccc az"[/az*/]
  end

  # ------------------------------------------------------------------

  # CHARACTER CLASSES: match a character from a specific set.

  def test_character_classes_give_options_for_a_character
    animals = ["cat", "bat", "rat", "zat"]
    assert_equal ["cat", "bat", "rat"], animals.select { |a| a[/[cbr]at/] }
  end

  def test_slash_d_is_a_shortcut_for_a_digit_character_class
    assert_equal "42", "the number is 42"[/[0123456789]+/]
    assert_equal "42", "the number is 42"[/\d+/]
    assert_equal "the number is 42"[/[0123456789]+/], "the number is 42"[/\d+/]
  end

  def test_character_classes_can_include_ranges
    assert_equal "42", "the number is 42"[/[0-9]+/]
  end

  def test_slash_s_is_a_shortcut_for_a_whitespace_character_class
    assert_equal " \t\n", "space: \t\n"[/\s+/]
  end

  def test_slash_w_is_a_shortcut_for_a_word_character_class
    # NOTE:  This is more like how a programmer might define a word.
    assert_equal "variable_1", "variable_1 = 42"[/[a-zA-Z0-9_]+/]
    assert_equal "variable_1", "variable_1 = 42"[/\w+/]
    assert_equal "variable_1 = 42"[/[a-zA-Z0-9_]+/], "variable_1 = 42"[/\w+/]
  end

  def test_period_is_a_shortcut_for_any_non_newline_character
    assert_equal "abc", "abc\n123"[/a.+/]
  end

  def test_a_character_class_can_be_negated
    assert_equal "the number is ", "the number is 42"[/[^0-9]+/] # [^0-9] = negated set -- match any character not in the set
    assert_equal "42", "the number is 42"[/[0-9^]+/] # match 0-9 and ignore everything else
    assert_not_equal "the number is 42"[/[0-9^]+/], "the number is 42"[/[^0-9]+/]
  end

  def test_shortcut_character_classes_are_negated_with_capitals
    assert_equal "the number is ", "the number is 42"[/\D+/] # Matches any character that is not a digit character (0-9). Equivalent to [^0-9].
    assert_equal "space:", "space: \t\n"[/\S+/] # \S = Matches any character that is not a whitespace character (spaces, tabs, line breaks).
    # ... a programmer would most likely do
    assert_equal " = ", "variable_1 = 42"[/[^a-zA-Z0-9_]+/]
    assert_equal " = ", "variable_1 = 42"[/\W+/] # \W = Matches any character that is NOT a word character (alphanumeric & underscore)
    assert_equal "variable_1 = 42"[/[^a-zA-Z0-9_]+/], "variable_1 = 42"[/\W+/]
  end

  # ------------------------------------------------------------------

  # NOTE: ANCHORS are unique in that they match a position within a string, not a character.
  def test_slash_a_anchors_to_the_start_of_the_string
    assert_equal "start", "start end"[/\Astart/]
    assert_equal nil, "start end"[/\Aend/]
  end

  def test_slash_z_anchors_to_the_end_of_the_string
    assert_equal "end", "start end"[/end\z/]
    assert_equal nil, "start end"[/start\z/]
  end

  def test_caret_anchors_to_the_start_of_lines
    assert_equal "2", "num 42\n2 lines"[/^\d+/] # \d Matches any digit character (0-9). Equivalent to [0-9].
    # ^ = Matches the beginning of the string, or the beginning of a line if the multiline flag (m) is enabled. This matches a position, not a character.

  end

  def test_dollar_sign_anchors_to_the_end_of_lines
    assert_equal "42", "2 lines\nnum 42"[/\d+$/]
    # $ = Matches the end of the string, or the end of a line if the multiline flag (m) is enabled. This matches a position, not a character.
  end

  def test_slash_b_anchors_to_a_word_boundary
    assert_equal "vines", "bovine vines"[/\bvine./] # the dot(.) says to look any character after the word boundary, so the space is excluded
    # \b = Matches a word boundary position between a word character and non-word character or position (start / end of string).
    # See the word character class (w) for more info.
  end

  # ------------------------------------------------------------------

  def test_parentheses_group_contents
    assert_equal "hahaha", "ahahaha"[/(ha)+/]
  end
    # () = Groups multiple tokens together and creates a capture group for extracting a substring or using a backreference.
  # ------------------------------------------------------------------

  def test_parentheses_also_capture_matched_content_by_number
    assert_equal "Gray", "Gray, James"[/(\w+), (\w+)/, 1]
    assert_equal "James", "Gray, James"[/(\w+), (\w+)/, 2]
  end

  def test_variables_can_also_be_used_to_access_captures
    assert_equal "Gray, James", "Name:  Gray, James"[/(\w+), (\w+)/] # We captured Gray and James here due to (\w+)
    assert_equal "Gray", $1 # get me the result of the first captured group
    assert_equal "James", $2 # get me the result of the second captured group
    # Capture Group Inserts the results of the specified capture group. For example, $3 would insert the third capture group.
  end

  # ------------------------------------------------------------------

  def test_a_vertical_pipe_means_or
    grays = /(James|Dana|Summer) Gray/
    assert_equal "James Gray", "James Gray"[grays]
    assert_equal "Summer", "Summer Gray"[grays, 1]
    assert_equal nil, "Jim Gray"[grays, 1]
  end

  # THINK ABOUT IT:
  #
  # Explain the difference between a character class ([...]) and alternation (|).
  # Character classes ([...]) are optimized for matching one out of some set of characters -- Optimized
  # Alternatives (x|y|z) allow for more general choices of varying lengths.

  # ------------------------------------------------------------------

  def test_scan_is_like_find_all
    assert_equal ["one", "two", "three"], "one two-three".scan(/\w+/)
  end

  def test_sub_is_like_find_and_replace
    assert_equal "one t-three", "one two-three".sub(/(t\w*)/) { $1[0, 1] } # returns first occurrance of pattern and replaces, in this case i'm onoy returning  t due to the indexes indicated
  end

  def test_gsub_is_like_find_and_replace_all
    assert_equal "one t-t", "one two-three".gsub(/(t\w*)/) { $1[0, 1] } # returns ALL occurrances of pattern
  end
end
