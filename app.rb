require 'uri'
require "sinatra"
require "sinatra/activerecord"

set :database, "sqlite3:report.db"

class Report < ActiveRecord::Base

  def filedir
    self.file.split('/')[2]
  end

  def filexml
    self.file.split('/')[3]
  end

  def size
    File.size(self.file)
  end
  
end

helpers do
  def title
    if @title
      "#{@title} -- Reporter"
    else
      "Reporter"
    end
  end


  def pretty_date(time)
   time.strftime("%d %b %Y")
  end

end

get "/" do
  # @reports = Report.where(timestamp: "946684800").take(100)
  @reports = Report.select(:file).distinct
  erb :index
end
