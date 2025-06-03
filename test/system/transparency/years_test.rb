require "application_system_test_case"

class Transparency::YearsTest < ApplicationSystemTestCase
  setup do
    @transparency_year = transparency_years(:one)
  end

  test "visiting the index" do
    visit transparency_years_url
    assert_selector "h1", text: "Years"
  end

  test "should create year" do
    visit transparency_years_url
    click_on "New year"

    fill_in "Value", with: @transparency_year.value
    click_on "Create Year"

    assert_text "Year was successfully created"
    click_on "Back"
  end

  test "should update Year" do
    visit transparency_year_url(@transparency_year)
    click_on "Edit this year", match: :first

    fill_in "Value", with: @transparency_year.value
    click_on "Update Year"

    assert_text "Year was successfully updated"
    click_on "Back"
  end

  test "should destroy Year" do
    visit transparency_year_url(@transparency_year)
    click_on "Destroy this year", match: :first

    assert_text "Year was successfully destroyed"
  end
end
