module Supports
  class Movie < ApplicationRecord
    attr_accessor :movie

    def find_review movie
      @find_review ||= movie.reviews.order("created_at asc")
    end

    def new_review movie
      @new_review ||= movie.reviews.build
    end

    def find_comment movie
      @find_comment ||= movie.comments.where(parent_id: nil).order(created_at: :desc)
    end

    def comment_id comments
      @comment_id ||= comments.pluck(:id)
    end

    def find_reply comment_id
      @find_reply ||= Comment.where(parent_id: comment_id)
    end

    def new_comment
      @new_comment ||= Comment.new
    end

    def rate movie, current_user
      @rate ||= movie.reviews.where(user_id: current_user.id) if current_user
    end
  end
end
