view: chamber_doatsu {
  sql_table_name: `shield.d_Tbl_genba_k_csv_info_time`
  ;;

  # 全体にkushin_mode=3 の条件を付与
  filter: kushin_mode {
    type: number
    sql: ${TABLE}.kushin_mode ;;
  }

  measure: ring_no {
    # group by の定義をしたいが、[sql_distinct_key]では[type: sum_distinct]または[type: average_distinct]しか対象ではない
    label: "a004_2001_リング番号"
    type: number
    sql: ${TABLE}.ring_no ;;
  }

  measure: start_datetime {
    # group by の定義をしたいが、[sql_distinct_key]では[type: sum_distinct]または[type: average_distinct]しか対象ではない
    label: "最小日付"
    type: min
    sql: ${TABLE}.data_datetime ;;
  }

  measure: end_datetime {
    # group by の定義をしたいが、[sql_distinct_key]では[type: sum_distinct]または[type: average_distinct]しか対象ではない
    label: "最大日付"
    type: max
    sql: ${TABLE}.data_datetime ;;
  }

  measure: chamber_doatsu_gaishu_avg_now_avg {
    label: "a237_2331_チャンバ外周土圧平均_1リング平均"
    type: average_distinct
    sql_distinct_key: ${TABLE}.ring_no ;;
    sql: AVG(ifnull(${TABLE}.chamber_doatsu_gaishu_avg, 0)) OVER (ORDER BY ${TABLE}.ring_no RANGE CURRENT ROW) ;;
  }

  measure: chamber_doatsu_gaishu_avg_20r_avg {
    label: "a237_2331_チャンバ外周土圧平均_20リング平均"
    type: average_distinct
    sql_distinct_key: ${TABLE}.ring_no ;;
    sql: AVG(ifnull(${TABLE}.chamber_doatsu_gaishu_avg, 0)) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) ;;
  }

  measure: chamber_doatsu_gaishu_avg_20r_stddev {
    label: "a237_2331_チャンバ外周土圧平均_20リング標準偏差"
    type: average_distinct
    sql_distinct_key: ${TABLE}.ring_no ;;
    sql: STDDEV(ifnull(${TABLE}.chamber_doatsu_gaishu_avg, 0)) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) ;;
  }

  measure: chamber_doatsu_naishu_avg_now_avg {
    label: "a238_2332_チャンバ内周土圧平均_1リング平均"
    type: average_distinct
    sql_distinct_key: ${TABLE}.ring_no ;;
    sql: AVG(ifnull(${TABLE}.chamber_doatsu_naishu_avg, 0)) OVER (ORDER BY ${TABLE}.ring_no RANGE CURRENT ROW) ;;
  }

  measure: chamber_doatsu_naishu_avg_20r_avg {
    label: "a238_2332_チャンバ内周土圧平均_20リング平均"
    type: average_distinct
    sql_distinct_key: ${TABLE}.ring_no ;;
    sql: AVG(ifnull(${TABLE}.chamber_doatsu_naishu_avg, 0)) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) ;;
  }

  measure: chamber_doatsu_naishu_avg_20r_stddev {
    label: "a238_2332_チャンバ内周土圧平均_20リング標準偏差"
    type: average_distinct
    sql_distinct_key: ${TABLE}.ring_no ;;
    sql: STDDEV(ifnull(${TABLE}.chamber_doatsu_naishu_avg, 0)) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) ;;
  }

  measure: a237_2331_20R_MINUS_2sigma {
    label: "a237_2331_チャンバ外周土圧平均_20リング（-2σ）"
    type: number
    sql: ${chamber_doatsu_gaishu_avg_20r_avg} - (${chamber_doatsu_gaishu_avg_20r_stddev} * 2) ;;
  }

  measure: a237_2331_20R_MINUS_1sigma {
    label: "a237_2331_チャンバ外周土圧平均_20リング（-1σ）"
    type: number
    sql: ${chamber_doatsu_gaishu_avg_20r_avg} - ${chamber_doatsu_gaishu_avg_20r_stddev} ;;
  }

  measure: a237_2331_20R_0sigma {
    label: "a237_2331_チャンバ外周土圧平均_20リング（0σ）"
    type: number
    sql: ${chamber_doatsu_gaishu_avg_20r_avg} ;;
  }

  measure: a237_2331_20R_PLUS_1sigma {
    label: "a237_2331_チャンバ外周土圧平均_20リング（+1σ）"
    type: number
    sql: ${chamber_doatsu_gaishu_avg_20r_avg} + ${chamber_doatsu_gaishu_avg_20r_stddev} ;;
  }

  measure: a237_2331_20R_PLUS_2sigma {
    label: "a237_2331_チャンバ外周土圧平均_20リング（+2σ）"
    type: number
    sql: ${chamber_doatsu_gaishu_avg_20r_avg} + (${chamber_doatsu_gaishu_avg_20r_stddev} * 2) ;;
  }

  measure: a238_2332_20R_MINUS_2sigma {
    label: "a238_2332_チャンバ内周土圧平均_20リング（-2σ）"
    type: number
    sql: ${chamber_doatsu_naishu_avg_20r_avg} - (${chamber_doatsu_naishu_avg_20r_stddev} * 2) ;;
  }

  measure: a238_2332_20R_MINUS_1sigma {
    label: "a238_2332_チャンバ内周土圧平均_20リング（-1σ）"
    type: number
    sql: ${chamber_doatsu_naishu_avg_20r_avg} - ${chamber_doatsu_naishu_avg_20r_stddev} ;;
  }

  measure: a238_2332_20R_0sigma {
    label: "a238_2332_チャンバ内周土圧平均_20リング（0σ）"
    type: number
    sql: ${chamber_doatsu_naishu_avg_20r_avg} ;;
  }

  measure: a238_2332_20R_PLUS_1sigma {
    label: "a238_2332_チャンバ内周土圧平均_20リング（+1σ）"
    type: number
    sql: ${chamber_doatsu_naishu_avg_20r_avg} + ${chamber_doatsu_naishu_avg_20r_stddev} ;;
  }

  measure: a238_2332_20R_PLUS_2sigma {
    label: "a238_2332_チャンバ内周土圧平均_20リング（+2σ）"
    type: number
    sql: ${chamber_doatsu_naishu_avg_20r_avg} + (${chamber_doatsu_naishu_avg_20r_stddev} * 2) ;;
  }
}
