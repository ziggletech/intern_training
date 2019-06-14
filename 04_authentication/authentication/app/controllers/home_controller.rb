class HomeController < ApplicationController
    def index
        @name = "amit"
        redirect_to articles_path if logged_in?
    end
end
