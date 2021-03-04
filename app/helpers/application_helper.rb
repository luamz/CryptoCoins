module ApplicationHelper
    
    def data_br(data_us)
        data_us.strftime("%d/%m/%Y")
    end
    
    def nome_aplicacao
        "Crypto Moedas"
    end
    
    #def locale(locale)
    #    if I18n.locale == :en
    #        "English"
    #    else
    #        "Português do Brasil"
    #    end
    #end
    
end
