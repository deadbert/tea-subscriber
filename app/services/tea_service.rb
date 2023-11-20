class TeaService

  def conn
    Faraday.new(url: "https://api.spoonacular.com/") do |f|
      f.params[:apiKey] = Rails.application.credentials.spoonacular[:key]
    end
  end

  def get_url(endpoint)
    result = conn.get(endpoint)
    JSON.parse(result.body, symbolize_names: true)
  end

  def tea_search
    get_url("food/products/search?query=tea")
  end
end