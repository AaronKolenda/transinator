class Bus < Station
  include HTTParty

  BUSDISTANCE =  1610 #meters (almost 1 mile)
  def self.get_nearby_bus_stops(user)
    nearby_buses = HTTParty.get("https://api.wmata.com/Bus.svc/json/jStops?Lat=#{user.lat.to_f}&Lon=#{user.long.to_f}&Radius=#{BUSDISTANCE}&api_key=#{ENV["WMATA_APIKEY"]}")
    nearby_buses
  end

  def self.get_favorite_bus_predictions(user)
    @bus_stop_info = []
    user.stations.where(type: "Bus").each do |stop| 
      @bus_stop_info << HTTParty.get("https://api.wmata.com/NextBusService.svc/json/jPredictions?StopID=#{stop.api_id}&api_key=#{ENV["WMATA_APIKEY"]}")
    end
    @bus_stop_info
  end


end