class KagglesController < ApplicationController
  include KagglesHelper



  def index
    @kaggle = Kaggle.new
    @code = Kaggle.last.code
    language = Kaggle.last.language # Only used here for formatting
    
      if !@code.nil?
          require 'rouge'
          source = @code # "def plus_two(x)\n  x + 2\nend"
          formatter = Rouge::Formatters::HTML.new
          formatter = Rouge::Formatters::HTMLLinewise.new(formatter, class: 'line-%i')

        if language == "R"
          lexer = Rouge::Lexers::R.new
          @code = formatter.format(lexer.lex(source)) 
        elsif 
          language == "python"
          lexer = Rouge::Lexers::Python.new
          @code = formatter.format(lexer.lex(source)) 
        end


      end


 





  end





 def create
  
  @kaggle = Kaggle.new(kaggle_params)

  



 


  # Testing
  # @kaggle = Kaggle.new(link:"https://www.kaggle.com/adityaecdrid/mnist-with-keras-for-beginners-99457")
  require 'rinruby'

  r_script = File.read(Rails.root.join("lib/tasks/get_raw_code.R"))
  r = RinRuby.new
  r.eval "link <- '" + @kaggle.link + "'"
  r.eval r_script 
  

  code = r.pull "code"
  language = r.pull "language"

  @kaggle.code = code
  @kaggle.language = language

  @kaggle.save


  redirect_to '/'

 end








private

  def kaggle_params
  params.require(:kaggle).permit(:link) 
  end








end
