S3FileField.config do |c|
  c.access_key_id = ENV['AWS_ACCESS_KEY']
  c.secret_access_key = ENV['AWS_SECRET']
  c.bucket = ENV['AWS_BUCKET']
  # c.acl = "public-read"
  # c.expiration = 10.hours.from_now.utc.iso8601
  # c.max_file_size = 500.megabytes
  # c.conditions = []
  # c.key_starts_with = 'uploads/'
  # c.ssl = true # if true, force SSL connection
end