class Api::V1::FoldersController < Api::V1::BaseController
  find :folder
  before_filter :has_access

  def show
    render json: @folder
  end

  private

  def has_access
    # TODO
  end

end