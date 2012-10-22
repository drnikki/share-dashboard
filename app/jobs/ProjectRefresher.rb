class ProjectRefresher

	# todo - make refresher class, extend project and URL refereshers.
	@queue = 'refresh'

 def self.perform
	require 'json' # for converting hash to json, duh.
	Urls.all.each do |record|
		data = Urls.get_share_data record.address
		record.update_attributes(data)
	end

	p "i am the end of the perform function"
	# read this http://stackoverflow.com/questions/7041224/finding-mongodb-records-in-batches-using-mongoid-ruby-adapter
  end

end