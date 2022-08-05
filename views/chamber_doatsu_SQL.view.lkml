view: chamber_doatsu_sql {
  derived_table: {
    sql:
      SELECT
       SHUKEI_1.ring_no AS a004_2001
       ,SHUKEI_1.start_datetime AS start_datetime
       ,SHUKEI_1.end_datetime AS end_datetime
       ,SHUKEI_1.chamber_doatsu_gaishu_avg_now_avg AS a237_2331_1R
       ,SHUKEI_1.chamber_doatsu_gaishu_avg_20r_avg - (SHUKEI_1.chamber_doatsu_gaishu_avg_20r_stddev * 2) AS a237_2331_20R_MINUS_2sigma
       ,SHUKEI_1.chamber_doatsu_gaishu_avg_20r_avg - SHUKEI_1.chamber_doatsu_gaishu_avg_20r_stddev AS a237_2331_20R_MINUS_1sigma
       ,SHUKEI_1.chamber_doatsu_gaishu_avg_20r_avg AS a237_2331_20R_0sigma
       ,SHUKEI_1.chamber_doatsu_gaishu_avg_20r_avg + SHUKEI_1.chamber_doatsu_gaishu_avg_20r_stddev AS a237_2331_20R_PLUS_1sigma
       ,SHUKEI_1.chamber_doatsu_gaishu_avg_20r_avg + (SHUKEI_1.chamber_doatsu_gaishu_avg_20r_stddev * 2) AS a237_2331_20R_PLUS_2sigma
       ,SHUKEI_1.chamber_doatsu_naishu_avg_now_avg AS a238_2332_1R
       ,SHUKEI_1.chamber_doatsu_naishu_avg_20r_avg - (SHUKEI_1.chamber_doatsu_naishu_avg_20r_stddev * 2) AS a238_2332_20R_MINUS_2sigma
       ,SHUKEI_1.chamber_doatsu_naishu_avg_20r_avg - SHUKEI_1.chamber_doatsu_naishu_avg_20r_stddev AS a238_2332_20R_MINUS_1sigma
       ,SHUKEI_1.chamber_doatsu_naishu_avg_20r_avg AS a238_2332_20R_0sigma
       ,SHUKEI_1.chamber_doatsu_naishu_avg_20r_avg + SHUKEI_1.chamber_doatsu_naishu_avg_20r_stddev AS a238_2332_20R_PLUS_1sigma
       ,SHUKEI_1.chamber_doatsu_naishu_avg_20r_avg + (SHUKEI_1.chamber_doatsu_naishu_avg_20r_stddev * 2) AS a238_2332_20R_PLUS_2sigma
      FROM
       (
       SELECT
         ring_no
         ,MIN(data_datetime) AS start_datetime
         ,MAX(data_datetime) AS end_datetime
         ,AVG(AVG(ifnull(chamber_doatsu_gaishu_avg, 0))) OVER (ORDER BY ring_no RANGE CURRENT ROW) AS chamber_doatsu_gaishu_avg_now_avg
         ,AVG(AVG(ifnull(chamber_doatsu_gaishu_avg, 0))) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) AS chamber_doatsu_gaishu_avg_20r_avg
         ,AVG(STDDEV(ifnull(chamber_doatsu_gaishu_avg, 0))) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) AS chamber_doatsu_gaishu_avg_20r_stddev
         ,AVG(AVG(ifnull(chamber_doatsu_naishu_avg, 0))) OVER (ORDER BY ring_no RANGE CURRENT ROW) AS chamber_doatsu_naishu_avg_now_avg
         ,AVG(AVG(ifnull(chamber_doatsu_naishu_avg, 0))) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) AS chamber_doatsu_naishu_avg_20r_avg
         ,AVG(STDDEV(ifnull(chamber_doatsu_naishu_avg, 0))) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) AS chamber_doatsu_naishu_avg_20r_stddev
       FROM
         shield.d_Tbl_genba_k_csv_info_time
       WHERE
         kushin_mode = 3
       GROUP BY ring_no
       ) SHUKEI_1
      ORDER BY SHUKEI_1.ring_no
    ;;
  }

#  dimension: a004_2001 {
#    label: "a004_2001_リング番号"
#    type: number
#    #primary_key: yes
#    sql: ${TABLE}.a004_2001 ;;
#  }

  measure: a004_2001 {
    label: "a004_2001_リング番号"
    type: number
    sql: ${TABLE}.a004_2001 ;;
  }

  measure: start_datetime {
    label: "最小日付"
    type: date_date
    sql: ${TABLE}.start_datetime ;;
  }

  measure: end_datetime {
    label: "最大日付"
    type: date_date
    sql: ${TABLE}.end_datetime ;;
  }

  measure: a237_2331_1R {
    label: "a237_2331_チャンバ外周土圧平均_1リング平均"
    type: number
    sql: ${TABLE}.a237_2331_1R ;;
  }

  measure: a237_2331_20R_MINUS_2sigma {
    label: "a237_2331_チャンバ外周土圧平均_20リング（-2σ）"
    type: number
    sql: ${TABLE}.a237_2331_20R_MINUS_2sigma ;;
  }

  measure: a237_2331_20R_MINUS_1sigma {
    label: "a237_2331_チャンバ外周土圧平均_20リング（-1σ）"
    type: number
    sql: ${TABLE}.a237_2331_20R_MINUS_1sigma ;;
    }

  measure: a237_2331_20R_0sigma {
    label: "a237_2331_チャンバ外周土圧平均_20リング（0σ）"
    type: number
    sql: ${TABLE}.a237_2331_20R_0sigma ;;
    }

  measure: a237_2331_20R_PLUS_1sigma {
    label: "a237_2331_チャンバ外周土圧平均_20リング（+1σ）"
    type: number
    sql: ${TABLE}.a237_2331_20R_PLUS_1sigma ;;
  }

  measure: a237_2331_20R_PLUS_2sigma {
    label: "a237_2331_チャンバ外周土圧平均_20リング（+2σ）"
    type: number
    sql: ${TABLE}.a237_2331_20R_PLUS_2sigma ;;
  }

  measure: a238_2332_1R {
    label: "a238_2332_チャンバ内周土圧平均_1リング平均"
    type: number
    sql: ${TABLE}.a238_2332_1R ;;
  }

  measure: a238_2332_20R_MINUS_2sigma {
    label: "a238_2332_チャンバ内周土圧平均_20リング（-2σ）"
    type: number
    sql: ${TABLE}.a238_2332_20R_MINUS_2sigma ;;
  }

  measure: a238_2332_20R_MINUS_1sigma {
    label: "a238_2332_チャンバ内周土圧平均_20リング（-1σ）"
    type: number
    sql: ${TABLE}.a238_2332_20R_MINUS_1sigma ;;
  }

  measure: a238_2332_20R_0sigma {
    label: "a238_2332_チャンバ内周土圧平均_20リング（0σ）"
    type: number
    sql: ${TABLE}.a238_2332_20R_0sigma ;;
  }

  measure: a238_2332_20R_PLUS_1sigma {
    label: "a238_2332_チャンバ内周土圧平均_20リング（+1σ）"
    type: number
    sql: ${TABLE}.a238_2332_20R_PLUS_1sigma ;;
  }

  measure: a238_2332_20R_PLUS_2sigma {
    label: "a238_2332_チャンバ内周土圧平均_20リング（+2σ）"
    type: number
    sql: ${TABLE}.a238_2332_20R_PLUS_2sigma ;;
  }

}
