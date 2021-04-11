class CreateAttendance < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |a|
      a.string :name 
      a.string :content
      a.integer :user_id
    end
  end
end 