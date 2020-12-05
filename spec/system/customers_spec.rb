require 'rails_helper'

describe 'カスタマー認証のテスト' do
  describe 'カスタマー新規登録' do
    before do
      visit new_customer_registration_path
    end
    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'customer[name]', with: Faker::Internet.customername(specifier: 6)
        fill_in 'customer[email]', with: Faker::Internet.email
        fill_in 'customer[password]', with: 'password'
        fill_in 'customer[password_confirmation]', with: 'password'
        click_button '新規登録する'

        expect(page).to have_content 'ようこそ！ アカウントが登録されました'
      end
      it '新規登録に失敗する' do
        fill_in 'user[name]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button '新規登録する'

        expect(page).to have_content 'error'
      end
    end
  end

  describe 'カスタマーログイン' do
    let(:customer) { create(:customer) }
    before do
      visit new_customer_session_path
    end
    context 'ログイン画面に遷移' do
      let(:test_customer) { customer }
      it 'ログインに成功する' do
        fill_in 'customer[mail]', with: test_customer.name
        fill_in 'customer[password]', with: test_customer.password
        click_button 'ログイン'

        expect(page).to have_content 'ログインしました。'
      end

      it 'ログインに失敗する' do
        fill_in 'customer[mail]', with: ''
        fill_in 'customer[password]', with: ''
        click_button 'ログイン'

        expect(current_path).to eq(new_customer_session_path)
      end
    end
  end
end

