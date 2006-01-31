# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 2) do

  create_table "articles", :force => true do |t|
    t.column "article_id", :integer
    t.column "user_id", :integer
    t.column "title", :string
    t.column "permalink", :string
    t.column "summary", :text
    t.column "description", :text
    t.column "summary_html", :text
    t.column "description_html", :text
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "published_at", :datetime
    t.column "type", :string, :limit => 20
    t.column "author", :string, :limit => 100
    t.column "author_url", :string
    t.column "author_email", :string
    t.column "author_ip", :string, :limit => 100
    t.column "comments_count", :integer, :default => 0
  end

  create_table "cached_pages", :force => true do |t|
    t.column "url", :string
    t.column "references", :text
    t.column "updated_at", :datetime
  end

  create_table "taggings", :force => true do |t|
    t.column "article_id", :integer
    t.column "tag_id", :integer
    t.column "position", :integer, :default => 1
  end

  create_table "tags", :force => true do |t|
    t.column "name", :string
  end

  create_table "templates", :force => true do |t|
    t.column "name", :string
    t.column "data", :text
  end

  create_table "users", :force => true do |t|
    t.column "login", :string, :limit => 40
    t.column "email", :string, :limit => 100
    t.column "crypted_password", :string, :limit => 40
    t.column "salt", :string, :limit => 40
    t.column "activation_code", :string, :limit => 40
    t.column "activated_at", :datetime
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

end