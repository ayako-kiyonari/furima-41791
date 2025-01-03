class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :check_owner, only: [:index, :create]
  before_action :check_sold_out, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_address = PurchaseAddress.new
  end

  def create    
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    if @purchase_address.valid? 
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end

  def check_owner
    if @item.user_id == current_user.id
      redirect_to root_path
    end
  end

  def check_sold_out
    if @item.purchase.present?
      redirect_to root_path
    end
  end

  def purchase_address_params
    params.require(:purchase_address).permit(:postalcode, :prefecture_id, :city, :address, :building_name, :tel).merge(user_id:current_user.id, item_id: params[:item_id], token: params[:token])
  end  

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  
      Payjp::Charge.create(
        amount: @item.price,  
        card: purchase_address_params[:token],    
        currency: 'jpy'              
      )
  end
 
end
