class QuestsController < ApplicationController
  before_action :set_quest, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @quests = Quest.all
    @hash = Gmaps4rails.build_markers(@quests) do |quest, marker|
      marker.lat quest.latitude
      marker.lng quest.longitude
    end

    
    respond_with(@quests)

    
  end

  def show
    respond_with(@quest)
  end

  def new
    @quest = Quest.new
    respond_with(@quest)
  end

  def edit
  end

  def create
    @quest = Quest.new(quest_params)
    @quest.save
    respond_with(@quest)
  end

  def update
    @quest.update(quest_params)
    respond_with(@quest)
  end

  def destroy
    @quest.destroy
    respond_with(@quest)
  end

  private
    def set_quest
      @quest = Quest.find(params[:id])
    end

    def quest_params
      params.require(:quest).permit(:latitude, :longitude, :address, :description, :title)
    end
end
