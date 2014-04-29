class AddAttachmentPicsToAds < ActiveRecord::Migration
       def up
         change_table :ads do |t|
           t.attachment :pic1
         end
       end

       def down
         drop_attached_file :ads, :pic1
       end
end
