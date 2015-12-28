class WikisController < ApplicationController
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    authorize @wiki
  end

# TODO Feature - Allow you to attempt to create a wiki, suspend and prompt for signin, then complete request on sign-in
  def new
    @wiki = Wiki.new
  end

  def edit
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.new(wiki_params)

    respond_to do |format|
      if @wiki.save
        format.html { redirect_to @wiki}
        format.json { render :show, status: :created, location: @wiki }
      else
        format.html { render :new }
        format.json { render json: @wiki.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @wiki
    # collaborators = User.where(params[:collaborators])
    #
    # flash[:notice] = "Collaborators = #{collaborators}"
    #
    #
    # # REVIEW Fix this to store new collaborators
    # collaborators.each do |user|
    #   # Collaboration.create(wiki: @wiki, collaborator: user)
    #   Collaboration.create(wiki: @wiki, user: user)
    # end


    respond_to do |format|
      if @wiki.update(wiki_params)
        # @wiki.collaborators = Collaborator.update_collaborators(params[:wiki][:collaborators])
        format.html { redirect_to @wiki}
        format.json { render :show, status: :ok, location: @wiki }
      else
        format.html { render :edit }
        format.json { render json: @wiki.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wikis/1
  # DELETE /wikis/1.json
  def destroy
    authorize @wiki
    wiki_log = @wiki.title.truncate(30)
    @wiki.destroy
    respond_to do |format|
      format.html { redirect_to wikis_url, notice: "Wiki \" #{wiki_log}\" was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wiki
      @wiki = Wiki.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wiki_params
      params.require(:wiki).permit(:title, :body, :private, :user_id)
      # params.require(:wiki).permit(:title, :body, :private, :user_id, :collaborators)
    end
end
