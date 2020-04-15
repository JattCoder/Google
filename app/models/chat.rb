class Chat < ActiveRecord::Base
    belongs_to :account
    scope :allchats, -> (location) { where(location: location) }
    #scope :participants, -> { where(color: 'red') }
    #scope :participants, -> { where(title: find_by(title: params[:title]).title, location: find_by(id: params[:id]).location) }
end