# frozen_string_literal: true

require 'shrine'

if Rails.env.development?
  require "shrine/storage/file_system"
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store")
  }
elsif Rails.env.test?
  require 'shrine/storage/memory'
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
else
  require 'shrine/storage/s3'
  s3_options = {
    # Required
    region:            ENV['AWS_REGION'],
    bucket:            ENV['AWS_BUCKET'],
    access_key_id:     ENV['AWS_ACCESS_KEY'],
    secret_access_key: ENV['AWS_SECRET_KEY'],
  }

  Shrine.storages = {
    # With Shrine both temporary (:cache) and permanent (:store) storage are first-class citizens and fully configurable, so you can also have files cached on S3.
    cache: Shrine::Storage::S3.new(prefix: 'cache', upload_options: { acl: 'public-read' }, **s3_options),
    store: Shrine::Storage::S3.new(prefix: 'store', upload_options: { acl: 'public-read' }, **s3_options),
  }
end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays
Shrine.plugin :restore_cached_data # re-extract metadata when attaching a cached file
