class MainsController < ApplicationController
    def index
        @products=Product.all
    end
    def user_page
        @products=Product.all
    end
end
