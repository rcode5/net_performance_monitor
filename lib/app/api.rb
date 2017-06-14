module NetworkSpeedGrapher
  module Api
    def self.included(base)

      def s3
        @s3 ||= S3Service.new bucket: ENV.fetch('AWS_BUCKET'), region: ENV.fetch('AWS_REGION')
      end

      base.get '/api/files/' do
        content_type :json
        @title = 'Network Report'
        s3.urls.to_json
      end

      base.get '/api/file/*' do
        content_type :json
        s3.get(params[:splat].first)
      end
    end

  end
end
