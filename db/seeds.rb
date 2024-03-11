Page.find_or_create_by(internal_identifier: 'mentions-legales') do |page|
    page.name = 'Mentions légales'
    page.path = 'mentions-legales'
end
Page.find_or_create_by(internal_identifier: 'contact') do |page|
    page.name = 'Contact'
    page.path = 'contact'
end
Page.find_or_create_by(internal_identifier: 'boite-a-outils') do |page|
    page.name = 'Boite à outils'
    page.path = 'boite-a-outils'
end
page_lab = Page.find_or_create_by(internal_identifier: 'le-lab') do |page|
    page.name = 'Le Lab'
    page.path = 'le-lab'
end
Page.find_or_create_by(internal_identifier: 'l-association') do |page|
    page.name = "L'association"
    page.path = 'l-association'
    page.parent = page_lab
    page.position = 1
end