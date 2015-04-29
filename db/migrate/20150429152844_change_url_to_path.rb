class ChangeUrlToPath < ActiveRecord::Migration
  def change
    rename_column :pages, :url, :path
  end
end
