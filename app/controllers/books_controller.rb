class BooksController < ApplicationController
  before_action :authenticate_user!


  def index
      @book = Book.new
      @books = Book.all.order(created_at: :desc)
      @user = current_user
  end

  def show
      @book = Book.find(params[:id])
      @newbook = Book.new
      @user = @book.user
  end

  def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
      @user = current_user
      @books = Book.all.order(created_at: :desc)

      if @book.save
         redirect_to book_path(@book)
         flash[:notice] = "You have creatad book successfully."
      else
         render :index
      end
  end

  def new
  end

  def edit
      @book = Book.find(params[:id])
      if @book.user == current_user
      else
        redirect_to books_path
      end
  end

  def update
      @book = Book.find(params[:id])
      @book.update(book_params)
      if @book.save
        redirect_to book_path(@book)
        flash[:notice] = "You have edited book successfully"
      else
        render :edit
      end
  end

  def destroy
      @book = Book.find(params[:id])
      @book.destroy
      redirect_to books_path
  end

  private
    def book_params
        params.require(:book).permit(:title, :body)
    end

end
