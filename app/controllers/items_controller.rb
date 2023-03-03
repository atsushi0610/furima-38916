class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index
  end
end
