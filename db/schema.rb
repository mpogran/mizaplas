# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_20_033710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "folders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "list_ingredients", force: :cascade do |t|
    t.bigint "list_id", null: false
    t.bigint "ingredient_id", null: false
    t.decimal "quantity", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "closed_at"
    t.datetime "deleted_at"
    t.index ["ingredient_id"], name: "index_list_ingredients_on_ingredient_id"
    t.index ["list_id"], name: "index_list_ingredients_on_list_id"
  end

  create_table "list_recipes", force: :cascade do |t|
    t.bigint "list_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["list_id"], name: "index_list_recipes_on_list_id"
    t.index ["recipe_id"], name: "index_list_recipes_on_recipe_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "recipe_fields", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.string "type", null: false
    t.string "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["recipe_id"], name: "index_recipe_fields_on_recipe_id"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.bigint "folder_id"
    t.string "source"
    t.string "title"
    t.string "author"
    t.text "instructions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["folder_id"], name: "index_recipes_on_folder_id"
  end

  create_table "user_folders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "folder_id", null: false
    t.boolean "owner", default: false, null: false
    t.boolean "favorite", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["folder_id"], name: "index_user_folders_on_folder_id"
    t.index ["user_id"], name: "index_user_folders_on_user_id"
  end

  create_table "user_lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "list_id", null: false
    t.boolean "owner", default: false, null: false
    t.boolean "favorite", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["list_id"], name: "index_user_lists_on_list_id"
    t.index ["user_id"], name: "index_user_lists_on_user_id"
  end

  create_table "user_recipes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "recipe_id", null: false
    t.boolean "owner", default: false, null: false
    t.boolean "favorite", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["recipe_id"], name: "index_user_recipes_on_recipe_id"
    t.index ["user_id"], name: "index_user_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_foreign_key "list_ingredients", "ingredients"
  add_foreign_key "list_ingredients", "lists"
  add_foreign_key "list_recipes", "lists"
  add_foreign_key "list_recipes", "recipes"
  add_foreign_key "recipe_fields", "recipes"
  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipes", "folders"
  add_foreign_key "user_folders", "folders"
  add_foreign_key "user_folders", "users"
  add_foreign_key "user_lists", "lists"
  add_foreign_key "user_lists", "users"
  add_foreign_key "user_recipes", "recipes"
  add_foreign_key "user_recipes", "users"
end
