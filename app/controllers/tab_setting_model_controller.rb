class TabSettingModelController < ApplicationController
	def index
		@models = TabSettingModel.all
	end

	def new
        @tab_setting_model = TabSettingModel.new
		render :action => :edit
	end

	def edit
		selected_tab_setting_model
	end

	def save
		tab_setting_model = selected_tab_setting_model
        if tab_setting_model.nil?
            tab_setting_model = TabSettingModel.new
        end
        tab_setting_model.assign_attributes(post_params)
        tab_setting_model.save!
        flash[:notice] = l(:notice_successful_update)
		redirect_to  action: :index
	end

	def delete
        tab_setting_model = selected_tab_setting_model
        tab_setting_model.delete    
        flash[:notice] = l(:notice_successful_delete)
        redirect_to :back
	end

    def selected_tab_setting_model
        @tab_setting_model = TabSettingModel.find_by_id(params[:id])
    end

    def post_params
        params.require(:tab_setting_model).permit!
    end
end