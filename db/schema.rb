# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_05_05_060745) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "milestones", force: :cascade do |t|
    t.bigint "project_id"
    t.string "name", null: false
    t.string "description"
    t.date "due_date"
    t.date "closed_date"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id", "name"], name: "index_milestones_on_project_id_and_name", unique: true
    t.index ["project_id"], name: "index_milestones_on_project_id"
  end

  create_table "mission_user_relationships", force: :cascade do |t|
    t.bigint "mission_id"
    t.bigint "user_id"
    t.integer "role", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mission_id"], name: "index_mission_user_relationships_on_mission_id"
    t.index ["user_id"], name: "index_mission_user_relationships_on_user_id"
  end

  create_table "missions", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_missions_on_name", unique: true
  end

  create_table "project_user_relationships", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.integer "role", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_user_relationships_on_project_id"
    t.index ["user_id"], name: "index_project_user_relationships_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "mission_id"
    t.string "name", null: false
    t.string "description"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mission_id", "name"], name: "index_projects_on_mission_id_and_name", unique: true
    t.index ["mission_id"], name: "index_projects_on_mission_id"
  end

  create_table "requirements", force: :cascade do |t|
    t.bigint "milestone_id"
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["milestone_id", "name"], name: "index_requirements_on_milestone_id_and_name", unique: true
    t.index ["milestone_id"], name: "index_requirements_on_milestone_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "requirement_id"
    t.string "name", null: false
    t.string "description"
    t.date "planned_start_date"
    t.date "planned_end_date"
    t.date "started_date"
    t.date "ended_date"
    t.integer "status", default: 0, null: false
    t.integer "costs", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["requirement_id"], name: "index_tickets_on_requirement_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "time_zone"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "milestones", "projects"
  add_foreign_key "mission_user_relationships", "missions"
  add_foreign_key "mission_user_relationships", "users"
  add_foreign_key "project_user_relationships", "projects"
  add_foreign_key "project_user_relationships", "users"
  add_foreign_key "projects", "missions"
  add_foreign_key "requirements", "milestones"
  add_foreign_key "tickets", "requirements"
end
