# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
require 'csv'
require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

desc "Import Merchants from CSV"
namespace :import do
  task merchants: :environment do
    CSV.foreach("data/merchants.csv", headers: true, header_converters: :symbol) do |row|
      Merchant.create!(id: row[:id], name: row[:name], created_at: row[:created_at], updated_at: row[:updated_at])
    end
  end
end
