require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nickname、email、passwordとpassword_confirmation、氏名、氏名のかな、生年月日が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'hoge.hoge'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが全角文字を含むと登録できない' do
        @user.password = 'a１１１１１'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには半角英字と半角字の両方を含めて設定してください")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'a1111'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it 'passwordが英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには半角英字と半角字の両方を含めて設定してください")
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには半角英字と半角字の両方を含めて設定してください")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'a11111'
        @user.password_confirmation = 'a22222'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it '名字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(姓)を入力してください")
      end
      it '名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(名)を入力してください")
      end
      it '名字が半角では登録できない' do
        @user.last_name = 'ﾐｮｳｼﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(姓)には全角ひらがな、カタカナ、漢字を使用してください")
      end
      it '名前が半角では登録できない' do
        @user.first_name = 'ﾅﾏｴ'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(名)には全角ひらがな、カタカナ、漢字を使用してください")
      end
      it '名字が英字では登録できない' do
        @user.last_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(姓)には全角ひらがな、カタカナ、漢字を使用してください")
      end
      it '名前が英字では登録できない' do
        @user.first_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(名)には全角ひらがな、カタカナ、漢字を使用してください")
      end
      it '名字が数字では登録できない' do
        @user.last_name = '1'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(姓)には全角ひらがな、カタカナ、漢字を使用してください")
      end
      it '名前が数字では登録できない' do
        @user.first_name = '1'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(名)には全角ひらがな、カタカナ、漢字を使用してください")
      end
      it '名字のかなが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(姓)を入力してください")
      end
      it '名前のかなが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(名)を入力してください")
      end
      it '名字のかなが半角では登録できない' do
        @user.last_name_kana = 'ｶﾅ'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(姓)には全角カタカナを使用してください")
      end
      it '名前のかなが半角では登録できない' do
        @user.first_name_kana = 'ｶﾅ'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(名)には全角カタカナを使用してください")
      end
      it '名字のかながひらがなでは登録できない' do
        @user.last_name_kana = 'かな'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(姓)には全角カタカナを使用してください")
      end
      it '名前のかながひらがなでは登録できない' do
        @user.first_name_kana = 'かな'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(名)には全角カタカナを使用してください")
      end
      it '名字のかなが英字では登録できない' do
        @user.last_name_kana = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(姓)には全角カタカナを使用してください")
      end
      it '名前のかなが英字では登録できない' do
        @user.first_name_kana = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(名)には全角カタカナを使用してください")
      end
      it '名字のかなが数字では登録できない' do
        @user.last_name_kana = '11111'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(姓)には全角カタカナを使用してください")
      end
      it '名前のかなが数字では登録できない' do
        @user.first_name_kana = '11111'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(名)には全角カタカナを使用してください")
      end
      it '生年月日が空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
