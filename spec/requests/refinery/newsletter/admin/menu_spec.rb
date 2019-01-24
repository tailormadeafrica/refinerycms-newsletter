require 'spec_helper'

describe "Newsletter menu entry" do
  login_refinery_user

  it "is highlighted when managing the newsletter" do
    visit refinery.admin_root_path

    within("#menu") { click_link "Newsletter" }

    page.should have_css("a.active", :text => "Newsletter")
  end
end
