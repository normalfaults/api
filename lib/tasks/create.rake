require 'highline/import'

namespace :create do

  def agree?(question)
    'Y' == ask(question) do |q|
      q.case = :up
      q.default = 'Y'
    end
  end

  def email?(default = '')
    ask('Email? ') do |q|
      q.default = default
      q.validate = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
      q.responses[:not_valid] = 'Please enter a valid email address. '
    end
  end

  def password?
    ask('<%= @key %> ') do |q|
      q.echo = '*'
      q.verify_match = true
      q.gather = {
        'Enter Password:' => '',
        'Please Confirm:' => ''
      }
      q.validate = /.{8,}/
      q.responses[:not_valid] = 'Passwords must be at least 8 characters in length. '
    end
  end

  def create_user(role)
    user = Staff.new
    user.role = role
    loop do
      user.first_name = ask('First Name? ') { |q| q.default = user.first_name }
      user.last_name = ask('Last Name? ') { |q| q.default = user.last_name }
      user.email = email?(user.email)
      user.phone = ask('Phone? ') { |q| q.default = user.phone }
      user.password = password?

      unless user.valid?
        say "<%= color('There are some problems with your choices.', [:bold, :red]) %>"
        user.errors.full_messages.each do |message|
          say "<%= color('#{message.gsub("'") { "\\'" }}', [:red]) %>"
        end
      end

      break user.valid? && agree?('Create record with these values? ')
    end

    user.save
  end

  desc 'Create a privileged user'
  task admin: :environment do
    create_user :admin
  end

  desc 'Create a user'
  task user: :environment do
    create_user :user
  end

  desc 'Create a setting'
  task setting: :environment do
    create_setting
  end

  def create_setting
    setting = Setting.new
    loop do
      setting.name = ask('Setting Value? ') { |q| q.default = setting.value }
      setting.value = ask('Setting Value? ') { |q| q.default = setting.value }
      unless setting.valid?
        say "<%= color('There are some problems with your choices.', [:bold, :red]) %>"
        setting.errors.full_messages.each do |message|
          say "<%= color('#{message.gsub("'") { "\\'" }}', [:red]) %>"
        end
      end
      break setting.valid? && agree?('Create setting with these values? ')
    end
    setting.save
  end

  desc 'TODO'
  task project: :environment do
  end

  desc 'TODO'
  task solution: :environment do
  end

  desc 'TODO'
  task application: :environment do
  end

end
