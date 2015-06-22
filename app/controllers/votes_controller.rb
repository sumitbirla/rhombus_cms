class VotesController < ApplicationController
  
  def create
    vote = Vote.new(vote_params)
    vote.user_id = session[:user_id]
    vote.ip_address = request.ip
    vote.cookie = session.id
    
    if vote.save
      flash[:popup] = "You vote has been registered."
      if vote.votable_type == "picture"
        Picture.increment_counter(:votes, vote.votable_id)
      end
    else
      flash[:popup] = vote.errors.messages.join(". ")
    end
    
    redirect_to :back
  end
  
  private
  
    def vote_params
      params.require(:vote).permit(:votable_id, :votable_type)
    end
end
