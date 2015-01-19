module Scrapers
  class MegaMamute < Base
    def get_prices(url)
      # ...
    end
  end
end


class UpdateStoreProduct
  def get_prices
    scraper = Scrapers.const_get(@store_product.store_name).new
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
    scraper = Scrapers.const_get(@store_product.store_name).new
    if @store_product.store_product == 'mega_mamute'
      scraper.get_prices(@store_product.url, product_name)
    else
      scraper.get_prices(@store_product.url)
    end
  end
end
