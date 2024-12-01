require "application_system_test_case"

class LunchesTest < ApplicationSystemTestCase
  setup do
    @lunch = lunches(:one)
  end

  test "visiting the index" do
    visit lunches_url
    assert_selector "h1", text: "Lunches"
  end

  test "should create lunch" do
    visit lunches_url
    click_on "New lunch"

    fill_in "Participant", with: @lunch.participant_id
    fill_in "User", with: @lunch.user_id
    click_on "Create Lunch"

    assert_text "Lunch was successfully created"
    click_on "Back"
  end

  test "should update Lunch" do
    visit lunch_url(@lunch)
    click_on "Edit this lunch", match: :first

    fill_in "Participant", with: @lunch.participant_id
    fill_in "User", with: @lunch.user_id
    click_on "Update Lunch"

    assert_text "Lunch was successfully updated"
    click_on "Back"
  end

  test "should destroy Lunch" do
    visit lunch_url(@lunch)
    click_on "Destroy this lunch", match: :first

    assert_text "Lunch was successfully destroyed"
  end
end
