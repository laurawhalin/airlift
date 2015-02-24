class WelcomeController < ApplicationController
  def index
    @items = Item.all
  end

  def not_found

  end
end
