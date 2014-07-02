require 'nokogiri'
require 'time'
require 'sqlite3'
require "./app"
require "sinatra/activerecord/rake"

lordstest = "./public/hansard/march2014/LHAN121.xml"
hansard_xml = FileList['./public/hansard/*/*.xml']

task :default => 'log:timecodes'

def setup

  File.delete('report.db')

  @db = SQLite3::Database.new "report.db"

  @db.execute "create table reports(id INTEGER PRIMARY KEY,file text,timecode text,timestamp text,line text);"

end



def gen(this)

  doc = Nokogiri::XML(File.open(this))

  doc.remove_namespaces!

  timecodes = doc.xpath('//hs_TimeCode')

  timecodes.each_with_index do |hs_timecode, index|
    hs_timecode_time = hs_timecode['time']
    this_intime = Time.parse(hs_timecode_time).to_i
    prev_intime = Time.parse(timecodes[index-1]['time']).to_i

    @db.execute("INSERT INTO reports (file, timecode, timestamp, line) VALUES (?, ?, ?, ?)", [this, hs_timecode_time, this_intime, hs_timecode.line])


    #   when !(this_intime > prev_intime)
    #     # log.info [this, "SEQUENCE", hs_timecode.line, "#{hs_timecode_time} follows #{timecodes[index-1]['time']}"]

    # hs_timecode.parent['url']

  end


end

def get_business_types(this)

  doc = Nokogiri::XML(File.open(this))

  doc.remove_namespaces!

  newdebates = doc.xpath('//NewDebate')

  newdebates.each_with_index do |newdebate, index|
    puts newdebate['BusinessType']

  end


end

def get_amendment_headings(this)

  doc = Nokogiri::XML(File.open(this))

  doc.remove_namespaces!

  amendmentheadings = doc.xpath('//hs_AmendmentHeading')

  amendmentheadings.each_with_index do |amendmentheading, index|
    puts [amendmentheading['uid'], amendmentheading['url'], amendmentheading.text]

  end


end

def get_amendments(this)

  doc = Nokogiri::XML(File.open(this))

  doc.remove_namespaces!

  amendments = doc.xpath('//Amendment')

  amendments.each_with_index do |amendment, index|
    # puts amendment.inspect
    puts [index, this]
    puts amendment.text
    puts
  end


end

namespace :timecodes do

  desc "rebuild timecodes report db"
  task :rebuild do
    setup()
    hansard_xml.each do |this|

    gen(this)
    puts "Processing #{this}"
    end

    puts "Finished"
  end

end

namespace :business do

  desc "print out businesstypes"
  task :report do
    hansard_xml.each do |this|

    get_business_types(this)
    puts "Processing #{this}"
    end

    puts "Finished"
  end


end

namespace :amendmentheadings do

  desc "print out amendmentheadings"
  task :report do
    hansard_xml.each do |this|

    get_amendment_headings(this)
    puts "Processing #{this}"
    end

    puts "Finished"
  end


end

namespace :amendments do

  desc "print out amendments"
  task :report do
    hansard_xml.each do |this|

    get_amendments(this)
    puts "Processing #{this}"
    end

    puts "Finished"
  end


end
