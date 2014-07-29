class Link
# This class corresponds to a table in the database
# We can use it to manipulate the data

	# this makes the instances of this class Datamapper resources
	include DataMapper::Resource

	# This block describes what resouces our model will have 
	property :id, 		Serial # Serial means that it will be auto-incremented for every record
	property :title,	String
	property :url, 		String
	has n, :tags, :through => Resource

end