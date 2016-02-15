class CollaborationsController < ApplicationController
  before_action :set_collaboration, only: [:destroy]
  before_action :set_wiki

  def index
    @users = User.all
  end

  def new
    @collaboration = Collaboration.new
  end

  def create
    @collaboration = @wiki.collaborations.new(user_id: params[:user_id])

    respond_to do |format|
      if @collaboration.save
        format.html { redirect_to wiki_collaborations_path(@wiki), notice: 'Collaboration was successfully created.' }
        format.json { render :show, status: :created, location: @collaboration }
      else
        format.html { redirect_to wiki_collaborations_path(@wiki) }
        format.json { render json: @collaboration.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @collaboration.destroy
    respond_to do |format|
      format.html { redirect_to wiki_collaborations_path(@wiki), notice: 'Collaboration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_collaboration
      @collaboration = Collaboration.find(params[:id])
    end

    def set_wiki
      @wiki = current_user.wikis.find(params[:wiki_id])
    end
end
