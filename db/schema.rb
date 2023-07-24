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

ActiveRecord::Schema.define(version: 2023_05_08_030203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "full_name"
    t.string "postcode"
    t.string "address1"
    t.string "address2"
    t.string "telephone"
    t.datetime "deleted_at"
    t.boolean "is_default", default: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "admin_settings", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
  end

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "phone_number"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "agencies", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "address"
    t.string "contact_address"
    t.string "person"
    t.boolean "is_free", default: false
    t.bigint "fee_shipping"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
    t.string "company_name"
  end

  create_table "agency_deliveries", force: :cascade do |t|
    t.bigint "delivery_id"
    t.bigint "agency_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agency_id"], name: "index_agency_deliveries_on_agency_id"
    t.index ["delivery_id"], name: "index_agency_deliveries_on_delivery_id"
  end

  create_table "agency_payments", force: :cascade do |t|
    t.bigint "agency_id"
    t.bigint "payment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agency_id"], name: "index_agency_payments_on_agency_id"
    t.index ["payment_id"], name: "index_agency_payments_on_payment_id"
  end

  create_table "area_settings", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "assets", force: :cascade do |t|
    t.integer "type"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url"
    t.string "file_type"
  end

  create_table "assets_modules", force: :cascade do |t|
    t.string "module_type", null: false
    t.bigint "module_id", null: false
    t.bigint "asset_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["asset_id"], name: "index_assets_modules_on_asset_id"
    t.index ["module_type", "module_id"], name: "index_assets_modules_on_module"
  end

  create_table "banner_prefectures", force: :cascade do |t|
    t.bigint "banner_id"
    t.bigint "prefecture_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["banner_id"], name: "index_banner_prefectures_on_banner_id"
    t.index ["prefecture_id"], name: "index_banner_prefectures_on_prefecture_id"
  end

  create_table "banner_requests", force: :cascade do |t|
    t.bigint "banner_id", null: false
    t.bigint "user_id"
    t.string "name"
    t.string "postal_code"
    t.string "address1"
    t.string "address2"
    t.string "phone_number"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["banner_id"], name: "index_banner_requests_on_banner_id"
    t.index ["user_id"], name: "index_banner_requests_on_user_id"
  end

  create_table "banners", force: :cascade do |t|
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.integer "option", default: 1
    t.date "start_date"
    t.date "end_date"
    t.text "content"
    t.string "telephone"
    t.string "company_name"
    t.string "email"
    t.boolean "is_show", default: true
  end

  create_table "campaign_products", force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "product_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["campaign_id"], name: "index_campaign_products_on_campaign_id"
    t.index ["product_id"], name: "index_campaign_products_on_product_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "name"
    t.integer "ranking"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.string "code"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "ranking"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
  end

  create_table "comments", force: :cascade do |t|
    t.string "contents"
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.integer "comment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "comment_type"
    t.index ["comment_id"], name: "index_comments_on_comment_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "company_branches", force: :cascade do |t|
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "company_departments", force: :cascade do |t|
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "company_staffs", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.bigint "company_branch_id"
    t.bigint "company_department_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "staff_password"
    t.index ["company_branch_id"], name: "index_company_staffs_on_company_branch_id"
    t.index ["company_department_id"], name: "index_company_staffs_on_company_department_id"
  end

  create_table "contact_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.text "contents"
    t.string "phone_number"
    t.string "email"
    t.integer "status", default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user"
    t.integer "contact_category_id"
    t.string "furigana"
    t.string "todo"
    t.string "code"
  end

  create_table "coordinates", force: :cascade do |t|
    t.string "module_type"
    t.bigint "module_id"
    t.float "latitude"
    t.float "longitude"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["module_type", "module_id"], name: "index_coordinates_on_module"
  end

  create_table "coupon_orders", force: :cascade do |t|
    t.bigint "coupon_id", null: false
    t.bigint "order_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coupon_id"], name: "index_coupon_orders_on_coupon_id"
    t.index ["order_id"], name: "index_coupon_orders_on_order_id"
  end

  create_table "coupon_tour_prefectures", force: :cascade do |t|
    t.bigint "coupon_tour_id"
    t.bigint "prefecture_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coupon_tour_id"], name: "index_coupon_tour_prefectures_on_coupon_tour_id"
    t.index ["prefecture_id"], name: "index_coupon_tour_prefectures_on_prefecture_id"
  end

  create_table "coupon_tours", force: :cascade do |t|
    t.date "start_time"
    t.date "end_time"
    t.date "publish_date"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "tour_id"
    t.integer "type_coupon", default: 0
    t.integer "tour_coupon_id"
    t.index ["tour_id"], name: "index_coupon_tours_on_tour_id"
  end

  create_table "coupon_users", force: :cascade do |t|
    t.bigint "coupon_id"
    t.bigint "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coupon_id"], name: "index_coupon_users_on_coupon_id"
    t.index ["user_id"], name: "index_coupon_users_on_user_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.date "start_time"
    t.date "end_time"
    t.date "publish_date"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_notice"
    t.float "price"
    t.bigint "coupon_tour_id"
    t.index ["coupon_tour_id"], name: "index_coupons_on_coupon_tour_id"
  end

  create_table "coupons_modules", force: :cascade do |t|
    t.string "module_type", null: false
    t.bigint "module_id", null: false
    t.bigint "coupon_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.index ["coupon_id"], name: "index_coupons_modules_on_coupon_id"
    t.index ["module_type", "module_id"], name: "index_coupons_modules_on_module"
  end

  create_table "coupons_prefectures", force: :cascade do |t|
    t.bigint "coupon_id"
    t.bigint "prefecture_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coupon_id"], name: "index_coupons_prefectures_on_coupon_id"
    t.index ["prefecture_id"], name: "index_coupons_prefectures_on_prefecture_id"
  end

  create_table "credits", force: :cascade do |t|
    t.bigint "user_id"
    t.string "customer_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_credits_on_user_id"
  end

  create_table "deliveries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "delivery_time_settings", force: :cascade do |t|
    t.bigint "product_id"
    t.time "start_time"
    t.time "end_time"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_delivery_time_settings_on_product_id"
  end

  create_table "departments_permissions", force: :cascade do |t|
    t.bigint "company_department_id"
    t.bigint "permission_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_department_id"], name: "index_departments_permissions_on_company_department_id"
    t.index ["permission_id"], name: "index_departments_permissions_on_permission_id"
  end

  create_table "devices", force: :cascade do |t|
    t.bigint "user_id"
    t.string "os"
    t.string "device_token"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "diary_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "background_color"
    t.integer "index"
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.bigint "prefecture_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
    t.index ["prefecture_id"], name: "index_districts_on_prefecture_id"
  end

  create_table "ecommerce_coupon_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "coupon_id"
    t.boolean "is_used", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coupon_id"], name: "index_ecommerce_coupon_users_on_coupon_id"
    t.index ["user_id"], name: "index_ecommerce_coupon_users_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fortunes", force: :cascade do |t|
    t.string "fortune_type"
    t.string "title"
    t.string "sign"
    t.string "param"
    t.string "image"
    t.text "text"
    t.integer "rank"
    t.string "color"
    t.string "item"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date"
  end

  create_table "holidays", force: :cascade do |t|
    t.string "holiday_name"
    t.date "date"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hotel_cancellation_details", force: :cascade do |t|
    t.bigint "hotel_cancellation_policy_id"
    t.bigint "flg1"
    t.bigint "flg2"
    t.float "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.integer "unit", default: 1
    t.datetime "deleted_at"
    t.index ["hotel_cancellation_policy_id"], name: "hotel_cancellation_policy_index"
  end

  create_table "hotel_cancellation_policies", force: :cascade do |t|
    t.bigint "hotel_id"
    t.string "cxl_management_name"
    t.bigint "date_free_cancellation"
    t.boolean "is_use", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["hotel_id"], name: "index_hotel_cancellation_policies_on_hotel_id"
  end

  create_table "hotel_categories", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hotel_children_infos", force: :cascade do |t|
    t.bigint "hotel_id"
    t.bigint "fee", default: 0
    t.integer "unit"
    t.integer "capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "is_accept", default: 0
    t.string "name"
    t.string "code"
    t.datetime "deleted_at"
    t.index ["hotel_id"], name: "index_hotel_children_infos_on_hotel_id"
  end

  create_table "hotel_meals", force: :cascade do |t|
    t.bigint "hotel_id"
    t.string "management_name"
    t.string "name"
    t.integer "type", default: 0
    t.boolean "is_used", default: false
    t.string "description"
    t.string "address"
    t.string "start_time"
    t.string "end_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["hotel_id"], name: "index_hotel_meals_on_hotel_id"
  end

  create_table "hotel_options", force: :cascade do |t|
    t.bigint "hotel_id"
    t.string "management_name"
    t.string "name"
    t.float "price"
    t.boolean "is_use", default: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "unit", default: 1
    t.datetime "deleted_at"
    t.index ["hotel_id"], name: "index_hotel_options_on_hotel_id"
  end

  create_table "hotel_order_accompanies", force: :cascade do |t|
    t.boolean "is_owner", default: false
    t.integer "gender", default: 0
    t.string "postal_code"
    t.string "phone_number"
    t.string "telephone"
    t.string "address1"
    t.string "address2"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "birth_day"
    t.string "first_name"
    t.string "last_name"
    t.string "first_name_kana"
    t.string "last_name_kana"
    t.datetime "deleted_at"
  end

  create_table "hotel_order_logs", force: :cascade do |t|
    t.bigint "hotel_order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "hotel_id"
    t.bigint "hotel_room_id"
    t.jsonb "hotel_order_params"
    t.bigint "hotel_plan_id"
    t.jsonb "plan"
    t.jsonb "hotel"
    t.jsonb "room"
    t.jsonb "hotel_order_info"
    t.datetime "deleted_at"
    t.index ["hotel_id"], name: "index_hotel_order_logs_on_hotel_id"
    t.index ["hotel_order_id"], name: "index_hotel_order_logs_on_hotel_order_id"
    t.index ["hotel_plan_id"], name: "index_hotel_order_logs_on_hotel_plan_id"
    t.index ["hotel_room_id"], name: "index_hotel_order_logs_on_hotel_room_id"
  end

  create_table "hotel_orders", force: :cascade do |t|
    t.string "order_no"
    t.bigint "hotel_id"
    t.bigint "user_id"
    t.bigint "hotel_plan_id"
    t.bigint "hotel_order_accompany_id"
    t.integer "status", default: 0
    t.string "check_in"
    t.string "check_out"
    t.bigint "coupon_id"
    t.integer "cancellation_type"
    t.boolean "cancellation_free"
    t.integer "people_per_room"
    t.integer "number_of_rooms"
    t.integer "total_peoples"
    t.string "people_statistic"
    t.integer "used_points"
    t.integer "discount_amount"
    t.integer "reservation_amount"
    t.integer "tax_service"
    t.integer "total"
    t.integer "payment_method"
    t.string "registration_pattern"
    t.string "registrar_name"
    t.string "phone_reciprocal_time"
    t.string "manifest"
    t.string "option_ids", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number_night"
    t.integer "adult_total"
    t.integer "person_total"
    t.jsonb "childrens"
    t.integer "price_room", default: 0
    t.integer "price_option", default: 0
    t.integer "price_sale_off_stay_night", default: 0
    t.integer "price_children", default: 0
    t.string "time_estimate"
    t.string "comments"
    t.integer "payment_status"
    t.string "payment_note"
    t.bigint "hotel_room_id"
    t.date "date_cancel"
    t.string "purchased_id"
    t.integer "cancellation_fee"
    t.bigint "user_contact_id"
    t.integer "total_room", default: 1
    t.datetime "deleted_at"
    t.string "cancellation_other_reason"
    t.index ["coupon_id"], name: "index_hotel_orders_on_coupon_id"
    t.index ["hotel_id"], name: "index_hotel_orders_on_hotel_id"
    t.index ["hotel_order_accompany_id"], name: "index_hotel_orders_on_hotel_order_accompany_id"
    t.index ["hotel_plan_id"], name: "index_hotel_orders_on_hotel_plan_id"
    t.index ["hotel_room_id"], name: "index_hotel_orders_on_hotel_room_id"
    t.index ["user_contact_id"], name: "index_hotel_orders_on_user_contact_id"
    t.index ["user_id"], name: "index_hotel_orders_on_user_id"
  end

  create_table "hotel_plan_children", force: :cascade do |t|
    t.bigint "hotel_plan_id"
    t.bigint "hotel_children_info_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["hotel_children_info_id"], name: "index_hotel_plan_children_on_hotel_children_info_id"
    t.index ["hotel_plan_id"], name: "index_hotel_plan_children_on_hotel_plan_id"
  end

  create_table "hotel_plan_options", force: :cascade do |t|
    t.bigint "hotel_plan_id"
    t.bigint "hotel_option_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "hotel_meal_id"
    t.date "start_date_stay"
    t.date "end_date_stay"
    t.string "room_ids", default: [], array: true
    t.datetime "deleted_at"
    t.index ["hotel_meal_id"], name: "index_hotel_plan_options_on_hotel_meal_id"
    t.index ["hotel_option_id"], name: "index_hotel_plan_options_on_hotel_option_id"
    t.index ["hotel_plan_id"], name: "index_hotel_plan_options_on_hotel_plan_id"
  end

  create_table "hotel_plans", force: :cascade do |t|
    t.string "management_name"
    t.string "name"
    t.integer "type_plan", default: 0
    t.integer "setting_show", default: 0
    t.string "setting_payments"
    t.date "start_stay_date"
    t.date "end_stay_date"
    t.integer "hotel_meal_id"
    t.bigint "hotel_cancellation_policy_id"
    t.boolean "is_use_coupon", default: false
    t.bigint "point_receive"
    t.bigint "exp_point_receive"
    t.integer "point_bonus"
    t.integer "exp_point_bonus", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "hotel_id"
    t.bigint "day_hidden"
    t.integer "setting_limit"
    t.bigint "room_limit"
    t.integer "setting_number_night_stay"
    t.bigint "from_night"
    t.bigint "to_night"
    t.integer "setting_limit_room"
    t.bigint "from_room"
    t.bigint "to_room"
    t.integer "is_sale_off"
    t.integer "setting_check_in_out"
    t.string "check_in"
    t.string "check_out"
    t.integer "setting_children"
    t.string "option_ids", default: [], array: true
    t.string "setting_sale_off", default: [], array: true
    t.bigint "rate_type"
    t.bigint "settlement_date"
    t.string "settlement_time"
    t.bigint "credit_card_transaction_fee"
    t.string "type_meal", default: [], array: true
    t.string "payments", default: [], array: true
    t.datetime "deleted_at"
    t.index ["hotel_cancellation_policy_id"], name: "index_hotel_plans_on_hotel_cancellation_policy_id"
    t.index ["hotel_id"], name: "index_hotel_plans_on_hotel_id"
  end

  create_table "hotel_requests", force: :cascade do |t|
    t.bigint "hotel_id"
    t.bigint "hotel_plan_id"
    t.bigint "hotel_room_id"
    t.string "full_name"
    t.string "phone_number"
    t.string "email"
    t.date "check_in"
    t.date "check_out"
    t.integer "total_person"
    t.integer "total_room"
    t.integer "room_type"
    t.string "comments"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.string "request_no"
    t.datetime "deleted_at"
    t.index ["hotel_id"], name: "index_hotel_requests_on_hotel_id"
    t.index ["hotel_plan_id"], name: "index_hotel_requests_on_hotel_plan_id"
    t.index ["hotel_room_id"], name: "index_hotel_requests_on_hotel_room_id"
  end

  create_table "hotel_room_settings", force: :cascade do |t|
    t.bigint "hotel_plan_id", null: false
    t.bigint "hotel_room_id", null: false
    t.date "date"
    t.integer "remain_room"
    t.integer "reservation_number"
    t.bigint "one_person_fee", default: 0
    t.bigint "two_people_fee", default: 0
    t.bigint "three_people_fee", default: 0
    t.bigint "four_people_fee", default: 0
    t.bigint "five_people_fee", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "six_person_fee", default: 0
    t.bigint "seven_person_fee", default: 0
    t.bigint "eight_person_fee", default: 0
    t.bigint "nine_person_fee", default: 0
    t.bigint "ten_person_fee", default: 0
    t.integer "status", default: 0
    t.bigint "hotel_plan_option_id"
    t.datetime "deleted_at"
    t.index ["hotel_plan_id"], name: "index_hotel_room_settings_on_hotel_plan_id"
    t.index ["hotel_plan_option_id"], name: "index_hotel_room_settings_on_hotel_plan_option_id"
    t.index ["hotel_room_id"], name: "index_hotel_room_settings_on_hotel_room_id"
  end

  create_table "hotel_rooms", force: :cascade do |t|
    t.bigint "hotel_id"
    t.string "name"
    t.date "setting_date"
    t.string "management_name"
    t.integer "floor_number"
    t.string "description"
    t.integer "capacity"
    t.string "floor_plan"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_show", default: false
    t.integer "is_smoking", default: 0
    t.integer "floor_type", default: 0
    t.float "square_meter_max"
    t.float "square_meter_min"
    t.bigint "total_floor_max"
    t.bigint "total_floor_min"
    t.integer "room_type", default: 0
    t.integer "number_children"
    t.datetime "deleted_at"
    t.index ["hotel_id"], name: "index_hotel_rooms_on_hotel_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name", null: false
    t.string "yomigana"
    t.string "postal_code"
    t.string "telephone"
    t.float "web_comm_fee"
    t.string "address1"
    t.string "address2"
    t.string "manager"
    t.string "contact_info"
    t.string "representative"
    t.integer "status", default: 0
    t.integer "prefecture_id"
    t.integer "area_setting_id"
    t.integer "hotel_category_id"
    t.string "fax_number"
    t.date "opening_date"
    t.date "refurbished_date"
    t.bigint "room_total"
    t.string "manager_info"
    t.float "reservation_comm_fee"
    t.float "purchased_fee"
    t.float "credit_settlement_fee"
    t.string "pr_desc"
    t.string "access_desc"
    t.string "parking_desc"
    t.jsonb "feature_options"
    t.jsonb "amenity_options"
    t.integer "tax_service", default: 0
    t.string "tax_information"
    t.string "children_information"
    t.string "pet_information"
    t.string "other_information"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "payment_options"
    t.string "check_in"
    t.string "check_out"
    t.integer "accommodation_tax_rate"
    t.integer "allow_children"
    t.integer "allow_pet"
    t.datetime "deleted_at"
    t.bigint "hotel_cancellation_policy_id"
    t.string "email"
    t.index ["hotel_cancellation_policy_id"], name: "index_hotels_on_hotel_cancellation_policy_id"
  end

  create_table "life_support_prefectures", force: :cascade do |t|
    t.bigint "life_support_id"
    t.bigint "prefecture_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["life_support_id"], name: "index_life_support_prefectures_on_life_support_id"
    t.index ["prefecture_id"], name: "index_life_support_prefectures_on_prefecture_id"
  end

  create_table "life_support_requests", force: :cascade do |t|
    t.bigint "life_support_id", null: false
    t.bigint "user_id"
    t.string "name"
    t.string "postal_code"
    t.string "address1"
    t.string "address2"
    t.string "phone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.index ["life_support_id"], name: "index_life_support_requests_on_life_support_id"
    t.index ["user_id"], name: "index_life_support_requests_on_user_id"
  end

  create_table "life_supports", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.text "content"
    t.string "telephone"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "option", default: 1
    t.string "company_name"
    t.string "email"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "news", force: :cascade do |t|
    t.string "name"
    t.datetime "published_at"
    t.string "title"
    t.string "url"
    t.string "url_to_image"
    t.string "author"
    t.text "content"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "news_category_id"
    t.datetime "deleted_at"
    t.index ["news_category_id"], name: "index_news_on_news_category_id"
  end

  create_table "news_categories", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "send_all"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "gender"
    t.boolean "is_gender", default: false
    t.boolean "is_prefecture", default: false
    t.string "module_type"
    t.bigint "module_id"
    t.datetime "deleted_at"
    t.text "month_birthday", default: [], array: true
    t.boolean "is_resend", default: false
    t.index ["module_type", "module_id"], name: "index_notifications_on_module"
  end

  create_table "notifications_prefectures", force: :cascade do |t|
    t.bigint "prefecture_id", null: false
    t.bigint "notification_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["notification_id"], name: "index_notifications_prefectures_on_notification_id"
    t.index ["prefecture_id"], name: "index_notifications_prefectures_on_prefecture_id"
  end

  create_table "order_infos", force: :cascade do |t|
    t.bigint "order_id"
    t.date "delivery_date"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.time "delivery_start_time"
    t.time "delivery_end_time"
    t.string "content"
    t.bigint "address_id"
    t.string "email_receiption"
    t.string "buy_name"
    t.index ["address_id"], name: "index_order_infos_on_address_id"
    t.index ["order_id"], name: "index_order_infos_on_order_id"
  end

  create_table "order_logs", force: :cascade do |t|
    t.jsonb "product", default: {}
    t.jsonb "product_size", default: {}
    t.bigint "order_products_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_products_id"], name: "index_order_logs_on_order_products_id"
  end

  create_table "order_products", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.float "price"
    t.integer "number"
    t.float "purchased_amount"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "discount", default: 100.0
    t.string "color"
    t.integer "product_size_id"
    t.index ["order_id"], name: "index_order_products_on_order_id"
    t.index ["product_id"], name: "index_order_products_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "code"
    t.bigint "user_id"
    t.float "purchased_amount"
    t.float "delivery_amount"
    t.integer "payment_status"
    t.integer "delivery_status"
    t.integer "order_status"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "checkout_date"
    t.integer "coupon_id"
    t.integer "agency_id"
    t.integer "delivery_id"
    t.integer "payment_id"
    t.string "delivery_code"
    t.date "delivered_date"
    t.float "coupon_amount"
    t.float "received_point"
    t.string "purchased_id"
    t.float "used_point"
    t.float "received_bonus_point"
    t.float "delivery_charges_fee"
    t.integer "delivery_free_amount"
    t.index ["code"], name: "index_orders_on_code"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "module_name"
    t.string "action"
    t.string "description"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "point_usages", force: :cascade do |t|
    t.string "module_type", null: false
    t.bigint "module_id", null: false
    t.float "used_point"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.float "received_point"
    t.integer "type_point", default: 0
    t.string "title"
    t.string "description"
    t.date "start_date"
    t.date "end_date"
    t.boolean "is_received", default: false
    t.date "exp_start_date"
    t.date "exp_end_date"
    t.integer "status", default: 0
    t.datetime "received_date"
    t.index ["module_type", "module_id"], name: "index_point_usages_on_module"
    t.index ["user_id"], name: "index_point_usages_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "contents"
    t.bigint "user_id", null: false
    t.integer "like_count", default: 0
    t.integer "diary_category_id"
    t.string "background_color"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "type_post", default: 1
    t.string "location"
    t.integer "status", default: 0
    t.index ["diary_category_id"], name: "index_posts_on_diary_category_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
    t.string "prefecture_jis_code"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "location_area_id"
    t.bigint "area_setting_id"
    t.index ["area_setting_id"], name: "index_prefectures_on_area_setting_id"
  end

  create_table "product_area_settings", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "area_setting_id"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["area_setting_id"], name: "index_product_area_settings_on_area_setting_id"
    t.index ["product_id"], name: "index_product_area_settings_on_product_id"
  end

  create_table "product_sizes", force: :cascade do |t|
    t.bigint "product_id"
    t.string "name"
    t.float "price"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "remaining_count"
    t.boolean "is_limit", default: false
    t.boolean "is_product_size", default: true
    t.string "option_size_name"
    t.boolean "is_color_name", default: true
    t.string "option_color_name"
    t.string "color_name"
    t.index ["product_id"], name: "index_product_sizes_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "category_id"
    t.string "code"
    t.string "name"
    t.text "description"
    t.float "discount"
    t.boolean "is_discount", default: false
    t.string "colors"
    t.integer "remaining_count", default: 0
    t.text "description_info"
    t.string "brand"
    t.string "original_country"
    t.string "distributor"
    t.string "precaution"
    t.bigint "desired_delivery_date"
    t.string "hash_tag"
    t.boolean "is_show", default: true
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_limit", default: false
    t.string "exp_date"
    t.boolean "is_delivery_free", default: false
    t.boolean "is_desired_date_free", default: false
    t.boolean "is_desired_time_free", default: false
    t.boolean "is_color", default: false
    t.bigint "agency_id"
    t.integer "tax", default: 10
    t.boolean "is_product_size", default: true
    t.text "shipping_memo"
    t.text "shipping_others"
    t.integer "point_bonus"
    t.date "point_start_date"
    t.date "point_end_date"
    t.string "option_name"
    t.float "delivery_charges_fee"
    t.boolean "is_delivery_charges", default: false
    t.string "option_color_name"
    t.index ["agency_id"], name: "index_products_on_agency_id"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "tour_bus_infos", force: :cascade do |t|
    t.bigint "tour_id", null: false
    t.bigint "tour_bus_pattern_id", null: false
    t.date "departure_date"
    t.string "day_of_week"
    t.integer "is_weekend", default: 0
    t.string "bus_no"
    t.integer "reserved_seats"
    t.integer "available_seats"
    t.jsonb "seats_map"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tour_start_location_id"
    t.integer "tour_stay_departure_id"
    t.string "operation_status"
    t.string "concentrate_time"
    t.string "departure_time"
    t.bigint "tour_place_start_id"
    t.index ["tour_bus_pattern_id"], name: "index_tour_bus_infos_on_tour_bus_pattern_id"
    t.index ["tour_id"], name: "index_tour_bus_infos_on_tour_id"
    t.index ["tour_place_start_id"], name: "index_tour_bus_infos_on_tour_place_start_id"
  end

  create_table "tour_bus_patterns", force: :cascade do |t|
    t.string "name"
    t.integer "capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "map"
  end

  create_table "tour_cancellation_details", force: :cascade do |t|
    t.bigint "tour_cancellation_policy_id"
    t.string "name"
    t.bigint "flg1"
    t.bigint "flg2"
    t.float "value"
    t.integer "unit", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tour_cancellation_policy_id"], name: "index_tour_cancellation_details_on_tour_cancellation_policy_id"
  end

  create_table "tour_cancellation_policies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tour_categories", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tour_companies", force: :cascade do |t|
    t.string "name"
    t.string "telephone"
    t.string "email"
    t.string "postal_code"
    t.string "address1"
    t.string "address2"
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tour_coupons", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.date "start_time"
    t.date "end_time"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tour_hostel_departures", force: :cascade do |t|
    t.bigint "tour_id"
    t.bigint "tour_hostel_id"
    t.string "option_ids", default: [], array: true
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tour_hostel_id"], name: "index_tour_hostel_departures_on_tour_hostel_id"
    t.index ["tour_id"], name: "index_tour_hostel_departures_on_tour_id"
  end

  create_table "tour_hostels", force: :cascade do |t|
    t.string "name"
    t.string "telephone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "postal_code"
    t.string "address1"
    t.string "address2"
    t.string "description"
    t.string "note"
  end

  create_table "tour_hostels_tours", force: :cascade do |t|
    t.bigint "tour_id"
    t.bigint "tour_hostel_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tour_hostel_id"], name: "index_tour_hostels_tours_on_tour_hostel_id"
    t.index ["tour_id"], name: "index_tour_hostels_tours_on_tour_id"
  end

  create_table "tour_informations", force: :cascade do |t|
    t.bigint "tour_id", null: false
    t.float "adult_weekday_price"
    t.float "adult_dayoff_price"
    t.bigint "adult_weekday_discount"
    t.bigint "adult_dayoff_discount"
    t.float "children_weekday_price"
    t.float "children_dayoff_price"
    t.bigint "children_weekday_discount"
    t.bigint "children_dayoff_discount"
    t.float "baby_weekday_price"
    t.float "baby_dayoff_price"
    t.bigint "baby_weekday_discount"
    t.bigint "baby_dayoff_discount"
    t.float "max_price"
    t.float "min_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "adult_weekday_amount"
    t.float "adult_dayoff_amount"
    t.float "children_weekday_amount"
    t.float "children_dayoff_amount"
    t.float "baby_weekday_amount"
    t.float "baby_dayoff_amount"
    t.index ["tour_id"], name: "index_tour_informations_on_tour_id"
  end

  create_table "tour_management_files", force: :cascade do |t|
    t.string "bus_no"
    t.string "departure_location"
    t.integer "number_of_people"
    t.string "capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tour_id"
  end

  create_table "tour_options", force: :cascade do |t|
    t.bigint "tour_id", null: false
    t.string "name"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_free", default: false
    t.string "code"
    t.datetime "deleted_at"
    t.index ["tour_id"], name: "index_tour_options_on_tour_id"
  end

  create_table "tour_order_accompanies", force: :cascade do |t|
    t.boolean "is_owner", default: false
    t.string "full_name"
    t.string "furigana"
    t.integer "gender", default: 0
    t.string "phone_number"
    t.string "telephone"
    t.string "room"
    t.string "selected_seat"
    t.integer "pickup_location"
    t.boolean "is_save", default: false
    t.bigint "tour_order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "tour_special_food_id"
    t.bigint "tour_option_id"
    t.string "first_name"
    t.string "last_name"
    t.string "first_name_kana"
    t.string "last_name_kana"
    t.date "birth_day"
    t.string "post_code"
    t.string "email"
    t.string "address1"
    t.string "address2"
    t.string "depature_time"
    t.string "departure_start_location"
    t.boolean "is_user", default: false
    t.jsonb "name_option"
    t.jsonb "price_food", default: {}
    t.index ["tour_option_id"], name: "index_tour_order_accompanies_on_tour_option_id"
    t.index ["tour_order_id"], name: "index_tour_order_accompanies_on_tour_order_id"
    t.index ["tour_special_food_id"], name: "index_tour_order_accompanies_on_tour_special_food_id"
  end

  create_table "tour_order_logs", force: :cascade do |t|
    t.bigint "tour_order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "tour", default: {}
    t.jsonb "tour_cancellation_patterns", default: {}
    t.jsonb "tour_information", default: {}
    t.jsonb "tour_stay_departures", default: {}
    t.jsonb "price_tour_information", default: {}
    t.jsonb "price_special_food", default: {}
    t.jsonb "amount_tour_bus_seat_map", default: {}
    t.string "tour_options"
    t.string "tour_hostels"
    t.index ["tour_order_id"], name: "index_tour_order_logs_on_tour_order_id"
  end

  create_table "tour_order_specials", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "description"
    t.integer "number_of_people"
    t.string "capacity_pattern"
    t.bigint "tour_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tour_id"], name: "index_tour_order_specials_on_tour_id"
  end

  create_table "tour_orders", force: :cascade do |t|
    t.bigint "tour_id", null: false
    t.bigint "user_id"
    t.bigint "tour_bus_info_id", null: false
    t.string "order_no"
    t.date "departure_date"
    t.string "departure_start_location"
    t.integer "number_people"
    t.string "seat_selection"
    t.integer "payment_status"
    t.string "invoice_desc"
    t.string "payment_note"
    t.boolean "cancellation_free", default: false
    t.string "memo"
    t.integer "discount_amount"
    t.integer "used_points"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "total", default: 0.0
    t.float "initial_price", default: 0.0
    t.integer "status", default: 0
    t.float "total_tour"
    t.float "total_tour_bus_seat_map"
    t.float "total_tour_option"
    t.integer "payment_method", default: 0
    t.float "cancellation_fee"
    t.date "date_of_cancellation"
    t.jsonb "room", default: {}
    t.float "total_price_special_food"
    t.bigint "tour_stay_departure_id"
    t.integer "received_bonus_point"
    t.integer "received_point"
    t.integer "coupon_id"
    t.float "coupon_discount"
    t.float "total_price_stay_departure"
    t.string "concentrate_time"
    t.string "depature_time"
    t.string "purchased_id"
    t.float "price_refund"
    t.datetime "refund_comfirm_date"
    t.date "date_of_cancellation_fee"
    t.integer "is_seats_bus_free", default: 0
    t.float "estimate_payment_amount"
    t.date "estimate_payment_confirmation_date"
    t.date "payment_confirmation_date"
    t.boolean "is_cancellation_free", default: false
    t.jsonb "price_seat", default: {}
    t.index ["tour_bus_info_id"], name: "index_tour_orders_on_tour_bus_info_id"
    t.index ["tour_id"], name: "index_tour_orders_on_tour_id"
    t.index ["tour_stay_departure_id"], name: "index_tour_orders_on_tour_stay_departure_id"
    t.index ["user_id"], name: "index_tour_orders_on_user_id"
  end

  create_table "tour_payments", force: :cascade do |t|
    t.bigint "tour_id"
    t.bigint "payment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["payment_id"], name: "index_tour_payments_on_payment_id"
    t.index ["tour_id"], name: "index_tour_payments_on_tour_id"
  end

  create_table "tour_place_starts", force: :cascade do |t|
    t.bigint "tour_id"
    t.bigint "prefecture_id"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prefecture_id"], name: "index_tour_place_starts_on_prefecture_id"
    t.index ["tour_id"], name: "index_tour_place_starts_on_tour_id"
  end

  create_table "tour_special_foods", force: :cascade do |t|
    t.bigint "tour_id", null: false
    t.string "name"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_free", default: false
    t.string "code"
    t.datetime "deleted_at"
    t.index ["tour_id"], name: "index_tour_special_foods_on_tour_id"
  end

  create_table "tour_start_locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "prefecture_id"
    t.date "setting_date"
    t.string "address"
    t.string "depature_time"
    t.string "concentrate_time"
    t.boolean "is_setting", default: false
    t.string "code"
    t.bigint "tour_place_start_id"
    t.bigint "tour_id"
    t.index ["tour_id"], name: "index_tour_start_locations_on_tour_id"
    t.index ["tour_place_start_id"], name: "index_tour_start_locations_on_tour_place_start_id"
  end

  create_table "tour_stay_departures", force: :cascade do |t|
    t.string "address"
    t.date "setting_date"
    t.integer "one_person_fee"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "two_person_fee"
    t.float "three_person_fee"
    t.float "four_person_fee"
    t.string "concentrate_time"
    t.string "depature_time"
    t.string "name"
    t.integer "prefecture_id"
    t.boolean "is_setting", default: false
    t.string "code"
    t.bigint "tour_place_start_id"
    t.bigint "tour_id"
    t.index ["tour_id"], name: "index_tour_stay_departures_on_tour_id"
    t.index ["tour_place_start_id"], name: "index_tour_stay_departures_on_tour_place_start_id"
  end

  create_table "tour_stay_itineraries", force: :cascade do |t|
    t.bigint "tour_id", null: false
    t.integer "date_index"
    t.integer "index"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["date_index"], name: "index_tour_stay_itineraries_on_date_index"
    t.index ["index"], name: "index_tour_stay_itineraries_on_index"
    t.index ["tour_id"], name: "index_tour_stay_itineraries_on_tour_id"
  end

  create_table "tour_temporaries", force: :cascade do |t|
    t.bigint "tour_id"
    t.bigint "tour_order_special_id"
    t.string "name"
    t.string "furigana"
    t.string "postal_code"
    t.string "address1"
    t.string "address2"
    t.string "telephone"
    t.string "phone_number"
    t.integer "gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "birthday"
    t.index ["tour_id"], name: "index_tour_temporaries_on_tour_id"
    t.index ["tour_order_special_id"], name: "index_tour_temporaries_on_tour_order_special_id"
  end

  create_table "tours", force: :cascade do |t|
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "start_time"
    t.date "end_time"
    t.string "code"
    t.string "destination"
    t.integer "discount"
    t.date "end_date"
    t.bigint "exp_point_bonus"
    t.bigint "exp_point_receive"
    t.bigint "first_row_seat_price"
    t.integer "hostel_list"
    t.boolean "is_show_guide", default: false
    t.string "meal_description"
    t.integer "point_bonus_rate"
    t.integer "point_receive_rate"
    t.bigint "regular_seat_price"
    t.date "start_date"
    t.integer "status", default: 0
    t.integer "stayed_nights"
    t.integer "tax"
    t.string "title"
    t.string "tour_guide"
    t.float "two_rows_seat_price"
    t.integer "type_locate", default: 0
    t.bigint "company_staff_id"
    t.bigint "tour_category_id"
    t.string "options"
    t.string "sight_seeing"
    t.string "scheduler"
    t.string "note"
    t.bigint "tour_company_id"
    t.integer "tour_cancellation_policy_id"
    t.string "stop_locations"
    t.string "hotel_description"
    t.string "stopover"
    t.string "info_travel_fee"
    t.string "plan_implement"
    t.string "transport_used"
    t.bigint "min_number_participant"
    t.string "other_fee"
    t.index ["company_staff_id"], name: "index_tours_on_company_staff_id"
    t.index ["tour_category_id"], name: "index_tours_on_tour_category_id"
    t.index ["tour_company_id"], name: "index_tours_on_tour_company_id"
  end

  create_table "tours_prefectures", force: :cascade do |t|
    t.bigint "tour_id"
    t.bigint "prefecture_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tour_coupon_id"
    t.index ["prefecture_id"], name: "index_tours_prefectures_on_prefecture_id"
    t.index ["tour_id"], name: "index_tours_prefectures_on_tour_id"
  end

  create_table "user_blocks", force: :cascade do |t|
    t.integer "blocker_id", null: false
    t.integer "blocked_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_contacts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "address1"
    t.string "address2"
    t.date "birth_day"
    t.string "code"
    t.datetime "deleted_at"
    t.boolean "diary_flg", default: false
    t.string "email"
    t.datetime "expired_at"
    t.string "first_name"
    t.string "first_name_kana"
    t.integer "gender", default: 0
    t.boolean "is_dm", default: true
    t.boolean "is_receive", default: true
    t.string "last_name"
    t.string "last_name_kana"
    t.string "name"
    t.string "nick_name"
    t.text "note"
    t.string "password_digest"
    t.string "phone_number"
    t.float "point", default: 0.0
    t.string "post_code"
    t.integer "status", default: 0
    t.string "telephone"
    t.string "verify_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "full_name"
    t.string "furigana"
    t.index ["user_id"], name: "index_user_contacts_on_user_id"
  end

  create_table "user_prefectures", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "prefecture_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prefecture_id"], name: "index_user_prefectures_on_prefecture_id"
    t.index ["user_id"], name: "index_user_prefectures_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "phone_number"
    t.string "first_name"
    t.string "last_name"
    t.string "first_name_kana"
    t.string "last_name_kana"
    t.integer "gender"
    t.date "birth_day"
    t.string "post_code"
    t.string "address1"
    t.string "address2"
    t.string "verify_code"
    t.datetime "expired_at"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "telephone"
    t.text "note"
    t.boolean "is_dm", default: true
    t.string "nick_name"
    t.integer "status", default: 0
    t.bigint "point", default: 0
    t.string "code"
    t.boolean "is_receive", default: true
    t.boolean "diary_flg", default: false
    t.boolean "is_verify", default: false
    t.integer "point_bonus", default: 0
  end

  create_table "users_notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "notification_id"
    t.boolean "is_read", default: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["is_read"], name: "index_users_notifications_on_is_read"
    t.index ["notification_id"], name: "index_users_notifications_on_notification_id"
    t.index ["user_id"], name: "index_users_notifications_on_user_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "weather_reports", force: :cascade do |t|
    t.string "module_type"
    t.bigint "module_id"
    t.float "humidity"
    t.float "temperature"
    t.float "temperature_min"
    t.float "temperature_max"
    t.float "pressure"
    t.float "wind_speed"
    t.float "wind_deg"
    t.integer "cloud"
    t.string "condition"
    t.integer "condition_id"
    t.string "description"
    t.string "icon_url"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "wind_gust"
    t.float "dew_point"
    t.integer "visibility"
    t.integer "uvi"
    t.float "rain"
    t.integer "report_type"
    t.date "report_date"
    t.datetime "time"
    t.time "sunrise"
    t.time "sunset"
    t.string "icon"
    t.time "moonrise"
    t.time "moonset"
    t.index ["module_type", "module_id"], name: "index_weather_reports_on_module"
    t.index ["report_date"], name: "index_weather_reports_on_report_date"
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "agency_deliveries", "agencies"
  add_foreign_key "agency_deliveries", "deliveries"
  add_foreign_key "agency_payments", "agencies"
  add_foreign_key "agency_payments", "payments"
  add_foreign_key "assets_modules", "assets"
  add_foreign_key "banner_prefectures", "banners"
  add_foreign_key "banner_prefectures", "prefectures"
  add_foreign_key "banner_requests", "banners"
  add_foreign_key "banner_requests", "users"
  add_foreign_key "campaign_products", "campaigns"
  add_foreign_key "campaign_products", "products"
  add_foreign_key "comments", "comments"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "company_staffs", "company_branches"
  add_foreign_key "company_staffs", "company_departments"
  add_foreign_key "coupon_orders", "coupons"
  add_foreign_key "coupon_orders", "orders"
  add_foreign_key "coupon_tour_prefectures", "coupon_tours"
  add_foreign_key "coupon_tour_prefectures", "prefectures"
  add_foreign_key "coupon_users", "coupons"
  add_foreign_key "coupon_users", "users"
  add_foreign_key "coupons_modules", "coupons"
  add_foreign_key "coupons_prefectures", "coupons"
  add_foreign_key "coupons_prefectures", "prefectures"
  add_foreign_key "credits", "users"
  add_foreign_key "delivery_time_settings", "products"
  add_foreign_key "departments_permissions", "company_departments"
  add_foreign_key "departments_permissions", "permissions"
  add_foreign_key "devices", "users"
  add_foreign_key "districts", "prefectures"
  add_foreign_key "ecommerce_coupon_users", "coupons"
  add_foreign_key "ecommerce_coupon_users", "users"
  add_foreign_key "hotel_cancellation_details", "hotel_cancellation_policies"
  add_foreign_key "hotel_cancellation_policies", "hotels"
  add_foreign_key "hotel_children_infos", "hotels"
  add_foreign_key "hotel_options", "hotels"
  add_foreign_key "hotel_orders", "coupons"
  add_foreign_key "hotel_orders", "hotel_order_accompanies"
  add_foreign_key "hotel_orders", "hotel_plans"
  add_foreign_key "hotel_orders", "hotels"
  add_foreign_key "hotel_orders", "users"
  add_foreign_key "hotel_plan_children", "hotel_children_infos"
  add_foreign_key "hotel_plan_children", "hotel_plans"
  add_foreign_key "hotel_plan_options", "hotel_meals"
  add_foreign_key "hotel_plan_options", "hotel_options"
  add_foreign_key "hotel_plan_options", "hotel_plans"
  add_foreign_key "hotel_plans", "hotels"
  add_foreign_key "hotel_requests", "hotel_plans"
  add_foreign_key "hotel_requests", "hotel_rooms"
  add_foreign_key "hotel_requests", "hotels"
  add_foreign_key "hotel_room_settings", "hotel_plan_options"
  add_foreign_key "hotel_room_settings", "hotel_plans"
  add_foreign_key "hotel_room_settings", "hotel_rooms"
  add_foreign_key "hotel_rooms", "hotels"
  add_foreign_key "life_support_prefectures", "life_supports"
  add_foreign_key "life_support_prefectures", "prefectures"
  add_foreign_key "life_support_requests", "life_supports"
  add_foreign_key "life_support_requests", "users"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "news", "news_categories"
  add_foreign_key "notifications_prefectures", "notifications"
  add_foreign_key "notifications_prefectures", "prefectures"
  add_foreign_key "order_infos", "orders"
  add_foreign_key "order_logs", "order_products", column: "order_products_id"
  add_foreign_key "order_products", "orders"
  add_foreign_key "order_products", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "point_usages", "users"
  add_foreign_key "posts", "diary_categories"
  add_foreign_key "posts", "users"
  add_foreign_key "prefectures", "area_settings"
  add_foreign_key "product_area_settings", "area_settings"
  add_foreign_key "product_area_settings", "products"
  add_foreign_key "product_sizes", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "tour_bus_infos", "tour_bus_patterns"
  add_foreign_key "tour_bus_infos", "tours"
  add_foreign_key "tour_cancellation_details", "tour_cancellation_policies"
  add_foreign_key "tour_hostel_departures", "tour_hostels"
  add_foreign_key "tour_hostel_departures", "tours"
  add_foreign_key "tour_hostels_tours", "tour_hostels"
  add_foreign_key "tour_hostels_tours", "tours"
  add_foreign_key "tour_informations", "tours"
  add_foreign_key "tour_options", "tours"
  add_foreign_key "tour_order_accompanies", "tour_orders"
  add_foreign_key "tour_order_logs", "tour_orders"
  add_foreign_key "tour_order_specials", "tours"
  add_foreign_key "tour_orders", "tour_bus_infos"
  add_foreign_key "tour_orders", "tours"
  add_foreign_key "tour_orders", "users"
  add_foreign_key "tour_payments", "payments"
  add_foreign_key "tour_payments", "tours"
  add_foreign_key "tour_place_starts", "prefectures"
  add_foreign_key "tour_place_starts", "tours"
  add_foreign_key "tour_special_foods", "tours"
  add_foreign_key "tour_start_locations", "tours"
  add_foreign_key "tour_stay_departures", "tours"
  add_foreign_key "tour_stay_itineraries", "tours"
  add_foreign_key "tours", "company_staffs"
  add_foreign_key "tours", "tour_categories"
  add_foreign_key "tours_prefectures", "prefectures"
  add_foreign_key "tours_prefectures", "tours"
  add_foreign_key "user_contacts", "users"
  add_foreign_key "user_prefectures", "prefectures"
  add_foreign_key "user_prefectures", "users"
  add_foreign_key "users_notifications", "notifications"
  add_foreign_key "users_notifications", "users"
end
