view: chamber_doatsu {
  sql_table_name: `shield.d_Tbl_genba_k_csv_info_time`
  ;;

  dimension: kushin_mode {
    label: "a005_2002_掘進モード"
    type: number
    sql: ${TABLE}.kushin_mode ;;
  }

  measure: ring_no {
    # kushin_mode=3 の条件を付与したいが、[type: number]には[filters]の定義ができない
    # group by の定義をしたいが、[sql_distinct_key]では[type: sum_distinct]または[type: average_distinct]しか対象ではない
    label: "a004_2001_リング番号"
    type: number
    sql: ${TABLE}.ring_no ;;
  }

  measure: start_datetime {
    # kushin_mode=3 の条件を付与したいが、[type: min]には[filters]の定義ができない
    # group by の定義をしたいが、[sql_distinct_key]では[type: sum_distinct]または[type: average_distinct]しか対象ではない
    label: "最小日付"
    type: min
    sql: ${TABLE}.data_datetime ;;
  }

  measure: end_datetime {
    # kushin_mode=3 の条件を付与したいが、[type: max]には[filters]の定義ができない
    # group by の定義をしたいが、[sql_distinct_key]では[type: sum_distinct]または[type: average_distinct]しか対象ではない
    label: "最大日付"
    type: max
    sql: ${TABLE}.data_datetime ;;
  }

  measure: chamber_doatsu_gaishu_avg_now_avg {
    label: "a237_2331_チャンバ外周土圧平均"
    type: average_distinct
    filters: [kushin_mode: "=3"]
    sql_distinct_key: ${TABLE}.ring_no ;;
    sql: ifnull(${TABLE}.chamber_doatsu_gaishu_avg, 0) OVER (ORDER BY ${TABLE}.ring_no RANGE CURRENT ROW) ;;
  }
}

#SELECT
# SHUKEI_1.ring_no AS a004_2001
# ,SHUKEI_1.start_datetime AS start_datetime
# ,SHUKEI_1.end_datetime AS end_datetime
# ,SHUKEI_1.chamber_doatsu_gaishu_avg_now_avg AS a237_2331_1R
# ,SHUKEI_1.chamber_doatsu_gaishu_avg_20r_avg - (SHUKEI_1.chamber_doatsu_gaishu_avg_20r_stddev * 2) AS a237_2331_20R_MINUS_2sigma
# ,SHUKEI_1.chamber_doatsu_gaishu_avg_20r_avg - SHUKEI_1.chamber_doatsu_gaishu_avg_20r_stddev AS a237_2331_20R_MINUS_1sigma
# ,SHUKEI_1.chamber_doatsu_gaishu_avg_20r_avg AS a237_2331_20R_0sigma
# ,SHUKEI_1.chamber_doatsu_gaishu_avg_20r_avg + SHUKEI_1.chamber_doatsu_gaishu_avg_20r_stddev AS a237_2331_20R_PLUS_1sigma
# ,SHUKEI_1.chamber_doatsu_gaishu_avg_20r_avg + (SHUKEI_1.chamber_doatsu_gaishu_avg_20r_stddev * 2) AS a237_2331_20R_PLUS_2sigma
# ,SHUKEI_1.chamber_doatsu_naishu_avg_now_avg AS a238_2332_1R
# ,SHUKEI_1.chamber_doatsu_naishu_avg_20r_avg - (SHUKEI_1.chamber_doatsu_naishu_avg_20r_stddev * 2) AS a238_2332_20R_MINUS_2sigma
# ,SHUKEI_1.chamber_doatsu_naishu_avg_20r_avg - SHUKEI_1.chamber_doatsu_naishu_avg_20r_stddev AS a238_2332_20R_MINUS_1sigma
# ,SHUKEI_1.chamber_doatsu_naishu_avg_20r_avg AS a238_2332_20R_0sigma
# ,SHUKEI_1.chamber_doatsu_naishu_avg_20r_avg + SHUKEI_1.chamber_doatsu_naishu_avg_20r_stddev AS a238_2332_20R_PLUS_1sigma
# ,SHUKEI_1.chamber_doatsu_naishu_avg_20r_avg + (SHUKEI_1.chamber_doatsu_naishu_avg_20r_stddev * 2) AS a238_2332_20R_PLUS_2sigma
#FROM
# (
# SELECT
#   ring_no
#   ,MIN(data_datetime) AS start_datetime
#   ,MAX(data_datetime) AS end_datetime
#   ,AVG(AVG(ifnull(chamber_doatsu_gaishu_avg, 0))) OVER (ORDER BY ring_no RANGE CURRENT ROW) AS chamber_doatsu_gaishu_avg_now_avg
#   ,AVG(AVG(ifnull(chamber_doatsu_gaishu_avg, 0))) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) AS chamber_doatsu_gaishu_avg_20r_avg
#   ,AVG(STDDEV(ifnull(chamber_doatsu_gaishu_avg, 0))) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) AS chamber_doatsu_gaishu_avg_20r_stddev
#   ,AVG(AVG(ifnull(chamber_doatsu_naishu_avg, 0))) OVER (ORDER BY ring_no RANGE CURRENT ROW) AS chamber_doatsu_naishu_avg_now_avg
#   ,AVG(AVG(ifnull(chamber_doatsu_naishu_avg, 0))) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) AS chamber_doatsu_naishu_avg_20r_avg
#   ,AVG(STDDEV(ifnull(chamber_doatsu_naishu_avg, 0))) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) AS chamber_doatsu_naishu_avg_20r_stddev
# FROM
#   shield.d_Tbl_genba_k_csv_info_time
# WHERE
#   kushin_mode = 3
# GROUP BY ring_no
# ) SHUKEI_1
#ORDER BY SHUKEI_1.ring_no
#;
