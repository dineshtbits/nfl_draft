namespace :import do
  desc 'Import data from CSV files'
  task data: :environment do
    Rake::Task['import:draft'].execute
    Rake::Task['import:teams'].execute
    Rake::Task['import:players'].execute
    Rake::Task['import:draft_order'].execute
  end
end
