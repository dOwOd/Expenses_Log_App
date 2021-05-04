require 'rails_helper'

describe '経費管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      # ユーザーAを作成しておく
      user_a = FactoryBot.create(:user, screen_name: 'ユーザーA', email: 'a@example.com', friendly_url: generate_friendly_url)
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
        selected_group
        expect(page).to have_content "#{Date.today.strftime("%Y年%m月")}"
      end

      it '経費の作成ができて表示がされる' do
        selected_group
        create_expense
        expect(page).to have_content '最初の経費'
      end
      
    end

    # グループの選択
    def selected_group
      click_link 'テストグループ'
    end

    # 経費の作成
    def create_expense
      selected_group
      find('div.selectDate a.btn.btn-outline-secondary').click
      fill_in '名前', with: '最初の経費'
      fill_in '費用', with: '5000'
      fill_in 'expense[description]', with: 'hoge'
      click_button '登録する'
    end
  end
end

# friendly_urlの生成メソッド
def generate_friendly_url
  char_list = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
  (0...8).map { char_list[rand(char_list.length)] }.join
end