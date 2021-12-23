require 'rails_helper'

describe '投稿のテスト' do
  before do
    visit '/users/sign_up'
    fill_in 'user[name]', with: 'test'
    fill_in 'user[email]', with: 'sayori@gmail.com'
    fill_in 'user[tellphone_number]', with: '12345678'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    find("input[name='commit']").click
  end
  let!(:mystery) { create(:mystery, title: 'hoge', discription: 'body', answer: 'hoge', answer_discription: 'hoge', difficulty_level: 3.0, is_opened: true, user_id: 1) }
  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面(root_path)に一覧ページへのリンクが表示されているか' do
        expect(page).to have_link "", href: mysteries_path
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end
  describe "一覧画面のテスト" do
    before do
      visit mysteries_path
    end
    context '一覧の表示とリンクの確認' do
      it "mysteryの一覧表示がされているか" do
        expect(page).to have_selector '.card'
      end
      it "mysteryのタイトルを表示し、詳細のリンクが表示されているか" do
        (1..5).each do |i|
          Mystery.create(
            title: "hoge#{i}.to_s",
            discription: "body#{i}.to_s",
            answer: "answer#{i}.to_s",
            answer_discription: "answerbody#{i}.to_s",
            difficulty_level: 1.0,
            is_opened: true,
            user_id: 1
          )
        end
        visit mysteries_path
        Mystery.all.each_with_index do |mystery, i|
          # ヘッダーとロゴのリンク数、投稿の順序から逆算
          j = 10 - i
          expect(page).to have_content mystery.title
          show_link = find_all('a')[j]
          expect(show_link[:href]).to eq mystery_path(mystery)
        end
      end
    end
    context '投稿処理に関するテスト' do
      before do
        visit new_mystery_path
      end
      it '投稿に成功しサクセスメッセージが表示されるか' do
        fill_in 'mystery[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'mystery[discription]', with: Faker::Lorem.characters(number: 20)
        fill_in 'mystery[answer]', with: Faker::Lorem.characters(number: 5)
        fill_in 'mystery[answer_discription]', with: Faker::Lorem.characters(number: 20)
        find('#difficulty_level').click
        click_button '作成'
        expect(page).to have_content '投稿'
      end
      it '投稿に失敗する' do
        click_button '作成'
        expect(page).to have_content 'エラー'
        expect(current_path).to eq('/mysteries')
      end
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'mystery[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'mystery[discription]', with: Faker::Lorem.characters(number: 20)
        fill_in 'mystery[answer]', with: Faker::Lorem.characters(number: 5)
        fill_in 'mystery[answer_discription]', with: Faker::Lorem.characters(number: 20)
        find('#difficulty_level').click
        click_button '作成'
        expect(page).to have_current_path mystery_path(Mystery.last)
      end
    end
    context '削除のテスト' do
      it 'mysteryの削除' do
        expect { mystery.destroy }.to change { Mystery.count }.by(-1)
      end
    end
  end
  describe '詳細画面のテスト' do
    before do
      visit mystery_path(mystery)
    end
    context '表示の確認' do
      it '本のタイトルと感想が画面に表示されていること' do
        expect(page).to have_content mystery.title
        expect(page).to have_content mystery.discription
      end
    end
    context 'リンクの遷移先の確認' do
      it 'Editの遷移先は編集画面か' do
        edit_link = find_all('a')[5]
        edit_link.click
        expect(current_path).to eq("/mysteries/#{mystery.id}.to_s/edit")
      end
    end
  end
  describe '編集画面のテスト' do
    before do
      visit edit_mystery_path(mystery)
    end
    context '表示の確認' do
      it '編集前のタイトルと感想がフォームに表示(セット)されている' do
        expect(page).to have_field 'mystery[title]', with: mystery.title
        expect(page).to have_field 'mystery[discription]', with: mystery.discription
        expect(page).to have_field 'mystery[answer]', with: mystery.answer
        expect(page).to have_field 'mystery[answer_discription]', with: mystery.answer_discription
      end
      it '更新ボタンが表示される' do
        expect(page).to have_button '更新！'
      end
    end
    context '更新処理に関するテスト' do
      it '更新に成功しサクセスメッセージが表示されるか' do
        fill_in 'mystery[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'mystery[discription]', with: Faker::Lorem.characters(number: 20)
        fill_in 'mystery[answer]', with: Faker::Lorem.characters(number: 5)
        fill_in 'mystery[answer_discription]', with: Faker::Lorem.characters(number: 20)
        find('#difficulty_level').click
        click_button '更新！'
        expect(page).to have_content '更新'
      end
      it '更新に失敗しエラーメッセージが表示されるか' do
        fill_in 'mystery[title]', with: ""
        fill_in 'mystery[discription]', with: ""
        fill_in 'mystery[answer]', with: ""
        fill_in 'mystery[answer_discription]', with: ""
        click_button '更新！'
        expect(page).to have_content 'エラー'
      end
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'mystery[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'mystery[discription]', with: Faker::Lorem.characters(number: 20)
        fill_in 'mystery[answer]', with: Faker::Lorem.characters(number: 5)
        fill_in 'mystery[answer_discription]', with: Faker::Lorem.characters(number: 20)
        find('#difficulty_level').click
        click_button '更新！'
        expect(page).to have_current_path mystery_path(mystery)
      end
    end
  end
end
