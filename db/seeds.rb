# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create! email: 'admin@mit.edu', password: 'mit',
    password_confirmation: 'mit'
admin.email_credential.verified = true
admin.admin = true
admin.save!

dev_path = Rails.root.join('tmp', 'blocks').to_s
FileUtils.mkdir_p dev_path
dev = Device.create path: dev_path

dev.create_blocks! 100
