class PagesController < ApplicationController
  before_action :sign_in_required, only: [:show]

  def index
    logger.debug('---------------------------------------------------------------------')
  end

  def show
    logger.debug('---------------------------------------------------------------------')
  end
end
