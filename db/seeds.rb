Refinery::User.all.each do |user|
  if user.plugins.where(:name => 'refinerycms_newsletter').blank?
    user.plugins.create(:name => "refinerycms_newsletter",
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end if defined?(Refinery::User)

if defined?(Refinery::Page) and !Refinery::Page.exists?(:link_url => '/newsletter')
  page = Refinery::Page.create(
    :title => "Newsletter",
    :link_url => "/newsletter",
    :deletable => false,
    :menu_match => "^/newsletters?(\/|\/.+?|)$"
  )

  Refinery::Pages.default_parts.each do |default_page_part|
    page.parts.create(:title => default_page_part, :body => nil)
  end
end
