class BooksController < ApplicationController
rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
include Pundit


  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, expect: [:show, :index]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @user = current_user.id
    @book = Book.new


  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.user =current_user
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json

  def destroy
    @book = Book.find(params[:id])
    authorize @book, :delete?
    if @book.destroy
  if @book.destroy
    # redirect_to books_url
  else
    render :edit
  end
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
      end
    end
  end
  def user_not_authorized
    flash[:alert] = "You are not authorized to preform this action"
     redirect_to books_url
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :desc, :user_id)
    end
end
