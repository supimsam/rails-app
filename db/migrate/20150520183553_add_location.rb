class AddLocation < ActiveRecord::Migration
  def change
  	add_column :posts, :location, :string
  	add_column :posts, :event_type, :string
  end
end
