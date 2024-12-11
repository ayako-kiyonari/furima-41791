require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品の保存' do
    context '商品出品が保存できる場合' do
      it 'すべての項目が入力されていたら保存できる' do
        expect(@item).to be_valid
      end
    end
    context '商品出品が保存できない場合' do
      it '画像が空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image must be attached")
      end
      it '商品名が空では保存できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end  
      it '商品の説明が空では保存できない' do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end  
      it 'カテゴリーが空では保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end    
      it '商品の状態が空では保存できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end   
      it '配送料の負担が空では保存できない' do
        @item.deliveryfee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Deliveryfee can't be blank")
      end   
      it '発送元の地域が空では保存できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end  
      it '発送までの日数が空では保存できない' do
        @item.shipdate_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipdate can't be blank")
      end   
      it '価格が空では保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end   
      it '価格が300円未満では保存できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be a one-byte number and set within the range of ¥300 to ¥9,999,999.")
      end   
      it '価格が10,000,000円以上では保存できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be a one-byte number and set within the range of ¥300 to ¥9,999,999.")
      end  
      it '価格が全角では保存できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be a one-byte number and set within the range of ¥300 to ¥9,999,999.")
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @item.user = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('User must exist')
      end    
    end
  end
end




