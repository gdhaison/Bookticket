module Importfile
  class ImportsController < ApplicationController
    def create
      @file = params[:file]
      if @file.present?
        if Import.call(@file)
          flash[:success] = t ".success"
        else
          flash[:warning] = t ".invalid"
        end
      else
        flash[:error] = t ".empty"
      end
      redirect_to manager_categories_path
    end
  end
end
