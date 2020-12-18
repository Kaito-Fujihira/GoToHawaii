require "base64"
require "json"
require "net/https"

module Vision
  class << self
    def get_image_data(image_file)
      # APIのURL作成
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['API_KEY']}"

      # 画像をbase64にエンコード
      base64_image = Base64.encode64(open("#{Rails.root}/public/uploads/#{image_file.id}").read)

      # APIリクエスト用のJSONパラメータ
      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              type: "SAFE_SEARCH_DETECTION"     # WEB_DETECTION # LANDMARK_DETECTION
            }
          ]
        }]
      }.to_json

      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {"Referer" => "https://5b264ebb1996406d9f2e60258f35ca36.vfs.cloud9.ap-northeast-1.amazonaws.com/"})
      request["Content-Type"] = "application/json"
      response = https.request(request, params)
      # p  JSON.parse(response.body)["responses"][0]
      # APIレスポンス出力
      # JSON.parse(response.body)["responses"][0]["webDetection"]["webEntities"].pluck("description").take(3)
      JSON.parse(response.body)["responses"][0]["safeSearchAnnotation"].take(5)
    end
  end
end