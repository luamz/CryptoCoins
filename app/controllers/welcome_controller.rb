class WelcomeController < ApplicationController
  def index
    cookies[:nome] = 'Luam'
    #@meu_nome = 'Luam'
    @meu_nome = params[:nome]
  end
end
