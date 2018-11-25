require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit events_url
  #
  #   assert_selector "h1", text: "Event"
  # end

  test "visiting the index" do
    visit "/"
    assert_selector "h1", text: "THE BEST OF MARVEL"
  end
end
