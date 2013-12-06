class Api::V1::Administration::ExtensionIconsController < Api::V1::BaseController

  def index
    @icons = ExtensionIcon.all
    authorize @icons, class: ExtensionIcon
    render json: @icons, each_serializer: ExtensionIconSerializer
  end

  def create
    @icon = ExtensionIcon.new params[:extension_icon][:extension]
    @icon.icon = params[:extension_icon][:icon]
    @icon.save
    render json: @icon
  end

  def destroy
    @icon = ExtensionIcon.for params[:id]
    @icon.destroy
    render json: @icon
  end

end