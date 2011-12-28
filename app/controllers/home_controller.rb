class HomeController < ApplicationController
  before_filter :save_tracking_params, :only => :index
  before_filter :prepare_questions, :only => :question

  PROFILES = %w{casual contemporary elegant feminine sexy traditional trendy}

  PROFILE_CODES = { 'trendy'        => { 1 => 'Trendy'      },
                    'casual'        => { 2 => 'Basica'      },
                    'feminine'      => { 3 => 'Feminina'    },
                    'elegant'       => { 4 => 'Elegante'    },
                    'traditional'   => { 5 => 'Tradicional' },
                    'sexy'          => { 6 => 'Sexy'        },
                    'contemporary'  => { 7 => 'Fashionista' }
                  }

  def index
    session[:questions] = nil
    redirect_to quota_full_path if Answer.confirmed_users >= 250
  end

  def quota_full 
  end

  def profile
    @question_number = params[:number]
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
      question_number, question_image = session[:questions][number - 2].flatten

      question_image = clean_image_name question_image
      profile_code, profile_name = PROFILE_CODES[PROFILES[response-1]].flatten

      Answer.find_or_create_by_user_and_image(session[:user], question_image, :question_number => question_number, :profile_name => profile_name, :profile_code => profile_code, :confirmed => false)
    end

    if number <= session[:questions].length
      question_number, question_image = session[:questions][number - 1].flatten
      @question_picture = question_image
      @question_title = clean_image_name @question_picture
      @next_question = number + 1
      render 'question', :layout => 'questions'
    else
      redirect_to finish_path
    end
  end

  def finish
    Answer.where(:user => session[:user]).unconfirmed.update_all({:confirmed => true})
  end

  def admin_results
    @answers = Answer.confirmed.by_user.by_question_number
  end
private
  def clean_image_name(original_name)
    result = original_name.gsub(/.jpg$/, '')
    result.gsub(/-[a-zA-Z0-9]{32}$/, '')
  end

  def save_tracking_params
    incoming_params = params.clone.delete_if {|key| ['controller', 'action'].include?(key) }
    if incoming_params.empty?
      session[:user] = Random.rand(9999999999).to_s
    else
      session[:user] = incoming_params.to_s
    end
  end

  def pictures_dir
    pictures = Rails.env.production? ? 'public/assets/survey' : 'app/assets/images/survey'
    Rails.root.join pictures
  end

  def prepare_questions
    if session[:questions].nil?
      files = Dir.entries(pictures_dir)
      if Rails.env.production?
        files.delete_if {|filename| !filename.match /-[a-zA-Z0-9]{32}.jpg$/}
      else
        files.delete_if {|filename| !filename.match /.jpg$/}
      end
      files.sort!
      questions = []
      files.each_with_index do |question, index|
        questions << { index => question }
      end
      session[:questions] = questions.shuffle
    end
  end
end
