require "sinatra"
require "sinatra/activerecord"

set :database, {adapter: "sqlite3", database: "report.db"}

class Report < ActiveRecord::Base

  def static_file_path
    file.gsub('public/','')
  end

  def pretty_timestamp
    Time.at(timestamp.to_i).strftime("%A %d %b %Y")
  end


end


get "/" do
  # @reports = Report.where(timestamp: "946684800").take(100)
  # @reports = Report.select(:file).distinct
    @reports = Report.all().take(40)

  erb :index
end
