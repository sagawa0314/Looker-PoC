connection: "big_query"

# include all the views
include: "/views/**/*.view"

datagroup: looker_poc_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: looker_poc_default_datagroup

explore: d_tbl_genba_k_csv_info_time {}

explore: genba_k_csv_info_time_406 {}

explore: genbak {}

explore: genba_k_csv_info_time_366 {}

explore: genba_k_csv_info_time_368 {}

explore: genba_k_csv_info_time_404 {}

explore: genbakv2 {}

explore: genba_k_csv_info_time_321 {}

explore: kensho {}

explore: genba_k_csv_info_time_4_6 {}

explore: chamber_doatsu {}
