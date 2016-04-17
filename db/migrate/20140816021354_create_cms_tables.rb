class CreateCmsTables < ActiveRecord::Migration
  def change

    create_table "cms_article_categories", force: :cascade do |t|
      t.integer "article_id",  limit: 4
      t.integer "category_id", limit: 4
    end

    add_index "cms_article_categories", ["article_id"], name: "index_cms_article_categories_on_article_id", using: :btree
    add_index "cms_article_categories", ["category_id"], name: "index_cms_article_categories_on_category_id", using: :btree

    create_table "cms_article_tags", force: :cascade do |t|
      t.integer "article_id", limit: 4
      t.integer "tag_id",     limit: 4
    end

    add_index "cms_article_tags", ["article_id"], name: "index_cms_article_tags_on_article_id", using: :btree
    add_index "cms_article_tags", ["tag_id"], name: "index_cms_article_tags_on_tag_id", using: :btree

    create_table "cms_articles", force: :cascade do |t|
      t.string   "title",          limit: 255,                   null: false
      t.string   "author",         limit: 255,                   null: false
      t.text     "body",           limit: 65535,                 null: false
      t.text     "excerpt",        limit: 65535,                 null: false
      t.string   "keywords",       limit: 255
      t.integer  "user_id",        limit: 4
      t.string   "slug",           limit: 255,                   null: false
      t.boolean  "allow_pings",                  default: false, null: false
      t.boolean  "allow_comments",               default: false, null: false
      t.date     "published_at"
      t.datetime "created_at",                                   null: false
      t.datetime "updated_at",                                   null: false
      t.string   "status",         limit: 255,                   null: false
      t.integer  "domain_id",      limit: 4
    end

    add_index "cms_articles", ["domain_id"], name: "index_cms_articles_on_domain_id", using: :btree
    add_index "cms_articles", ["user_id"], name: "index_cms_articles_on_user_id", using: :btree

    create_table "cms_comments", force: :cascade do |t|
      t.integer  "commentable_id",   limit: 4,                     null: false
      t.string   "commentable_type", limit: 255,                   null: false
      t.integer  "parent_id",        limit: 4
      t.integer  "user_id",          limit: 4
      t.string   "author",           limit: 255
      t.string   "email",            limit: 255
      t.string   "url",              limit: 255
      t.text     "content",          limit: 65535,                 null: false
      t.integer  "rating",           limit: 4
      t.boolean  "approved",                       default: false, null: false
      t.boolean  "spam",                           default: false, null: false
      t.string   "ip_address",       limit: 255,                   null: false
      t.string   "user_agent",       limit: 255,                   null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "cms_content_blocks", force: :cascade do |t|
      t.integer  "domain_id",  limit: 4,     null: false
      t.string   "key",        limit: 255,   null: false
      t.text     "content",    limit: 65535, null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "cms_faqs", force: :cascade do |t|
      t.integer  "domain_id",   limit: 4
      t.integer  "sort",        limit: 4,     null: false
      t.string   "question",    limit: 255,   null: false
      t.text     "answer",      limit: 65535, null: false
      t.integer  "category_id", limit: 4
      t.datetime "created_at",                null: false
      t.datetime "updated_at",                null: false
    end

    add_index "cms_faqs", ["category_id"], name: "index_cms_faqs_on_category_id", using: :btree

    create_table "cms_location_attributes", force: :cascade do |t|
      t.integer  "location_id",  limit: 4,     null: false
      t.integer  "attribute_id", limit: 4,     null: false
      t.text     "value",        limit: 65535
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "cms_location_attributes", ["attribute_id"], name: "index_location_attributes_on_attribute_id", using: :btree
    add_index "cms_location_attributes", ["location_id"], name: "index_location_attributes_on_location_id", using: :btree

    create_table "cms_location_categories", force: :cascade do |t|
      t.integer "location_id", limit: 4, null: false
      t.integer "category_id", limit: 4, null: false
    end

    add_index "cms_location_categories", ["category_id"], name: "index_location_categories_on_category_id", using: :btree
    add_index "cms_location_categories", ["location_id"], name: "index_location_categories_on_location_id", using: :btree

    create_table "cms_locations", force: :cascade do |t|
      t.string   "name",           limit: 255,                                            null: false
      t.string   "slug",           limit: 255,                                            null: false
      t.string   "street1",        limit: 255
      t.string   "street2",        limit: 255
      t.string   "city",           limit: 255
      t.string   "state",          limit: 255
      t.string   "zip",            limit: 255
      t.string   "country",        limit: 255
      t.decimal  "latitude",                     precision: 10, scale: 7
      t.decimal  "longitude",                    precision: 10, scale: 7
      t.boolean  "hidden",                                                default: false
      t.integer  "user_id",        limit: 4
      t.boolean  "default",                                               default: false, null: false
      t.integer  "region_id",      limit: 4
      t.integer  "affiliate_id",   limit: 4
      t.string   "contact_person", limit: 255
      t.string   "phone",          limit: 255
      t.string   "fax",            limit: 255
      t.string   "email",          limit: 255
      t.string   "website",        limit: 255
      t.text     "summary",        limit: 65535
      t.text     "description",    limit: 65535
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "cms_locations", ["affiliate_id"], name: "index_locations_on_affiliate_id", using: :btree
    add_index "cms_locations", ["region_id"], name: "index_locations_on_region_id", using: :btree

    create_table "cms_menu_items", force: :cascade do |t|
      t.integer  "menu_id",    limit: 4
      t.string   "title",      limit: 255,                null: false
      t.string   "link_url",   limit: 255,                null: false
      t.integer  "sort",       limit: 4,                  null: false
      t.boolean  "enabled",                default: true, null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "cms_menu_items", ["menu_id"], name: "index_cms_enu_items_on_menu_id", using: :btree

    create_table "cms_menus", force: :cascade do |t|
      t.integer  "domain_id",  limit: 4,     null: false
      t.string   "key",        limit: 255,   null: false
      t.string   "title",      limit: 255,   null: false
      t.string   "css_class",  limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "notes",      limit: 65535
    end

    create_table "cms_pages", force: :cascade do |t|
      t.integer  "domain_id",      limit: 4,     null: false
      t.string   "title",          limit: 255,   null: false
      t.string   "slug",           limit: 255,   null: false
      t.boolean  "published",                    null: false
      t.text     "header_content", limit: 65535
      t.text     "body",           limit: 65535, null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "cms_photo_albums", force: :cascade do |t|
      t.string   "slug",           limit: 255,   null: false
      t.integer  "user_id",        limit: 4
      t.boolean  "public",                       null: false
      t.boolean  "allow_upload",                 null: false
      t.boolean  "voting_enabled",               null: false
      t.string   "title",          limit: 255,   null: false
      t.text     "description",    limit: 65535
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "cms_pictures", force: :cascade do |t|
      t.integer  "imageable_id",       limit: 4
      t.string   "imageable_type",     limit: 255
      t.integer  "user_id",            limit: 4
      t.integer  "sort",               limit: 4
      t.integer  "votes",              limit: 4
      t.string   "file_path",          limit: 255
      t.integer  "width",              limit: 4
      t.integer  "height",             limit: 4
      t.integer  "file_size",          limit: 4
      t.string   "format",             limit: 255
      t.text     "caption",            limit: 65535
      t.text     "description",        limit: 65535
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "bits_per_pixel",     limit: 4
      t.string   "chroma_subsampling", limit: 255
      t.string   "compression_mode",   limit: 255
      t.boolean  "approved",                         default: true, null: false
      t.string   "data1",              limit: 255
      t.string   "data2",              limit: 255
    end

    add_index "cms_pictures", ["user_id"], name: "index_pictures_on_user_id", using: :btree

    create_table "cms_regions", force: :cascade do |t|
      t.string   "name",        limit: 255
      t.string   "slug",        limit: 255
      t.boolean  "default"
      t.boolean  "enabled"
      t.boolean  "hidden"
      t.text     "description", limit: 65535
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "cms_sublocations", force: :cascade do |t|
      t.integer  "location_id", limit: 4
      t.string   "name",        limit: 255
      t.string   "description", limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "cms_sublocations", ["location_id"], name: "index_sub_locations_on_location_id", using: :btree

    create_table "cms_tags", force: :cascade do |t|
      t.string   "name",       limit: 255, null: false
      t.datetime "created_at",             null: false
      t.datetime "updated_at",             null: false
    end

    create_table "cms_votes", force: :cascade do |t|
      t.integer  "votable_id",   limit: 4,   null: false
      t.string   "votable_type", limit: 255, null: false
      t.integer  "user_id",      limit: 4
      t.string   "ip_address",   limit: 255, null: false
      t.string   "cookie",       limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
  end
end
