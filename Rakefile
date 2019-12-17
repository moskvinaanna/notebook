# frozen_string_literal: true

require 'rubocop/rake_task'
require 'sequel'
require 'json'
require 'date'

RuboCop::RakeTask.new

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |_, args|
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel.connect('sqlite://db/notes.db') do |db|
      Sequel::Migrator.run(db, 'migrations', target: version)
    end
  end
end

namespace :db do
  desc 'Fill database'
  task :fill_base do |_, _|
    Sequel.connect('sqlite://db/notes.db') do |db|
      fam_id = db[:statuses].insert(name: 'Семья')
      friends_id = db[:statuses].insert(name: 'Друзья')
      db[:notes].insert(name: 'Жанна', surname: 'Москвина', patronymic_name: 'Алексеевна',
                        cell_phone_num: '+7-909-278-50-25', home_phone_num: '54-56-09', address: 'Ярославль',
                        birthday_date: Date.new(1971, 2, 6), gender: 'женский', status_id: fam_id)
      db[:notes].insert(name: 'Владимир', surname: 'Москвин', patronymic_name: 'Викторович',
                        cell_phone_num: '+7-960-278-50-25', home_phone_num: '54-56-09', address: 'Ярославль',
                        birthday_date: Date.new(1970, 4, 2), gender: 'мужской', status_id: fam_id)
      db[:notes].insert(name: 'Елизавета', surname: 'Кашина', patronymic_name: 'Андреевна',
                        cell_phone_num: '+7-976-132-43-25', address: 'Москва',
                        birthday_date: Date.new(1996, 8, 24), gender: 'женский', status_id: friends_id)
      db[:notes].insert(name: 'Оксана', surname: 'Чечулина', patronymic_name: 'Максимовна',
                        cell_phone_num: '+7-961-141-12-43', address: 'Ярославль',
                        birthday_date: Date.new(1998, 11, 13), gender: 'женский', status_id: friends_id)
    end
  end
end

namespace :server do
  desc 'Start server'
  task :start do
    filepath = File.expand_path('./db/notes.db', __dir__)
    unless File.exist? filepath
      Rake::Task['db:migrate'].invoke
      Rake::Task['db:fill_base'].invoke
    end
    `rerun rackup`
  end
end

task :default do
  Rake::Task['server:start'].invoke
end
