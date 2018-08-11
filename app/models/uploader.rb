require 'aws-sdk-s3'
class Uploader
  def self.upload_from_string(key, string)
    s3 = Aws::S3::Resource.new(region:'us-east-2')
    obj = s3.bucket('coulddo').object(key)
    obj.put(body: string)
  end
end