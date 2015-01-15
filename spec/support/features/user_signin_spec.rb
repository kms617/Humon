feature 'user signs in', focus: true do

  scenario 'an existing user specifies a valid email and password' do
    user = create(:user)
    sign_in_as_user

    # fill_in "Email", with: user.email
    # fill_in "Password", with: user.password
    # click_button "Sign in"
    #
    # expect(page).to have_content ("Signed in successfully.")
    # expect(page).to have_content ("Sign Out")
    # expect(page).to_not have_content ("Sign In")
  end

  scenario 'a user specifies invalid email and password' do
    visit root_path

    fill_in "Email", with: "foo@foobar.com"
    fill_in "Password", with: "foobar"
    click_button "Sign in"

    expect(page).to have_content ("Invalid email address or password.")
  end

  scenario 'existing email with the wrong password is denied access' do
    user = FactoryGirl.create(:user)
    visit root_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "foobar"
    click_button "Sign in"

    expect(page).to have_content ("Invalid email or password.")
  end
end


# feature "A feature spec" do
#   scenario "that requires login" do
#     user = create(:user)
#     sign_in(user)
#     # do something
#     sign_out
#     # do something else
#   end
# end
