module Scrapers
  class MegaMamute < Base
    def get_prices(url)
      # ...
    end
  end
end


class UpdateStoreProduct
  def get_prices
    scraper_detalhes = Scrapers.const_get(@store_product.store_name).new
    scraper.get_prices(@store_product.url)
  end
end

# NOT FOLLOWING LSP

module Scrapers
  class MegaMamute < Base
    def self.scrape(url, product_name)
    end
  end
end


class UpdateStoreProduct
  def get_prices
    scraper_detalhes = Scrapers.const_get(@store_product.store_name).new
    if @store_product.store_product == 'mega_mamute'
      scraper.get_prices(@store_product.url, product_name)
    else
      scraper.get_prices(@store_product.url)
    end
  end
end


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
  def get_scraped_data
    scraper_detalhes = Scrapers.const_get(@store_product.store_name).new
    scraper.scrape(@store_product.url)
  end
end

