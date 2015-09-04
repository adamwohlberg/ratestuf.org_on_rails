require 'test_helper'

class ItemFactoryTest < ActiveSupport::TestCase
  test 'item factory creates a new item' do
    ItemFactory.create!('delta')
    assert_equal 1, Item.count
  end

  test 'item factory will create multiple items' do
    ItemFactory.create!('delta vs. southwest')
    assert_equal 2, Item.count
  end

  test 'that tokenize' do
    tokens = ItemFactory.new('delta vs. southwest').tokenize
    assert_equal 2, tokens.size
    assert_equal 'delta', tokens[0]
    assert_equal 'southwest', tokens[1]
  end
end
