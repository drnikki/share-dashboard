class ProjectRefresher

	# todo - make refresher class, extend project and URL refereshers.

	@queue = 'refresh'


 def self.perform
	require 'json' # for converting hash to json, duh.
	Urls.all.each do |record|
		#puts record.address
		puts record
		data = Urls.get_share_data record.address
		data = data.to_json
		puts data
		puts record
		record.update_attributes(data)
		#record.save
		puts 'saved-----'
	
	end
		
	
	p "i am the end of the perform function"
	# read this http://stackoverflow.com/questions/7041224/finding-mongodb-records-in-batches-using-mongoid-ruby-adapter
  end

end

