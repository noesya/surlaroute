require "test_helper"

class Transparency::RevenuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transparency_revenue = transparency_revenues(:one)
  end

  test "should get index" do
    get transparency_revenues_url
    assert_response :success
  end

  test "should get new" do
    get new_transparency_revenue_url
    assert_response :success
  end

  test "should create transparency_revenue" do
    assert_difference("Transparency::Revenue.count") do
      post transparency_revenues_url, params: { transparency_revenue: { amount: @transparency_revenue.amount, description: @transparency_revenue.description, title: @transparency_revenue.title, year_id: @transparency_revenue.year_id } }
    end

    assert_redirected_to transparency_revenue_url(Transparency::Revenue.last)
  end

  test "should show transparency_revenue" do
    get transparency_revenue_url(@transparency_revenue)
    assert_response :success
  end

  test "should get edit" do
    get edit_transparency_revenue_url(@transparency_revenue)
    assert_response :success
  end

  test "should update transparency_revenue" do
    patch transparency_revenue_url(@transparency_revenue), params: { transparency_revenue: { amount: @transparency_revenue.amount, description: @transparency_revenue.description, title: @transparency_revenue.title, year_id: @transparency_revenue.year_id } }
    assert_redirected_to transparency_revenue_url(@transparency_revenue)
  end

  test "should destroy transparency_revenue" do
    assert_difference("Transparency::Revenue.count", -1) do
      delete transparency_revenue_url(@transparency_revenue)
    end

    assert_redirected_to transparency_revenues_url
  end
end
