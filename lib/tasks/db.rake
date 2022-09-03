namespace :db do
  desc 'migrate then seed the database'
  task install: [ 'db:migrate', 'db:seed' ] do
    puts 'Install completed.'
  end
end