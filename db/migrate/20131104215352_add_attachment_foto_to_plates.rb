class AddAttachmentFotoToPlates < ActiveRecord::Migration
  def self.up
    change_table :plates do |t|
      t.attachment :foto
    end
  end

  def self.down
    drop_attached_file :plates, :foto
  end
end
