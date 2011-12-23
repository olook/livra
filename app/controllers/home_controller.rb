class HomeController < ApplicationController
  before_filter :save_tracking_params, :only => :index
  before_filter :prepare_questions, :only => :question

  PROFILES = %w{casual contemporary elegant feminine sexy traditional trendy}

  def index
    session[:questions] = nil
  end

  def profile
    index = params[:number].to_i
    @profile = PROFILES[index - 1]
    if index == PROFILES.length
      @next_page = question_path(1, 0)
    else
      @next_page = profile_path(index+1)
    end
  end

  def question
    number = params[:number].to_i
    response = params[:response].to_i

    if (1..7).include? response
      logger.debug "!!!!!!!! #{session[:questions][number-2]} = #{response}"
    end

    if number <= session[:questions].length
      @question_picture = session[:questions][number - 1]
      @next_question = number + 1
      render 'question', :layout => 'questions'
    else
      redirect_to finish_path
    end
  end

  def finish
  end
private
  def save_tracking_params
    incoming_params = params.clone.delete_if {|key| ['controller', 'action'].include?(key) }
    session[:tracking_params] = incoming_params unless incoming_params.empty?
  end

  def pictures_dir
    pictures = Rails.env.production? ? 'public/assets/survey' : 'app/assets/images/survey'
    Rails.root.join pictures
  end

  def prepare_questions
    if session[:questions].nil?
      session[:questions] = Dir.entries(pictures_dir)
      session[:questions].delete_if {|filename| !filename.match /.jpg$/}
      session[:questions].shuffle!
    end
  end
end
