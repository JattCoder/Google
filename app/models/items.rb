class Items < ActiveRecord::Base
    belongs_to :business
    scope :new_item, -> (info) { new(info) }
    scope :business_items, -> (business_id) { where(business_id: business_id) }

    def self.save_new_item(params)
        new_item = {
            :business_id => params[:biz_id].to_i,
            :name => params[:newname],
            :cost => params[:newcost].to_f,
            :image => params[:newimage],
            :discription => params[:newdiscription]
        }
        item = Items.new_item(new_item).save
    end
end