require "test_helper"

class Transparency::CostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transparency_cost = transparency_costs(:one)
  end

  test "should get index" do
    get transparency_costs_url
    assert_response :success
  end

  test "should get new" do
    get new_transparency_cost_url
    assert_response :success
  end

  test "should create transparency_cost" do
    assert_difference("Transparency::Cost.count") do
      post transparency_costs_url, params: { transparency_cost: { amount: @transparency_cost.amount, description: @transparency_cost.description, title: @transparency_cost.title, year_id: @transparency_cost.year_id } }
    end

    assert_redirected_to transparency_cost_url(Transparency::Cost.last)
  end

  test "should show transparency_cost" do
    get transparency_cost_url(@transparency_cost)
    assert_response :success
  end

  test "should get edit" do
    get edit_transparency_cost_url(@transparency_cost)
    assert_response :success
  end

  test "should update transparency_cost" do
    patch transparency_cost_url(@transparency_cost), params: { transparency_cost: { amount: @transparency_cost.amount, description: @transparency_cost.description, title: @transparency_cost.title, year_id: @transparency_cost.year_id } }
    assert_redirected_to transparency_cost_url(@transparency_cost)
  end

  test "should destroy transparency_cost" do
    assert_difference("Transparency::Cost.count", -1) do
      delete transparency_cost_url(@transparency_cost)
    end

    assert_redirected_to transparency_costs_url
  end
end
