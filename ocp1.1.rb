# with OCP

class UpdateStoreProduct

  def get_prices
    scraper_detalhes = Scrapers.const_get(@store_product.store_name).new
    scraper.get_prices(@store_product.url)
  end

end
