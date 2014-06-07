require 'rubygems'
require 'bundler'
Bundler.require :default

require './lib/legco'
namespace :members do
	task :bio_ch do
    puts ("Downloading Members Biography - Chinese version")
	  bio = Legco::Members::Bio.new
    data = bio.chinese
	  json = JSON.pretty_generate(data)
	  File.open("data/json/legco_members_bio_chi.json", "w") do |f|
	    f.write(json)
	  end
	end

  task :bio_en do
    puts ("Downloading Members Biography - English version")
    bio = Legco::Members::Bio.new
    data = bio.english
    json = JSON.pretty_generate(data)
    File.open("data/json/legco_members_bio_eng.json", "w") do |f|
      f.write(json)
    end
  end
end