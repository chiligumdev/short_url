# app/controllers/api/links_controller
class Api::LinksController < Api::ApiController
  before_action :set_link, only: [:show, :update, :destroy]

  def index
    @links = Link.where(user_id: @user.id).order(created_at: :desc)
    render json: @links, fields: json_fields
  end

  def show
    render json: @link
  end

  def create
    @link = Link.new(link_params)
    @link.user_id = @user.id
    @link.save
    render json: @link, fields: json_fields
  end

  def update
    @link.update_attributes(link_params)
    render json: @link, fields: json_fields
  end

  def destroy
    @link.delete
    render json: { msg: 'deleted' }
  end

  private

  def set_link
    @link = Link.find_by_token_and_user_id(params[:id], @user.id)
  end

  def link_params
    params.permit(:original_url)
  end

  def json_fields
    %w(id original_url short_url token created_at).map(&:to_sym).freeze
  end
end
