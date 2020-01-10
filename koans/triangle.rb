# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  sides = [a, b, c].sort # sort the array
  raise TriangleError, "Sides must be numbers greater than zero" if sides.any? { |side| side <=0 } # a side must have a value > than 0
  raise TriangleError, "No two sides can add to be less than or equal to the other side" unless sides[0] + sides[1] > sides[2] # raise an error if the sum of the first two values in the array is greater than the third value
  sides.uniq! # uniq! remove duplicate values from array | this helps us determine how many sides are of equal value

  if sides.count == 1 # due to uniq!, sides will only have 1 value
    :equilateral
  elsif sides.count == 2 # due to uniq!, sides will only have 2 values
    :isosceles
  else
    :scalene
  end

end

# Another solution I saw online
# raise TriangleError unless a > 0 and a + b > c
# {1 => :equilateral, 2 => :isosceles, 3 => :scalene}[sides.uniq.size]

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
