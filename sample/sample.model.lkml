connection: "big_query"

include: "/sample/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# 毎朝10時にキャッシュをリフレッシュするデータグループ
# 参考：https://docs.looker.com/ja/reference/view-params/sql_trigger_value#google_bigquery
datagroup: once_a_day_at_10am {
  sql_trigger:
    SELECT FLOOR(((TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),'1970-01-01 00:00:00',SECOND)) - 60*60*10)/(60*60*24))
  ;;
  max_cache_age: "24 hours"
}

persist_with: once_a_day_at_10am

explore: pdt_chamber_doatsu_sample {
  label: "サンプル"
  always_filter: {
    filters: [pdt_chamber_doatsu_sample.kushin_mode: "掘進中"]
  }
}
