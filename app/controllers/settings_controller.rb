class SettingsController < ApplicationController
  def index
    @settings = Setting.all.order('id ASC')
  end

  def show
    @setting = Setting.find(params[:id])
  end

  def new
    @setting = Setting.new
  end

  def create
    @setting = Setting.new(setting_params)
    @setting.save
    redirect_to :settings
  end

  def edit
    @setting = Setting.find(params[:id])
  end

  def update
    @setting = Setting.find(params[:id])
    @setting.update_attributes(setting_params)
    redirect_to setting_path(@setting.id)
  end

  def destroy
    @setting = Setting.find(params[:id])
    @setting.destroy
    redirect_to :settings
  end

  private

  def setting_params
    params.require(:setting).permit(:name, :value)
  end
end
