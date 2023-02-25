require "application_system_test_case"

class TestmpsTest < ApplicationSystemTestCase
  setup do
    @testmp = testmps(:one)
  end

  test "visiting the index" do
    visit testmps_url
    assert_selector "h1", text: "Testmps"
  end

  test "should create testmp" do
    visit testmps_url
    click_on "New testmp"

    click_on "Create Testmp"

    assert_text "Testmp was successfully created"
    click_on "Back"
  end

  test "should update Testmp" do
    visit testmp_url(@testmp)
    click_on "Edit this testmp", match: :first

    click_on "Update Testmp"

    assert_text "Testmp was successfully updated"
    click_on "Back"
  end

  test "should destroy Testmp" do
    visit testmp_url(@testmp)
    click_on "Destroy this testmp", match: :first

    assert_text "Testmp was successfully destroyed"
  end
end
