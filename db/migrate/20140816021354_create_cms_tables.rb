class CreateCmsTables < ActiveRecord::Migration
  def change
    
    create_table "cms_attributes", force: true do |t|
      t.string   "name",                        null: false
      t.string   "entity_type", default: "",    null: false
      t.string   "notes"
      t.boolean  "hidden",      default: false, null: false
      t.string   "metadata"
      t.string   "data_type",                   null: false
      t.integer  "sort",                        null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "cms_comments", force: true do |t|
      t.integer  "commentable_id",   null: false
      t.string   "commentable_type", null: false
      t.integer  "parent_id"
      t.integer  "user_id"
      t.string   "author"
      t.string   "email"
      t.string   "url"
      t.text     "content",          null: false
      t.integer  "rating",           null: false, default: 0
      t.boolean  "approved",         null: false
      t.boolean  "spam",             null: false
      t.string   "ip_address",       null: false
      t.string   "user_agent",       null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "cms_content_blocks", force: true do |t|
      t.string   "key",        null: false
      t.text     "content",    null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "cms_location_attributes", force: true do |t|
      t.integer  "location_id",  null: false
      t.integer  "attribute_id", null: false
      t.text     "value"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "cms_location_attributes", ["attribute_id"], name: "index_location_attributes_on_attribute_id", using: :btree
    add_index "cms_location_attributes", ["location_id"], name: "index_location_attributes_on_location_id", using: :btree

    create_table "cms_location_categories", force: true do |t|
      t.integer "location_id", null: false
      t.integer "category_id", null: false
    end

    add_index "cms_location_categories", ["category_id"], name: "index_location_categories_on_category_id", using: :btree
    add_index "cms_location_categories", ["location_id"], name: "index_location_categories_on_location_id", using: :btree

    create_table "cms_locations", force: true do |t|
      t.string   "name",                                                    null: false
      t.string   "slug",                                                    null: false
      t.string   "street1"
      t.string   "street2"
      t.string   "city"
      t.string   "state"
      t.string   "zip"
      t.string   "country"
      t.decimal  "latitude",       precision: 10, scale: 7
      t.decimal  "longitude",      precision: 10, scale: 7
      t.boolean  "hidden",                                                  null: false
      t.integer  "user_id"
      t.boolean  "default",                                 default: false, null: false
      t.integer  "region_id"
      t.integer  "affiliate_id"
      t.string   "contact_person"
      t.string   "phone"
      t.string   "fax"
      t.string   "email"
      t.string   "website"
      t.text     "summary"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "cms_locations", ["affiliate_id"], name: "index_locations_on_affiliate_id", using: :btree
    add_index "cms_locations", ["region_id"], name: "index_locations_on_region_id", using: :btree
    
    create_table "cms_menus", force: true do |t|
      t.string   "key",        null: false
      t.string   "title",      null: false
      t.string   "css_class"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "notes"
    end
    
    create_table "cms_pages", force: true do |t|
      t.string   "title",          null: false
      t.string   "slug",           null: false
      t.boolean  "published",      null: false
      t.text     "header_content"
      t.text     "body",           null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "cms_photo_albums", force: true do |t|
      t.string   "slug",           null: false
      t.integer  "user_id"
      t.boolean  "public",         null: false
      t.boolean  "allow_upload",   null: false
      t.boolean  "voting_enabled", null: false
      t.string   "title",          null: false
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "cms_pictures", force: true do |t|
      t.integer  "imageable_id"
      t.string   "imageable_type"
      t.integer  "user_id"
      t.integer  "sort"
      t.integer  "votes"
      t.string   "file_path"
      t.integer  "width"
      t.integer  "height"
      t.integer  "file_size"
      t.string   "mime_type"
      t.text     "caption"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "cms_pictures", ["user_id"], name: "index_pictures_on_user_id", using: :btree
    
    create_table "cms_regions", force: true do |t|
      t.string   "name"
      t.string   "slug"
      t.boolean  "default"
      t.boolean  "enabled"
      t.boolean  "hidden"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "cms_sublocations", force: true do |t|
      t.integer  "location_id"
      t.string   "name"
      t.string   "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "cms_sublocations", ["location_id"], name: "index_sub_locations_on_location_id", using: :btree
    
    create_table "cms_votes", force: true do |t|
      t.integer  "votable_id",   null: false
      t.string   "votable_type", null: false
      t.integer  "user_id"
      t.string   "ip_address",   null: false
      t.string   "cookie"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    
  end
end
