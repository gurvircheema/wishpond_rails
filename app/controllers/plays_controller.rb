class PlaysController < ApplicationController
  def index
    @random_10_images = ActiveStorage::Blob.order('RANDOM()').first(10)
    @plays = Play.all
  end

  def create
    play = Play.new(timer: play_params['timer'], url: play_params['url'])
    if play.save
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity }
    end
  end

  private

  def play_params
    params.require(:play).permit(:timer, :url)
  end
end
