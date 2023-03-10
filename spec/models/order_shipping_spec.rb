require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  describe '発送先情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('public/images/test_image.png')
      @item.save
      @order_shipping = FactoryBot.build(:order_shipping, user_id: @user.id, item_id: @item.id)
      sleep(0.5)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_shipping).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @order_shipping.building = ""
        expect(@order_shipping).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it "tokenが空では登録できない" do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end
      it 'post_codeが空だと保存できない' do
        @order_shipping.post_code = ""
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できない' do
        @order_shipping.post_code = "1111111"
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it 'region_idが1の時は保存できない' do
        @order_shipping.region_id = "1"
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Region can't be blank")
      end
      it 'cityが空だと保存できない' do
        @order_shipping.city = ""
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("City can't be blank")
      end
      it 'blockが空だと保存できない' do
        @order_shipping.block = ""
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Block can't be blank")
      end
      it 'phone_numberが空だと保存できない' do
        @order_shipping.phone_number = ""
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberは数値のみ保存できない' do
        @order_shipping.phone_number = "111-111-111"
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number is invalid.")
      end
      it 'phone_numberが10桁未満だと保存できない' do
        @order_shipping.phone_number = "123456789"
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number is invalid.")
      end
      it 'phone_numberが11桁を超えると保存できない' do
        @order_shipping.phone_number = "111111111111"
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number is invalid.")
      end
      it 'phone_numberが全角だと保存できない' do
        @order_shipping.phone_number = "０９０１２３４５６７８"
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number is invalid.")
      end
      it 'userが紐づいていないと保存できない' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐づいていないと保存できない' do
        @order_shipping.item_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
