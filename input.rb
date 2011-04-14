require 'data-dao'

data_dao = DataDao.new()

puts "はじめまして！ 好きな〇〇は△△です！ よろしくお願いします！"
print "〇〇: "
theme = gets.chomp # コマンドラインで入力された値
print "△△: "
item = gets.chomp # コマンドラインで入力された値

# 受け取った値をデータベース(template テーブル)に格納する
if !data_dao.check_exist(theme, item) then # 入力値がすでに登録済みでないかのチェック
  data_dao.insert_item(theme, item) # データベースに入力値を保存する
  puts "登録しました。"
else
  puts "既に登録済みです。"
end
