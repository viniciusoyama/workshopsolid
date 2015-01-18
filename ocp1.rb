class StoreProduct
  attr_accessor :url
  attr_accessor :store_name
end
class UpdateStoreProduct
  # This receives and Store Product and updates 
  # the model fields with scraped values
  #...
  def update
    #....
    prices = get_prices()
    # save, etc....
  end

  def get_prices
    scraper = nil

    case @store_product.store_name
      when "americanas" 
        scraper = Scrapers::Americanas.new
      when "balao_da_informatica"
        scraper = Scrapers::BalaoDaInformatica.new
      when "comprafacil"
        scraper = Scrapers::Comprafacil.new
      when "efacil"
        scraper = Scrapers::Efacil.new
      when "extra"
        scraper = Scrapers::Extra.new
      when "fastshop"
        scraper = Scrapers::Fastshop.new
      when "fnac"
        scraper = Scrapers::Fnac.new
      when "kabum"
        scraper = Scrapers::Kabum.new
      when "magazineluiza"
        scraper = Scrapers::Magazineluiza.new
      when "pontofrio"
        scraper = Scrapers::Pontofrio.new
      when "ricardo_eletro"
        scraper = Scrapers::RicardoEletro.new
      when "submarino"
        scraper = Scrapers::Submarino.new
      when "walmart"
        scraper = Scrapers::Walmart.new
    end 

    scraper.get_prices(@store_product.url)
  end
end
