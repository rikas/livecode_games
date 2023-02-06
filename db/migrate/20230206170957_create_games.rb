class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name, null: false # when saving you need to have a name
      t.string :genre
      t.integer :score, default: 0
      t.date :publishing_date

      t.timestamps
    end
  end
end


# model -> always singular: Game
# table -> always plural: games
# migration -> anything will work!

# 202329382837_change_users_to_new_version.rb
# class ChangeUsersToNewVersion
