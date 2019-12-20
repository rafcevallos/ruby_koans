require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutObjects < Neo::Koan
  def test_everything_is_an_object
    assert_equal true, 1.is_a?(Object)
    assert_equal true, 1.5.is_a?(Object)
    assert_equal true, "string".is_a?(Object)
    assert_equal true, nil.is_a?(Object)
    assert_equal true, Object.is_a?(Object)
  end

  def test_objects_can_be_converted_to_strings
    assert_equal "123", 123.to_s  # convert an integer to a string and assert it is equal a string
    assert_equal "", nil.to_s  # convert nil to a string and compare to an empty string
  end

  def test_objects_can_be_inspected
    assert_equal "123", 123.inspect # Inspect returns a string representation of an object
    assert_equal "nil", nil.inspect
  end

  def test_every_object_has_an_id
    obj = Object.new  # creates a new object
    assert_equal Fixnum, obj.object_id.class  # object_id returns an integer identifier
  end

  def test_every_object_has_different_id
    obj = Object.new
    another_obj = Object.new
    assert_equal true, obj.object_id != another_obj.object_id
  end

  def test_small_integers_have_fixed_ids  # run these in ruby to see the fixed ids
    assert_equal 1, 0.object_id
    assert_equal 3, 1.object_id
    assert_equal 5, 2.object_id
    assert_equal 201, 100.object_id

    # THINK ABOUT IT:
    # What pattern do the object IDs for small integers follow?
    # They are odd numbers sequentially
  end

  def test_clone_creates_a_different_object
    obj = Object.new
    copy = obj.clone # clone creates a shallow copy of an objects state at time of cloning -- different object_id

    assert_equal true, obj != copy
    assert_equal true, obj.object_id != copy.object_id
  end
end
