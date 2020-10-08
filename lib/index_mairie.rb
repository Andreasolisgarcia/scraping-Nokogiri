require 'rubygems'
require 'nokogiri'   
require 'open-uri'
def get_townhall_urls
    specific_url = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html")).xpath('//a[@class="lientxt"]/@href')
    #PAGE DE CHAQUE MAIRIE DANS LE TABLEAU PAGE
    townhall_url = specific_url.map {|x| "https://www.annuaire-des-mairies.com" + x.text[1..-1]}     
end
def get_townhall_email(townhall_url)
    commune = Nokogiri::HTML(open(townhall_url))
    mail = commune.xpath('//div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
    return mail
end
def get_townhall_name(townhall_url)
    town = Nokogiri::HTML(open(townhall_url))
    name = town.xpath('//div/main/section[1]/div/div/div/h1').text
    return name[0..-9].downcase
end
Hash.class_eval do
   def split_into(divisions)
     count = 0
     inject([]) do |final, key_value|
       final[count%divisions] ||= {}
       final[count%divisions].merge!({key_value[0] => key_value[1]})
       count += 1
       final
     end
   end
 end   



def perform
    townhall_url = get_townhall_urls #récupérer townhall_url dans la def get-townhall_urls
    mails_array = [] #créer un array vide
    names_array = [] #créer un array vide
    townhall_url.each do |x| #faire tourner la def townhall_url
        mails_array << get_townhall_email(x) #ajouter x = email dans le tableau mails_array
        names_array << get_townhall_name(x) #ajouter x = name dans le tableau names-array
    end
    mairie_hash = Hash[names_array.zip(mails_array)]
    print mairie_hash.split_into(names_array.size)

end
perform