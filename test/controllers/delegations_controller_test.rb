require "test_helper"

class DelegationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @delegation = delegations(:one)
  end

  test "should get index" do
    get delegations_url
    assert_response :success
  end

  test "should get new" do
    get new_delegation_url
    assert_response :success
  end

  test "should create delegation" do
    assert_difference("Delegation.count") do
      post delegations_url, params: { delegation: { name: @delegation.name } }
    end

    assert_redirected_to delegation_url(Delegation.last)
  end

  test "should show delegation" do
    get delegation_url(@delegation)
    assert_response :success
  end

  test "should get edit" do
    get edit_delegation_url(@delegation)
    assert_response :success
  end

  test "should update delegation" do
    patch delegation_url(@delegation), params: { delegation: { name: @delegation.name } }
    assert_redirected_to delegation_url(@delegation)
  end

  test "should destroy delegation" do
    assert_difference("Delegation.count", -1) do
      delete delegation_url(@delegation)
    end

    assert_redirected_to delegations_url
  end
end
