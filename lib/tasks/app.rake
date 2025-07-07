require 'bucket_sync_service.rb'

namespace :app do
  desc 'Fix things'
  task fix: :environment do
  end

  namespace :bucket do
    desc 'Sync bucket to dev from Scaleway (staging)'
    task :staging do
      sync_bucket(ENV['SCALEWAY_OS_STAGING_BUCKET'])
    end

    desc 'Sync bucket to dev from Scaleway (production)'
    task :production do
      sync_bucket(ENV['SCALEWAY_OS_PRODUCTION_BUCKET'])
    end

    def sync_bucket(bucket_name)
      Aws.config.update({
        region: ENV['SCALEWAY_OS_REGION'],
        credentials: Aws::Credentials.new(ENV['SCALEWAY_OS_ACCESS_KEY_ID'], ENV['SCALEWAY_OS_SECRET_ACCESS_KEY']),
        endpoint: ENV['SCALEWAY_OS_ENDPOINT']
      })
      syncer = BucketSyncService.new(bucket_name, ENV['SCALEWAY_OS_BUCKET'])
      syncer.debug = true # log each object
      syncer.perform
    end
  end

  namespace :db do
    desc 'Get database from Scalingo (staging)'
    task :staging do
      load_db(ENV['SCALINGO_STAGING_APP_NAME'])
    end

    desc 'Get database from Scalingo (production)'
    task :production do
      load_db(ENV['SCALINGO_PRODUCTION_APP_NAME'])
    end

    def load_db(app_name)
      Bundler.with_unbundled_env do
        Dotenv.load
        addon_result = `scalingo addons --app #{app_name} | grep PostgreSQL`
        addon_id = addon_result.split('|')[2].strip
        sh "scalingo --app #{app_name} backups-create --addon #{addon_id}"
        sh "scalingo --app #{app_name} backups-download --addon #{addon_id} --output db/scalingo-dump.tar.gz"

        sh 'rm -f db/latest.dump' # Remove an old backup file if it exists
        sh 'tar zxvf db/scalingo-dump.tar.gz -C db/' # Extract the new backup archive
        sh 'rm db/scalingo-dump.tar.gz' # Remove the backup archive
        sh 'mv db/*.pgsql db/latest.dump' # Rename the backup file
        sh 'DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop'
        sh 'bundle exec rails db:create'
        begin
          sh 'pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d surlaroute_development db/latest.dump'
        rescue
          'There were some warnings or errors while restoring'
        end
        sh 'rails db:migrate'
        sh 'rails db:seed'
      end
    end
  end

  namespace :search do
    desc 'Reindex models for search'
    task reindex: :environment do
      [Actor, Tour].each do |model|
        puts "Reindexing #{model.count} #{model.model_name.human(count: 2)}"
        model.reindex
      end
    end
  end

end
