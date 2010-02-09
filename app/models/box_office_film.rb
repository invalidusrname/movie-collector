class BoxOfficeFilm < ActiveRecord::Base
  scope :top_films, :conditions => ['position is not null'], :order => :position
  scope :this_week, lambda { {:conditions => ['release_date BETWEEN ? AND ?', Date.today.beginning_of_week, Date.today.end_of_week], :order => 'release_date DESC' } }
end
