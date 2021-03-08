class TweetsController < ApplicationController
    before_action :require_user_logged_in!
    before_action :set_tweet, only: [:show, :edit, :update, :destroy]

    def index
        @tweets = Current.user.tweets
    end

    def new
        @tweet = Tweet.new
    end

    def create
        @tweet = Current.user.tweets.new(tweet_params)
        if @tweet.save
            redirect_to tweets_path, notice: "Tweet was Scheduled Successfully!!!"
        else
            render :new, alert: "Something's Wrong!?!"
        end
    end

    def edit
    end

    def update
        if@tweet.update(tweet_params)
            redirect_to tweets_path, notice: "Tweet was Updated Successfully!!!"
        else
            render :edit
        end
    end

    def destroy
        @tweet.destroy
        redirect_to tweets_path, notice: "Tweet was Unscheduled!!!"
    end

    private

    def tweet_params
        params.require(:tweet).permit(:twitter_account_id, :body, :publish_at)
    end

    def set_tweet
        @tweet = Current.user.tweets.find(params[:id])
    end
end