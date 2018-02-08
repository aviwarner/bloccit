class TopicsController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_user_mod, except: [:index, :show]
  before_action :authorize_user, only: [:destroy]

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash.now[:alert] = "Error creating topic. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash.now[:alert] = "Error saving topic, try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
      redirect_to topics_path
    else
      flash.now[:alert] = "There was an error deleting the topic."
      render :show
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end

  def authorize_user
    unless current_user.admin?
      flash[:alert] = "Ah ah ah!! You didn't say the magic word! (you've gotta be an admin)"
      redirect_to topics_path
    end
  end

  def authorize_user_mod
    unless current_user.admin? || current_user.moderator?
      flash[:alert] = "you've gotta be an admin or moderator"
      redirect_to topics_path
    end
  end
end
