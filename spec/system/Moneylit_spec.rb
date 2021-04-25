require 'rails_helper'

describe '経費管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      # ユーザーAを作成しておく
      user_a = FactoryBot.create(:user, screen_name: 'ユーザーA', email: 'a@example.com', friendly_url: generate_friendly_url)
      # 作成者がユーザーAである経費を作成しておく
      FactoryBot.create(:expense, name: '最初の経費', paid_at: Time.now, user_id: user_a.id,friendly_url: generate_friendly_url)
    end
    context 'ユーザーAがログインしている時' do
      before do
        # ユーザーAでログインする
        visit login_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password'
        click_button

        # グループ「テストグループ」を作成する
        find('.btn.btn-secondary').click
        fill_in 'グループ名', with: 'テストグループ'
        click_button '保存する'
      end

      it '作成した「テストグループ」が表示されている' do
        expect(page).to have_content 'テストグループ'
      end

      it 'グループを選択することが出来る' do
        click_link 'テストグループ'
        expect(page).to have_content "#{Date.today.strftime("%Y年%m月")}"
      end

    end
  end
end

# friendly_urlの生成メソッド
def generate_friendly_url
  char_list = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
  (0...8).map { char_list[rand(char_list.length)] }.join
end