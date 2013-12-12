class CreateUsers < ActiveRecord::Migration
  def change # change is a method - change to be made to the database
    create_table :users do |t| 
    	# create_table is a Rails method to create a table in the database
    	# users is the table name
    	# t is the block variable (or) object
    	# Model name is User, but tablename is users -> multiple users stored 
      
      t.string :name   # column names
      t.string :email

      t.timestamps  # creates magic columns called created_at and updated_at
      				# they automatically record when a user is created and updated

      				# results of running the migration command - updates the development.sqlite file
    end
  end
end
