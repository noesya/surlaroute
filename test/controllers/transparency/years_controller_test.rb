require "test_helper"

class Transparency::YearsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transparency_year = transparency_years(:one)
  end

  test "should get index" do
    get transparency_years_url
    assert_response :success
  end

  test "should get new" do
    get new_transparency_year_url
    assert_response :success
  end

  test "should create transparency_year" do
    assert_difference("Transparency::Year.count") do
      post transparency_years_url, params: { transparency_year: { value: @transparency_year.value } }
    end

    assert_redirected_to transparency_year_url(Transparency::Year.last)
  end

  test "should show transparency_year" do
    get transparency_year_url(@transparency_year)
    assert_response :success
  end

  test "should get edit" do
    get edit_transparency_year_url(@transparency_year)
    assert_response :success
  end

  test "should update transparency_year" do
    patch transparency_year_url(@transparency_year), params: { transparency_year: { value: @transparency_year.value } }
    assert_redirected_to transparency_year_url(@transparency_year)
  end

  test "should destroy transparency_year" do
    assert_difference("Transparency::Year.count", -1) do
      delete transparency_year_url(@transparency_year)
    end

    assert_redirected_to transparency_years_url
  end
end
