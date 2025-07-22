require "application_system_test_case"

class DelegationsTest < ApplicationSystemTestCase
  setup do
    @delegation = delegations(:one)
  end

  test "visiting the index" do
    visit delegations_url
    assert_selector "h1", text: "Delegations"
  end

  test "should create delegation" do
    visit delegations_url
    click_on "New delegation"

    fill_in "Name", with: @delegation.name
    click_on "Create Delegation"

    assert_text "Delegation was successfully created"
    click_on "Back"
  end

  test "should update Delegation" do
    visit delegation_url(@delegation)
    click_on "Edit this delegation", match: :first

    fill_in "Name", with: @delegation.name
    click_on "Update Delegation"

    assert_text "Delegation was successfully updated"
    click_on "Back"
  end

  test "should destroy Delegation" do
    visit delegation_url(@delegation)
    accept_confirm { click_on "Destroy this delegation", match: :first }

    assert_text "Delegation was successfully destroyed"
  end
end
