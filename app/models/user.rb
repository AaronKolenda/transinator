class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_stations
  has_many :stations, through: :user_stations

  DISTANCE = 2

  def get_close_bikes
    close_bikes =[]
    Bike.all.each do |bike|
      if bike.check_distance(self) < DISTANCE
        close_bikes.push bike
      end
    end
    close_bikes
  end

  def get_close_rails trains
    close_rail = []
    trains.each do |train|
      if train.check_distance(self) < DISTANCE
        close_rail.push train
      end
    end
    close_rail
  end

  def add_favorite_bus_stop(api_id)
    user_stations.find_or_create_by(api_id: api_id)
  end

  def update_favorite_bus_stop(api_id)
    api_lookup_hash = Bus.lookup_hash.invert
    user_stations.find_by(api_id: api_id).update(name: api_lookup_hash[api_id])
  end

  def store_location lat, long
    update! lat: lat, long: long
  end

  def add_favorite_station station_id
    user_stations.find_or_create_by(station_id: station_id)
  end

  def delete_favorite_station station_id
    user_stations.find_by(station_id: station_id).delete
  end
end
