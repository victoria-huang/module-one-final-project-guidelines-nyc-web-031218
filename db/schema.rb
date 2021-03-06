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

ActiveRecord::Schema.define(version: 20180328191045) do

  create_table "doctors", force: :cascade do |t|
    t.string "name"
  end

  create_table "interactions", force: :cascade do |t|
    t.integer "med1_id"
    t.integer "med2_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
  end

  create_table "prescriptions", force: :cascade do |t|
    t.string "name"
    t.integer "rxcui"
    t.integer "patient_id"
    t.integer "doctor_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.string "note"
    t.integer "patient_id"
  end

end
