def current_user
  $current_user
  # p Capybara.current_session.driver.cookies
  # @current_user ||= User.find(Capybara.current_session.driver.cookies["stub_user_id"].value.to_i) if Capybara.current_session.driver.cookies["stub_user_id"]
end

Допустим(/^Я \- гость$/) do
  expect(current_user).to be_falsey
end

Допустим(/^Я \- пользователь, который не состоит в группе "(.*?)"$/) do |ecompetences_users_group|
  user = User.create(
      login: "no_access",
      password: "password",
      password_confirmation: "password",
      first_name: "Test",
      last_name: "User"
  )
  # page.driver.set_cookie(:stub_user_id, user.id)
  $current_user = user
  expect(user.groups.collect {|group| group.name}).not_to be_include(ecompetences_users_group)
end

Допустим(/^Я \- типичный пользователь, который состоит в группе "(.*?)" и не состоит в группе "(.*?)"$/) do |ecompetences_users, ecompetences_admins|
  user = User.create(
      login: "typical_user",
      password: "password",
      password_confirmation: "password",
      first_name: "Test",
      last_name: "User"
  )
  user.groups.create(name: "ECOMPETENCES_USERS")
  $current_user = user
  expect(user.groups.collect { |group| group.name }).to be_include(ecompetences_users)
  expect(user.groups.collect { |group| group.name }).not_to be_include(ecompetences_admins)
end

Допустим(/^Я \- администратор, который состоит в группах "(.*?)" и "(.*?)"$/) do |users_group, admins_group|
  user = User.create(
      login: "admin",
      password: "password",
      password_confirmation: "password",
      first_name: "Test",
      last_name: "User"
  )
  user.groups.create([{name: "ECOMPETENCES_USERS"}, {name: "ECOMPETENCES_ADMINS"}])
  $current_user = user
  expect(user.groups.collect { |group| group.name }).to be_include(users_group)
  expect(user.groups.collect { |group| group.name }).to be_include(admins_group)
end

Когда(/^Я захожу на главную страницу системы$/) do
  visit root_path
end

Тогда(/^Я вижу ссылку "(.*?)"$/) do |link_text|
  expect(page.find("nav.navbar")).to have_selector("a.navbar-brand", text: link_text)
end

Тогда(/^Я вижу кнопку авторизации "(.*?)"$/) do |signin_btn_text|
  expect(page.find("nav.navbar")).to have_selector("a.btn-default[type=button]", text: signin_btn_text)
end

Тогда(/^Я не вижу ни одного пункта меню$/) do
  lis = page.all("nav.navbar ul.nav.navbar-nav li")
  expect(lis.count).to be_eql(0)
end

Тогда(/^Я вижу кнопку выхода "(.*?)"$/) do |logout_btn_text|
  save_screenshot "screen.png"
  expect(page.find("nav.navbar")).to have_selector("a.btn-danger[type=button]", text: logout_btn_text)
end

Тогда(/^Я вижу текст$/) do |no_access_text|
  expect(page).to have_content(no_access_text)
end

Тогда(/^Я вижу пункты меню "([^"]*)"$/) do |menu_punkts|
  punkts = menu_punkts.split(", ").sort
  lis = page.all("nav.navbar ul.nav.navbar-nav li").map {|li| li.text}.sort
  expect(page.all("nav.navbar ul.nav.navbar-nav li").count).to be_eql(3)
  expect(lis).to be_eql(punkts)
end

Тогда(/^Я вижу пункты меню "(.*?)" с подпунктом "(.*?)"$/) do |menu_punkts, admin_menu|
  pending
end