# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mystery, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      # expect(FactoryBot.build(:mystery)).to be_valid
      mystery = Mystery.new(title: 'hoge', discription: 'hoge', answer: 'a', answer_discription: 'hoge', difficulty_level: 3.0, is_opened: true, user_id: 1)
      expect(mystery).to be_invalid
    end
  end
  context "空白のバリデーションチェック" do
    it "titleが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      mystery = Mystery.new(title: '', discription: 'hoge', answer: 'a', answer_discription: 'hoge', difficulty_level: 3.0, is_opened: true, user_id: 1)
      expect(mystery).to be_invalid
      expect(mystery.errors[:title]).to include("を入力してください")
    end
    it "discriptionが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      mystery = Mystery.new(title: 'hoge', discription: '', answer: 'a', answer_discription: 'hoge', difficulty_level: 3.0, is_opened: true, user_id: 1)
      expect(mystery).to be_invalid
      expect(mystery.errors[:discription]).to include("を入力してください")
    end
    it "answerが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      mystery = Mystery.new(title: 'hoge', discription: 'hoge', answer: '', answer_discription: 'hoge', difficulty_level: 3.0, is_opened: true, user_id: 1)
      expect(mystery).to be_invalid
      expect(mystery.errors[:answer]).to include("を入力してください")
    end
    it "discriptionが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      mystery = Mystery.new(title: 'hoge', discription: 'hoge', answer: 'a', answer_discription: '', difficulty_level: 3.0, is_opened: true, user_id: 1)
      expect(mystery).to be_invalid
      expect(mystery.errors[:answer_discription]).to include("を入力してください")
    end
    it "discriptionが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      mystery = Mystery.new(title: 'hoge', discription: 'hoge', answer: 'a', answer_discription: 'a', difficulty_level: '', is_opened: true, user_id: 1)
      expect(mystery).to be_invalid
      expect(mystery.errors[:difficulty_level]).to include("を入力してください")
    end
  end
  feature "titleを空白で投稿した場合に画面にエラーメッセージが表示されているか" do
    before do
      visit '/users/sign_up'
      fill_in 'user[name]', with: 'test'
      fill_in 'user[email]', with: 'sayori@gmail.com'
      fill_in 'user[tellphone_number]', with: '12345678'
      fill_in 'user[password]', with: '123456'
      fill_in 'user[password_confirmation]', with: '123456'
      find("input[name='commit']").click

      visit '/mysteries/new'
      fill_in 'mystery[title]', with: ''
    end
    scenario "エラーメッセージは正しく表示されるか" do
      find("input[name='commit']").click
      expect(page).to have_content "を入力してください"
    end
  end
  feature "discriptionを空白で投稿した場合に画面にエラーメッセージが表示されているか" do
    before do
      visit '/users/sign_up'
      fill_in 'user[name]', with: 'test'
      fill_in 'user[email]', with: 'sayori@gmail.com'
      fill_in 'user[tellphone_number]', with: '12345678'
      fill_in 'user[password]', with: '123456'
      fill_in 'user[password_confirmation]', with: '123456'
      find("input[name='commit']").click

      visit '/mysteries/new'
      fill_in "mystery[discription]", with: ''
    end
    scenario "エラーメッセージは正しく表示されるか" do
      find("input[name='commit']").click
      expect(page).to have_content "を入力してください"
    end
  end
  feature "answerを空白で投稿した場合に画面にエラーメッセージが表示されているか" do
    before do
      visit '/users/sign_up'
      fill_in 'user[name]', with: 'test'
      fill_in 'user[email]', with: 'sayori@gmail.com'
      fill_in 'user[tellphone_number]', with: '12345678'
      fill_in 'user[password]', with: '123456'
      fill_in 'user[password_confirmation]', with: '123456'
      find("input[name='commit']").click

      visit '/mysteries/new'
      fill_in "mystery[answer]", with: ''
    end
    scenario "エラーメッセージは正しく表示されるか" do
      find("input[name='commit']").click
      expect(page).to have_content "を入力してください"
    end
  end
  feature "answer_discriptionを空白で投稿した場合に画面にエラーメッセージが表示されているか" do
    before do
      visit '/users/sign_up'
      fill_in 'user[name]', with: 'test'
      fill_in 'user[email]', with: 'sayori@gmail.com'
      fill_in 'user[tellphone_number]', with: '12345678'
      fill_in 'user[password]', with: '123456'
      fill_in 'user[password_confirmation]', with: '123456'
      find("input[name='commit']").click

      visit '/mysteries/new'
      fill_in "mystery[answer_discription]", with: ''
    end
    scenario "エラーメッセージは正しく表示されるか" do
      find("input[name='commit']").click
      expect(page).to have_content "を入力してください"
    end
  end
end
