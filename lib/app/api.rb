module NetworkSpeedGrapher
  module Api
    def self.included(base)

      base.get '/api/files/' do
        content_type :json
        @title = 'Network Report'
        s3.files.to_json
      end

      base.get '/api/file/*' do
        content_type :json
        s3.get(params[:splat].first)
      end
    end

  end
end
