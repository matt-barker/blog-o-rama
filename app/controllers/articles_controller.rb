class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:show, :index]
  
  
  # GET /articles
  # GET /articles.json
  def index
    @sidebar_articles = Article.order("date_posted DESC").first(5)
    if params[:q]
        @search_term = params[:q]
        if Rails.env == "development"
          @articles = Article.where("title LIKE ?", "%#{@search_term}%").order("date_posted DESC").paginate(:page => params[:page])
        else
          @articles = Article.where("title ilike ?", "%#{@search_term}%").order("date_posted DESC").paginate(:page => params[:page])
        end
      else
        @articles = Article.order("date_posted DESC").paginate(:page => params[:page])
    end
    @user = current_user
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @sidebar_articles = Article.last(5).reverse_each
    @articles = Article
    @comments = @article.comments.order("created_at DESC").paginate(:page => params[:page])
  end

  # GET /articles/new
  def new
    @article = Article.new
    @user = current_user
  end

  # GET /articles/1/edit
  def edit
  end

  def search
      
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @user = current_user
    @article.author = @user.first_name + " " + @user.last_name
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :image_url, :has_image, :date_posted, :author)
    end
end
