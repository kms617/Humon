feature 'user sign up' do
  scenario 'specifying valid and required information' do
    user = FactoryGirl.build(:user)

    visit root_path

    fill_in "Email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Sign up"

    expect(page).to have_content("")
    end

    scenario 'required information is not specified' do
      visit root_path

      click_button "Sign up"

      expect(page).to have_content("prevented your account from being created:")
      expect(page).to have_content("can't be blank")
    end
  end
