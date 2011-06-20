desc "Make a backup of the database to the data directory"
task :backup => :environment do
  `pg_dump notesuite_#{RAILS_ENV} > #{RAILS_ROOT}/data/#{RAILS_ENV}-#{Time.now.strftime('%Y%m%d%H%M')}.sql`
  puts "Dumped! Please save this somewhere safe."
end