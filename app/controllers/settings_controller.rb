class SettingsController < ApplicationController
  def index
    @settings = Setting.all.order('id ASC')
    render json: @settings
  end

  def create
    @setting = Setting.new(setting_params)
    @setting.save
    if @setting.id.nil?
      render json: { 'status' => 'CRITICAL', 'error' => 'COULD NOT CREATE SETTING' }
    else
      render json: @setting
    end
  end

  def new
    @setting = Setting.new
    render json: @setting
  end

  def show
    @setting = Setting.find(params[:id])
    render json: @setting
  end

  def edit
    @setting = Setting.find(params[:id])
    render json: @setting
  end

  def update
    @setting = Setting.find(params[:id])
    @setting.update_attributes(setting_params)
    render json: @setting
  end

  def destroy
    @setting = Setting.find(params[:id])
    @setting.destroy
    render json: { 'status' => 'OK' }
  end

  private

  def setting_params
    params.require(:setting).permit(:value)
  end
end
