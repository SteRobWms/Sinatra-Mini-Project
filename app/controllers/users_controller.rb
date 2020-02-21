class UsersController < ApplicationController
  set :views, "app/views/users"

  get "/users" do
    @users = User.all
    erb :index
  end

  get "/users/new" do
    erb :new
  end

  get "/users/:id" do
    @user = current_user
    @polls_user_created = "fix me"
    @questions = @user.polls.map {|poll| poll.question}
    @responses = @user.options.map {|uop| uop.value}

    erb :show
  end

  post "/users" do
    new_user = User.create(params[:user])
    redirect "/users/#{new_user.id}"
  end

  get "/users/:id/edit" do
    @user = current_user
    erb :edit
  end

  patch "/users/:id" do
    user = current_user
    user.update(params[:user])

    redirect "/users/#{user.id}"
  end

  delete "/users/:id" do
    user = current_user
    user.destroy
    redirect "/users"
  end

  def current_user
    User.find(params[:id])
  end
end