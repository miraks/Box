class Users::PurchasesController < ApplicationController
  find :user

  def index
    @purchases = @user.purchases
  end

end