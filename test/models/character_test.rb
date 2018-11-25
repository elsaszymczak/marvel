require 'test_helper'

class CharacterTest < ActiveSupport::TestCase

  test "visiting the characters indes" do
    visit "/characters"
    assert_selector "h2", text: "CHARACTERS"
  end
  # test "the truth" do
  #   assert true
  # end
end
