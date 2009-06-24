class BoxOfficeFilm < ActiveRecord::Base
  named_scope :top_films, :conditions => ['position is not null'], :order => :position
  named_scope :this_week, lambda { {:conditions => ['release_date BETWEEN ? AND ?', Date.today.beginning_of_week, Date.today.end_of_week], :order => :release_date } }
end
