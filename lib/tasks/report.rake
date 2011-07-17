namespace :report do
  
  desc "Update peat.org/banknotes.txt"
  task :publish => :environment do
    cmd = ['curl', '-O', 'http://localhost:3000/notes.txt']
    IO.popen( cmd ) { |out| puts out.read }
    
    cmd = ['scp', 'notes.txt', 'peat.org:/home/peat/peat.org/static/banknotes.txt']
    IO.popen( cmd ) { |out| puts out.read }
  end
  
end