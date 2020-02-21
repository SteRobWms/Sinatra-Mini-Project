class PollsController < ApplicationController

    set :views, "app/views/polls"

    get "/polls" do
        @polls = Poll.all
        erb :index
    end
    
    get "/polls/new" do
        erb :new
    end
    
    post "/polls" do
        redirect "/polls/#{current_poll.id}"
    end

    get "/polls/:id" do
        @poll = current_poll
        erb :show
    end

    patch "/polls/:id" do
        @poll = current_poll
        poll.update(question: params[:question])
        redirect "/polls/#{current_poll.id}"
    end
    
    get "/polls/:id/edit" do
        @poll = current_poll
        erb :edit
    end

    delete "/polls/:id/delete" do
        current_poll.destroy
        redirect "/polls/"
    end

    def current_poll
        Poll.find(params[:id])
    end

    def poll_creator(poll)
        User.find(poll.creator_id)
    end

    def users_for_poll(poll)
        User.select do |user|  
          temp_opt = user.options    
          test_arr = []    
          temp_opt.each{|opt| test_arr << opt.poll_id}
          test_arr.include?(poll.id)
        end  
      end
end