def current_user
  $current_user
  # p Capybara.current_session.driver.cookies
  # @current_user ||= User.find(Capybara.current_session.driver.cookies["stub_user_id"].value.to_i) if Capybara.current_session.driver.cookies["stub_user_id"]
end

Допустим(/^Я \- гость$/) do
  expect(current_user).to be_falsey
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

Допустим(/^Я \- пользователь, который не состоит в группе "(.*?)"$/) do |ecompetences_users_group|
  user = User.create(
      login: "no_access",
      password: "password",
      password_confirmation: "password",
      first_name: "Test",
      last_name: "User"
  )
  # page.driver.set_cookie(:stub_user_id, user.id)
  $current_user = user.id
  expect(user.groups.collect {|group| group.name}).not_to be_include(ecompetences_users_group)
end

Тогда(/^Я вижу кнопку выхода "(.*?)"$/) do |logout_btn_text|
  save_screenshot "screen.png"
  expect(page.find("nav.navbar")).to have_selector("a.btn-danger[type=button]", text: logout_btn_text)
end