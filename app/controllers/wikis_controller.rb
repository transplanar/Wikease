class WikisController < ApplicationController
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]
  # GET /wikis
  # GET /wikis.json
  def index
    # @wikis = Wiki.all
    @wikis = policy_scope(Wiki)
  end

  # GET /wikis/1
  # GET /wikis/1.json
  def show
    authorize @wiki
  end

# TODO Feature - Allow you to attempt to create a wiki, suspend and prompt for signin, then complete request on sign-in
  # GET /wikis/new
  def new
    @wiki = Wiki.new
  end

  # GET /wikis/1/edit
  def edit
    authorize @wiki
  end

  # POST /wikis
  # POST /wikis.json
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

  # PATCH/PUT /wikis/1
  # PATCH/PUT /wikis/1.json
  def update
    authorize @wiki

    # XXX does this work?
    # @users << params[:collaborators]

    # Parse collaborators
    collaborators = User.where(params[:collaborators])
    # collaborators = params[:collaborators] == 1)

    flash[:notice] = "Collaborators = #{collaborators}"


    # REVIEW Fix this to store new collaborators
    collaborators.each do |user|
      # Collaboration.create(wiki: @wiki, collaborator: user)
      Collaboration.create(wiki: @wiki, user: user)
    end


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
    @wiki.destroy
    respond_to do |format|
      format.html { redirect_to wikis_url, notice: 'Wiki was successfully destroyed.' }
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
