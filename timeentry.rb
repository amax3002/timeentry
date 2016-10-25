require 'active_record'
require 'sqlite3'
require 'pry'

ActiveRecord::Base.establish_connection({
  adapter: 'sqlite3',
  database: 'dev.sqlite3'
  })

class InitialMigration < ActiveRecord::Migration[5.0]

  def up

    create_table :developers do |t|
      t.string :name
      t.string :email
      t.datetime :start_date
      t.integer :dev_type_id
    end

    create_table :dev_type do |t|
      t.string :type
    end

    create_table :projects do |t|
      t.string :name
      t.datetime :start_date
      t.integer :client_id
    end

    create_table :clients do |t|
      t.string :name
      t.integer :industry_id
    end

    create_table :industries do |t|
      t.string :name
    end

    create_table :time_entry do |t|
      t.integer :developer_id
      t.integer :project_id
      t.datetime :date_of_entry
      t.float :hours_worked
    end

    create_table :comment_type do |t|
      t.integer :developer_id
      t.integer :project_id
      t.integer :client_id
      t.integer :industry_id
      t.integer :comment_id
    end

    create_table :comments do |t|
      t.string :comment_input
      t.datetime :date_of_comment
    end

  end

  def down
    drop_table :developers
    drop_table :projects
    drop_table :clients
    drop_table :dev_type
    drop_table :industries
    drop_table :time_entry
    drop_table :comment_type
    drop_table :comments
  end

  begin
    InitialMigration.migrate(:down)
  rescue
  end

  InitialMigration.migrate(:up)

end
