require "application_system_test_case"

class Transparency::RevenuesTest < ApplicationSystemTestCase
  setup do
    @transparency_revenue = transparency_revenues(:one)
  end

  test "visiting the index" do
    visit transparency_revenues_url
    assert_selector "h1", text: "Revenues"
  end

  test "should create revenue" do
    visit transparency_revenues_url
    click_on "New revenue"

    fill_in "Amount", with: @transparency_revenue.amount
    fill_in "Description", with: @transparency_revenue.description
    fill_in "Title", with: @transparency_revenue.title
    fill_in "Year", with: @transparency_revenue.year_id
    click_on "Create Revenue"

    assert_text "Revenue was successfully created"
    click_on "Back"
  end

  test "should update Revenue" do
    visit transparency_revenue_url(@transparency_revenue)
    click_on "Edit this revenue", match: :first

    fill_in "Amount", with: @transparency_revenue.amount
    fill_in "Description", with: @transparency_revenue.description
    fill_in "Title", with: @transparency_revenue.title
    fill_in "Year", with: @transparency_revenue.year_id
    click_on "Update Revenue"

    assert_text "Revenue was successfully updated"
    click_on "Back"
  end

  test "should destroy Revenue" do
    visit transparency_revenue_url(@transparency_revenue)
    click_on "Destroy this revenue", match: :first

    assert_text "Revenue was successfully destroyed"
  end
end
