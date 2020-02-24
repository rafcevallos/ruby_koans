require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the number.
#  (e.g. three fives is 500 points)
#
# * A one (that is not part of a set of three) is worth 100 points.
#  so if you roll three fives and the fourth dice is one, you'll score 600 points on this roll
#
# * A five (that is not part of a set of three) is worth 50 points.
#  so if you roll three fours and the fourth dice is five, you'll score 450 points on this roll
#
# * Everything else is worth 0 points.
#  so if you roll three fours and the fourth dice is five and the last die is a 6, you'll score 450 points on this roll
#  so if you roll three fours and the fourth dice is five and the last die is a 1, you'll score 550 points on this roll
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points (any die that is a 1 and not    a part of a set is still 100 points)
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

def score(dice)
  # You need to write this method
  # from https://gist.github.com/markjaquith/a440b838d49c2223b944

  myscore = 0
  # die values                1    2    3    4    5    6
  triple_scoremap = [ nil, 1000, 200, 300, 400, 500, 600 ]
  single_scoremap = [ nil,  100,   0,   0,   0,  50,   0 ]
  if dice.length > 2
    (1..6).each do |num|
      if dice.count(num) > 2
        myscore += triple_scoremap[num]
        3.times { dice.delete_at( dice.index(num) ) }
        break
      end
    end
  end
  dice.each do |num|
    myscore += single_scoremap[num]
  end
  return myscore
end

class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
    assert_equal 1100, score([1,1,1,1])
    assert_equal 1200, score([1,1,1,1,1])
    assert_equal 1150, score([1,1,1,5,1])
  end

end
