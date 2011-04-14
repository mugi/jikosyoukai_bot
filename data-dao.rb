require 'rubygems'
require 'sqlite3'

class DataDao
  
  def initialize()
    @database = SQLite3::Database::new("./database.sqlite3")
  end
  
  # 同じ定型文がすでに登録されているか調べる
  def check_exist(theme, item)
    sql = "SELECT rowid FROM template WHERE theme = '"+ theme +"' AND item = '"+ item +"';"
    return @database.get_first_value(sql)
  end
  
  def insert_item(theme, item)
    @database.execute("INSERT INTO template (theme, item) VALUES (?, ?)", theme, item)
  end
  
  # template テーブルから tweet 回数の最も少ない物を1つ抽出する
  def select_template_by_count_asc_limit_one
    # return @database.execute("SELECT rowid, * FROM template ORDER BY use_count ASC LIMIT 1;")
    sql = "SELECT rowid, * FROM template WHERE use_count IN (SELECT MIN(use_count) FROM template) ORDER BY RANDOM() LIMIT 1;"
    return @database.execute(sql )
  end
  
  def update_use_count(rowid, use_count)
    @database.execute("UPDATE template SET use_count = ? WHERE rowid = ?", use_count, rowid)
  end
=begin

  # 引数のパスの前回更新時間を取得する
  def get_updated_at_text_file(file_path)
    return @database.get_first_value("SELECT updated_at FROM text_file_manage WHERE file_path = ?", file_path)
  end
  
  def update_text_file_manage(updated_at, file_path)
    @database.execute("UPDATE text_file_manage SET updated_at = ? WHERE file_path = ?", updated_at, file_path)
  end
  
  def insert_text_file_manage(updated_at, file_path)
    @database.execute("INSERT INTO text_file_manage (updated_at, file_path) VALUES (?, ?)", updated_at, file_path)
  end
  
  # fixed テーブルの全てのカラムを取得する
  def select_fixed_by_all
    return @database.execute("SELECT text FROM fixed;")
  end
  
  # fixed テーブルからランダムに1件のデータを取得する
  def select_fixed_by_random_limit_one
    return @database.execute("SELECT text FROM fixed ORDER BY RANDOM() LIMIT 1;")
  end
  
=end
end
