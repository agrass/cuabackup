class UploadManager

	@@s3, @@bucket = nil
	

	def self.upload(file, name)
		begin
			self.login
			obj = @@bucket.objects[name]
			obj.write(file)
		rescue
			puts "\n Error UPLOADING FILE \n"
		end
	end

	def self.login
		@@s3 = AWS::S3.new(:access_key_id => 'AKIAJIPF2TICO2ZHQT7A',:secret_access_key => '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')
		@@bucket = @@s3.buckets['cua']
	end

	def self.get_s3
		return @@s3
	end

	def self.objects
		@@bucket.objects.each do |obj|
		  puts obj.key
		end
	end

end