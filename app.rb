
require "sinatra"
require "sinatra/activerecord"

set :public_folder, './data'
set :database, "sqlite3:report.db"
set :static_cache_control, [:public, :max_age => 3600]

class Report < ActiveRecord::Base
end

helpers do
  # If @title is assigned, add it to the page's title.
  def title
    if @title
      "#{@title} -- Reporter"
    else
      "Reporter"
    end
  end

  def data_to_public(thispath)
    thispath.slice! "data/"
    thispath
  end

  # Format the Ruby Time object returned from a post's created_at method
  # into a string that looks like this: 06 Jan 2012
  def pretty_date(time)
   time.strftime("%d %b %Y")
  end

end

get "/" do
  @reports = Report.where(timestamp: "946684800").take(100)
  erb :index
end
