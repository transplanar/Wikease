class WikisController < ApplicationController
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.new(wiki_params)
    wiki_log = @wiki.title.truncate(30)

    respond_to do |format|
      if @wiki.save
        format.html { redirect_to @wiki, notice: "Wiki \" #{wiki_log}\" was successfully created."  }
        format.json { render :show, status: :created, location: @wiki}
      else
        format.html { render :new }
        format.json { render json: @wiki.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @wiki

    respond_to do |format|
      if @wiki.update(wiki_params)
        format.html { redirect_to @wiki}
        format.json { render :show, status: :ok, location: @wiki }
      else
        format.html { render :edit }
        format.json { render json: @wiki.errors, status: :unprocessable_entity }
      end
    end
  end

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
    def set_wiki
      @wiki = Wiki.find(params[:id])
    end

    def wiki_params
      params.require(:wiki).permit(:title, :body, :private, :user_id)
    end
end
