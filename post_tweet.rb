require 'rubygems'
require 'oauth'
require 'oauth-patch'
require 'data-dao'

data_dao = DataDao.new()

CONSUMER_KEY = "q1Wj2tcXz3klhAxy6iEQfg"
CONSUMER_SECRET = "f349jfmbYtNylfIyaAcdroykh7Vm2Q3HJxmRsj4fRc"
ACCESS_TOKEN = "278862666-1QvdIb1imWtgcCn5NqycE4QnQYl0FLxRaYpZ3ZvU"
ACCESS_TOKEN_SECRET = "vaxsksoBVEsgpUjOzKi2lYM3pc1a2PhFPDYcxdn2cU"

# 下準備
consumer = OAuth::Consumer.new(
  CONSUMER_KEY,
  CONSUMER_SECRET,
  :site => 'http://twitter.com'
)
access_token = OAuth::AccessToken.new(
  consumer,
  ACCESS_TOKEN,
  ACCESS_TOKEN_SECRET
)
# SELECT * FROM entry ORDER BY RANDOM();

# Tweetの投稿
result = data_dao.select_template_by_count_asc_limit_one # template テーブルから tweet 回数の最も少ない物を1つ抽出する
rowid = result[0][0]
theme = result[0][1]
item = result[0][2]
use_count = result[0][3] + 1

tweet = "はじめまして！ 好きな"+ theme +"は"+ item +"です！ よろしくお願いします！"
response = access_token.post(
  'http://twitter.com/statuses/update.json',
  'status'=> tweet
)
puts tweet # debug

data_dao.update_use_count(rowid, use_count) # 使用回数を +1 して UPDATE する
