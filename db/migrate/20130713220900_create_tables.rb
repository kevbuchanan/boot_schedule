class CreateTables < ActiveRecord::Migration
  def change
    create_table :boots do |t|
      t.references :cohort
      t.string :first_name
      t.string :last_name
      t.string :email
      t.timestamps
    end

    create_table :cohorts do |t|
      t.string :name 
      t.date :start_date
      t.date :graduation_date
      t.timestamps
    end

    create_table :events do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.timestamps
    end

    create_table :cohorts_events do |t|
      t.references :cohort
      t.references :event
      t.timestamps
    end
  end
end