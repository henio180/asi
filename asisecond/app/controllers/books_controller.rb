class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :crop, :update_crop]

  # GET /books/1/crop
  def crop
  end

  def update_crop
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to books_url, notice: 'Cover was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # GET /books
  # GET /books.json
  #def index
  #  @books = Book.all
  #end

def index
    @books = Book.paginate(:page => params[:page]).search(params[:search])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
      format.js
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render action: 'show', status: :created, location: @book }
      else
        format.html { render action: 'new' }
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
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

  def book_params
    params.require(:book).permit(:author, :title, :isbn, :price,
      :cover, :remove_cover, :cover_cache, :remote_cover_url,
      :crop_x, :crop_y, :crop_w, :crop_h)
  end
end
