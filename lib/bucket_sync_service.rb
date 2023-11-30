# https://gist.github.com/edwardsharp/d501af263728eceb361ebba80d7fe324

require 'aws-sdk-s3'

class BucketSyncService
  attr_reader :from_bucket, :to_bucket, :logger
  attr_accessor :debug

  DEFAULT_ACL = "public-read"
  DEFAULT_CACHE_CONTROL = "public, max-age=31536000"


  def initialize(from_bucket, to_bucket)
    @from_bucket = bucket_from_credentials(from_bucket)
    @to_bucket   = bucket_from_credentials(to_bucket)
  end

  def perform(output=STDOUT)
    object_counts = {sync:0, skip:0}
    create_logger(output)

    logger.info "Starting sync."
    from_bucket.objects.each do |object|
      if object_needs_syncing?(object)
        sync(object)
        object_counts[:sync] += 1
      else
        logger.debug "Skipped #{pp object}"
        object_counts[:skip] += 1
      end
    end
    logger.info "Done. Synced #{object_counts[:sync]}, " +
      "skipped #{object_counts[:skip]}."
  end

  private

  def create_logger(output)
    @logger = Logger.new(output).tap do |l|
      l.level = debug ? Logger::DEBUG : Logger::INFO
    end
  end

  def sync(object)
    logger.debug "Syncing #{pp object}"
    to_bucket.object(object.key).copy_from(
      copy_source: "#{object.bucket_name}/#{object.key}",
      acl: DEFAULT_ACL,
      cache_control: DEFAULT_CACHE_CONTROL
    )
  end

  def pp(object)
    content_length_in_kb = object.content_length / 1024
    "#{object.key} #{content_length_in_kb}k " +
      "#{object.last_modified.strftime("%b %d %Y %H:%M")}"
  end

  def object_needs_syncing?(object)
    to_object = to_bucket.object(object.key)
    return true if !to_object.exists?

    return to_object.etag != object.etag
  end

  def bucket_from_credentials(bckt)
    bucket = Aws::S3::Bucket.new(bckt)
    unless bucket.exists?
      bucket = s3.bucket.create(bckt)
    end
    bucket
  end
end
