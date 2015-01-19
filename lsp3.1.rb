# FOLLOWING LSP AND SRP

module Scrapers
  class MegaMamute < Base
    def self.scrape(url)
      # returns the name, prices, etc
    end
  end
end

# I should analyze the data to use the price or not outside the scraper
class UpdateStoreProduct
  def update
    #....
    get_scraped_data()
    validate_scraped_data()
    # save, etc....
  end

  def get_scraped_data
    scraper = Scrapers.const_get(@store_product.store_name).new
    @scraped_data scraper.scrape(@store_product.url)
  end

  def validate_scraped_data
    # bla bla bla
  end
end

