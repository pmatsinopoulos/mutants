# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
seeds_folder = File.expand_path '..', __FILE__
$LOAD_PATH.unshift seeds_folder unless $LOAD_PATH.include? seeds_folder

load 'seed_mutants.rb'
