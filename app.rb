require "sinatra"
require "sinatra/activerecord"
require 'will_paginate'
require 'will_paginate/active_record'

set :database, {adapter: "sqlite3", database: "report.db"}

class Report < ActiveRecord::Base

  def static_file_path
    file.gsub('public/','')
  end

  def pretty_timestamp
    Time.at(timestamp.to_i).strftime("%A %d %b %Y %l:%M.%S")
  end

  def next
    Report.where(id: self.id+1).first
  end

  def error_badge

    if self.timestamp == "946684800"
      "<span class='label label-warning'>DEF</span>"
    elsif self.next.timestamp < self.timestamp or self.next.timestamp == self.timestamp
      "<span class='label label-danger'>SEQ</span>"
    end
    
  end

end


get "/" do
  # @reports = Report.where(timestamp: "946684800").take(100)
  # @reports = Report.select(:file).distinct
    @reports = Report.paginate(:page => params[:page], :per_page => 30)

  erb :index
end
