view: chamber_doatsu_sql {
  derived_table: {
    sql:
       SELECT
         ring_no
         ,data_datetime AS start_datetime
         ,data_datetime AS end_datetime
         ,AVG(ifnull(chamber_doatsu_gaishu_avg, 0)) OVER (ORDER BY ring_no RANGE CURRENT ROW) AS chamber_doatsu_gaishu_avg_now_avg
         ,AVG(ifnull(chamber_doatsu_gaishu_avg, 0)) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) AS chamber_doatsu_gaishu_avg_20r_avg
         ,STDDEV(ifnull(chamber_doatsu_gaishu_avg, 0)) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) AS chamber_doatsu_gaishu_avg_20r_stddev
         ,AVG(ifnull(chamber_doatsu_naishu_avg, 0)) OVER (ORDER BY ring_no RANGE CURRENT ROW) AS chamber_doatsu_naishu_avg_now_avg
         ,AVG(ifnull(chamber_doatsu_naishu_avg, 0)) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) AS chamber_doatsu_naishu_avg_20r_avg
         ,STDDEV(ifnull(chamber_doatsu_naishu_avg, 0)) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) AS chamber_doatsu_naishu_avg_20r_stddev
       FROM
         shield.d_Tbl_genba_k_csv_info_time
       WHERE
         kushin_mode = 3
    ;;
  }


  dimension: a004_2001 {
    label: "a004_2001_リング番号"
    type: number
    primary_key: yes
    sql: ${TABLE}.ring_no ;;
  }

  measure: start_datetime {
    label: "最小日付"
    type: min
    sql: ${TABLE}.start_datetime ;;
  }

  measure: end_datetime {
    label: "最大日付"
    type: max
    sql: ${TABLE}.end_datetime ;;
  }

  measure: a237_2331_1R {
    label: "a237_2331_チャンバ外周土圧平均_1リング平均"
    type: average
    sql: ${TABLE}.chamber_doatsu_gaishu_avg_now_avg ;;
  }

  measure: chamber_doatsu_gaishu_avg_20r_avg {
    label: "a237_2331_チャンバ外周土圧平均_20リング平均"
    type: average
    sql: ${TABLE}.chamber_doatsu_gaishu_avg_20r_avg ;;
  }

  measure: chamber_doatsu_gaishu_avg_20r_stddev {
    label: "a237_2331_チャンバ外周土圧平均_20リング標準偏差"
    type: average
    sql: ${TABLE}.chamber_doatsu_gaishu_avg_20r_stddev ;;
  }

  measure: chamber_doatsu_naishu_avg_now_avg {
    label: "a238_2332_チャンバ内周土圧平均_1リング平均"
    type: average
    sql: ${TABLE}.chamber_doatsu_naishu_avg_now_avg ;;
  }

  measure: chamber_doatsu_naishu_avg_20r_avg {
    label: "a238_2332_チャンバ内周土圧平均_20リング平均"
    type: average
    sql: ${TABLE}.chamber_doatsu_naishu_avg_20r_avg ;;
  }

  measure: chamber_doatsu_naishu_avg_20r_stddev {
    label: "a238_2332_チャンバ内周土圧平均_20リング標準偏差"
    type: average
    sql: ${TABLE}.chamber_doatsu_naishu_avg_20r_stddev ;;
  }

  measure: a237_2331_20R_MINUS_2sigma {
    label: "a237_2331_チャンバ外周土圧平均_20リング（-2σ）"
    type: number
    sql: ${chamber_doatsu_gaishu_avg_20r_avg} - (${chamber_doatsu_gaishu_avg_20r_stddev} * 2) ;;
  }

  measure: a237_2331_20R_MINUS_1sigma {
    label: "a237_2331_チャンバ外周土圧平均_20リング（-1σ）"
    type: number
    sql: ${chamber_doatsu_gaishu_avg_20r_avg} - (${chamber_doatsu_gaishu_avg_20r_stddev} * 1) ;;
  }

  measure: a237_2331_20R_0sigma {
    label: "a237_2331_チャンバ外周土圧平均_20リング（0σ）"
    type: number
    sql: ${chamber_doatsu_gaishu_avg_20r_avg} ;;
  }

  measure: a237_2331_20R_PLUS_1sigma {
    label: "a237_2331_チャンバ外周土圧平均_20リング（+1σ）"
    type: number
    sql: ${chamber_doatsu_gaishu_avg_20r_avg} + (${chamber_doatsu_gaishu_avg_20r_stddev} * 1) ;;
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
    sql: ${chamber_doatsu_naishu_avg_20r_avg} - (${chamber_doatsu_naishu_avg_20r_stddev} * 1) ;;
  }

  measure: a238_2332_20R_0sigma {
    label: "a238_2332_チャンバ内周土圧平均_20リング（0σ）"
    type: number
    sql: ${chamber_doatsu_naishu_avg_20r_avg} ;;
  }

  measure: a238_2332_20R_PLUS_1sigma {
    label: "a238_2332_チャンバ内周土圧平均_20リング（+1σ）"
    type: number
    sql: ${chamber_doatsu_gaishu_avg_20r_avg} + (${chamber_doatsu_gaishu_avg_20r_stddev} * 1) ;;
  }

  measure: a238_2332_20R_PLUS_2sigma {
    label: "a238_2332_チャンバ外周土圧平均_20リング（+2σ）"
    type: number
    sql: ${chamber_doatsu_naishu_avg_20r_avg} + (${chamber_doatsu_naishu_avg_20r_stddev} * 2) ;;
  }

}
