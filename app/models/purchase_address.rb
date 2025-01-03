class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postalcode, :prefecture_id, :city, :address, :building_name, :tel, :user_id, :item_id, :token

  with_options presence: true do
    validates :postalcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city, presence: {message: "can't be blank"}
    validates :address, presence: {message: "can't be blank"}
    validates :tel, format: { with: /\A[0-9]{10,11}\z/, message: "is invalid. It should be 10 to 11 digits without hyphens." }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postalcode: postalcode, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, tel: tel, purchase_id: purchase.id)
  end
end

