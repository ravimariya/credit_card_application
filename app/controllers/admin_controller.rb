class AdminController < ApplicationController
  http_basic_authenticate_with name: 'admin', password: 'admin123'

  def index
    @credit_cards = CreditCard.all
  end
end
