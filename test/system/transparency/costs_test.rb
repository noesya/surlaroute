require "application_system_test_case"

class Transparency::CostsTest < ApplicationSystemTestCase
  setup do
    @transparency_cost = transparency_costs(:one)
  end

  test "visiting the index" do
    visit transparency_costs_url
    assert_selector "h1", text: "Costs"
  end

  test "should create cost" do
    visit transparency_costs_url
    click_on "New cost"

    fill_in "Amount", with: @transparency_cost.amount
    fill_in "Description", with: @transparency_cost.description
    fill_in "Title", with: @transparency_cost.title
    fill_in "Year", with: @transparency_cost.year_id
    click_on "Create Cost"

    assert_text "Cost was successfully created"
    click_on "Back"
  end

  test "should update Cost" do
    visit transparency_cost_url(@transparency_cost)
    click_on "Edit this cost", match: :first

    fill_in "Amount", with: @transparency_cost.amount
    fill_in "Description", with: @transparency_cost.description
    fill_in "Title", with: @transparency_cost.title
    fill_in "Year", with: @transparency_cost.year_id
    click_on "Update Cost"

    assert_text "Cost was successfully updated"
    click_on "Back"
  end

  test "should destroy Cost" do
    visit transparency_cost_url(@transparency_cost)
    click_on "Destroy this cost", match: :first

    assert_text "Cost was successfully destroyed"
  end
end
