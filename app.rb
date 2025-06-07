# app.rb
require 'webrick'
require 'json'

# サーバ設定
server = WEBrick::HTTPServer.new(
  Port: 4567,
  DocumentRoot: './public', # 静的ファイルも今まで通り使える
  AccessLog: [],
  Logger: WEBrick::Log.new('/dev/null') # ログ抑制（任意）
)

# APIエンドポイント定義（例: GET /api/hello）
server.mount_proc '/api/hello' do |req, res|
  res['Content-Type'] = 'application/json'
  res.body = { message: 'Hello from API!' }.to_json
end

trap('INT') { server.shutdown }
server.start
