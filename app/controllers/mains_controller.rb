class MainsController < ApplicationController
    def index
        @products=Product.all
    end

    
end
