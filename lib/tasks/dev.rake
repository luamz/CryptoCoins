namespace :dev do
  desc "Configura ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando"){%x(rails db:drop:_unsafe)}
      show_spinner("Criando") {%x(rails db:create)}
      show_spinner("Migrando"){%x(rails db:migrate)}
      %x(rails dev:add_mining_types) #Tem que ser primeiro, pq o add_coins depende dele
      %x(rails dev:add_coins)
      
    else
      puts "Você não está em ambiente de desenvolvimento"
    end
  end
  
  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas do") do
      coins = 
      [
        {
          description: "Bitcoin",
          acronym: "BTC",
          url_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/1200px-Bitcoin.svg.png",
          mining_type:MiningType.find_by(acronym: "PoW")
        },
         
        {
          description: "Ethereum",
          acronym: "ETH",
          url_image: "https://cryptologos.cc/logos/ethereum-eth-logo.png",
          mining_type:MiningType.all.sample
        },
        
        {
          description: "DASH",
          acronym: "DASH",
          url_image: "https://media.dash.org/wp-content/uploads/dash-d.png",
          mining_type:MiningType.all.sample
        },
        { 
          description: "Iota",
          acronym: "IOT",
          url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1720.png",
          mining_type:MiningType.all.sample
        },
        { 
          description: "ZCash",
          acronym: "ZEC",
          url_image: "https://www.cryptocompare.com/media/351360/zec.png",
          mining_type:MiningType.all.sample
        }
      ]
      
      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end
  
private

desc "Cadastra os tipos de mineração"
task add_mining_types: :environment do
  show_spinner("Cadastrando os tipos de mineração do") do
    mining_types = 
    [
      {description: "Proof of Work", acronym: "PoW"},
      {description: "Proof of Stake", acronym: "PoS"},
      {description: "Proof of Capacity", acronym:"PoC"}
    ]
    mining_types.each do |mining_type|
          MiningType.find_or_create_by!(mining_type) #Criar se ainda não existe
    end
  end
end

def show_spinner(frase)
  spinner = TTY::Spinner.new("[:spinner] #{frase} banco de dados...")
  spinner.auto_spin
  yield
  spinner.success('(Concluído!!!)')
end
end