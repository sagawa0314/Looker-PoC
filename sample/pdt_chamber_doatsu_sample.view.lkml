view: pdt_chamber_doatsu_sample {
  derived_table: {
    sql:
      SELECT
        data_datetime,
        kushin_mode,
        ring_no
        ,AVG(ifnull(chamber_doatsu_gaishu_avg, 0)) OVER (ORDER BY ring_no RANGE CURRENT ROW) AS chamber_doatsu_gaishu_avg_now_avg
        ,AVG(ifnull(chamber_doatsu_gaishu_avg, 0)) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) AS chamber_doatsu_gaishu_avg_20r_avg
        ,STDDEV(ifnull(chamber_doatsu_gaishu_avg, 0)) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) AS chamber_doatsu_gaishu_avg_20r_stddev
        ,AVG(ifnull(chamber_doatsu_naishu_avg, 0)) OVER (ORDER BY ring_no RANGE CURRENT ROW) AS chamber_doatsu_naishu_avg_now_avg
        ,AVG(ifnull(chamber_doatsu_naishu_avg, 0)) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) AS chamber_doatsu_naishu_avg_20r_avg
        ,STDDEV(ifnull(chamber_doatsu_naishu_avg, 0)) OVER (ORDER BY ring_no RANGE BETWEEN 20 PRECEDING AND 1 PRECEDING) AS chamber_doatsu_naishu_avg_20r_stddev
      FROM
        shield.d_Tbl_genba_k_csv_info_time
       ;;
      # 派生テーブルを永続化
      datagroup_trigger: once_a_day_at_10am
  }

    dimension_group: kushin {
      label: "掘進"
      type: time
      datatype: datetime
      timeframes: [
        time,
        date,
        week,
        month,
        quarter,
        year
        ]
      sql: ${TABLE}.data_datetime ;;
    }

    measure: start_time {
      label: "開始"
      type: date
      sql: min(${kushin_time}) ;;
      convert_tz: no
    }

    measure: end_time {
      label: "終了"
      type: date
      sql: max(${kushin_time}) ;;
      convert_tz: no
    }

    dimension: kushin_mode {
      label: "掘進モード"
      case: {
        when: {
          sql: ${TABLE}.kushin_mode = 1 ;;
          label: "掘進中"
        }
        when: {
          sql: ${TABLE}.kushin_mode = 2 ;;
          label: "停止中"
        }
        when: {
          sql: ${TABLE}.kushin_mode = 3 ;;
          label: "組立中"
        }
        when: {
          sql: ${TABLE}.kushin_mode = 4 ;;
          label: "定常掘進"
        }
        when: {
          sql: ${TABLE}.kushin_mode = 5 ;;
          label: "掘進開始"
        }
        when: {
          sql: ${TABLE}.kushin_mode in (1, 2, 3) ;;
          label: "掘進中／停止中／組立中"
        }
        when: {
          sql: ${TABLE}.kushin_mode in (1, 4, 5) ;;
          label: "掘進中／定常掘進／掘進開始"
        }
        else: "その他"
      }
    }

    dimension: a004_2001 {
      label: "a004_2001_リング番号"
      type: number
      primary_key: yes
      sql: ${TABLE}.ring_no ;;
    }

    dimension: chamber_doatsu_gaishu_avg_now_avg {
      type: number
      sql: ${TABLE}.chamber_doatsu_gaishu_avg_now_avg ;;
    }

    dimension: chamber_doatsu_gaishu_avg_20r_avg {
      type: number
      sql: ${TABLE}.chamber_doatsu_gaishu_avg_20r_avg ;;
    }

    dimension: chamber_doatsu_gaishu_avg_20r_stddev {
      type: number
      sql: ${TABLE}.chamber_doatsu_gaishu_avg_20r_stddev ;;
    }

    dimension: chamber_doatsu_naishu_avg_now_avg {
      type: number
      sql: ${TABLE}.chamber_doatsu_naishu_avg_now_avg ;;
    }

    dimension: chamber_doatsu_naishu_avg_20r_avg {
      type: number
      sql: ${TABLE}.chamber_doatsu_naishu_avg_20r_avg ;;
    }

    dimension: chamber_doatsu_naishu_avg_20r_stddev {
      type: number
      sql: ${TABLE}.chamber_doatsu_naishu_avg_20r_stddev ;;
    }

    # measure

  measure: a237_2331_1R {
    label: "1リング平均"
    group_label: "a237_2331_チャンバ外周土圧平均"
    type: average
    sql: ${chamber_doatsu_gaishu_avg_now_avg} ;;
  }

  measure: avg_chamber_doatsu_gaishu_avg_20r {
    label: "20リング平均"
    group_label: "a237_2331_チャンバ外周土圧平均"
    type: average
    sql: ${chamber_doatsu_gaishu_avg_20r_avg} ;;
  }

  measure: stddev_chamber_doatsu_gaishu_avg_20r {
    label: "20リング標準偏差"
    group_label: "a237_2331_チャンバ外周土圧平均"
    type: average
    sql: ${chamber_doatsu_gaishu_avg_20r_stddev} ;;
  }

  measure: avg_chamber_doatsu_naishu_avg_now {
    label: "1リング平均"
    group_label: "a238_2332_チャンバ内周土圧平均"
    type: average
    sql: ${chamber_doatsu_naishu_avg_now_avg} ;;
  }

  measure: avg_chamber_doatsu_naishu_avg_20r {
    label: "20リング平均"
    group_label: "a238_2332_チャンバ内周土圧平均"
    type: average
    sql: ${chamber_doatsu_naishu_avg_20r_avg} ;;
  }

  measure: stddev_chamber_doatsu_naishu_avg_20r {
    label: "20リング標準偏差"
    group_label: "a238_2332_チャンバ内周土圧平均"
    type: average
    sql: ${chamber_doatsu_naishu_avg_20r_stddev} ;;
  }

  measure: a237_2331_20R_MINUS_2sigma {
    label: "20リング（-2σ）"
    group_label: "a237_2331_チャンバ外周土圧平均"
    type: number
    sql: ${avg_chamber_doatsu_gaishu_avg_20r} - (${stddev_chamber_doatsu_gaishu_avg_20r} * 2) ;;
  }

  measure: a237_2331_20R_MINUS_1sigma {
    label: "20リング（-1σ）"
    group_label: "a237_2331_チャンバ外周土圧平均"
    type: number
    sql: ${avg_chamber_doatsu_gaishu_avg_20r} - (${stddev_chamber_doatsu_gaishu_avg_20r} * 1) ;;
  }

  # 計算が不明のためコメントアウト
  # measure: a237_2331_20R_0sigma {
  #   label: "20リング（0σ）"
  #   group_label: "a237_2331_チャンバ外周土圧平均"
  #   type: number
  #   sql: ${chamber_doatsu_gaishu_avg_20r_avg} ;;
  # }

  measure: a237_2331_20R_PLUS_1sigma {
    label: "20リング（+1σ）"
    group_label: "a237_2331_チャンバ外周土圧平均"
    type: number
    sql: ${avg_chamber_doatsu_gaishu_avg_20r} + (${stddev_chamber_doatsu_gaishu_avg_20r} * 1) ;;
  }

  measure: a237_2331_20R_PLUS_2sigma {
    label: "20リング（+2σ）"
    group_label: "a237_2331_チャンバ外周土圧平均"
    type: number
    sql: ${avg_chamber_doatsu_gaishu_avg_20r} + (${stddev_chamber_doatsu_gaishu_avg_20r} * 2) ;;
  }

  measure: a238_2332_20R_MINUS_2sigma {
    label: "20リング（-2σ）"
    group_label: "a238_2332_チャンバ内周土圧平均"
    type: number
    sql: ${avg_chamber_doatsu_naishu_avg_20r} - (${stddev_chamber_doatsu_naishu_avg_20r} * 2) ;;
  }

  measure: a238_2332_20R_MINUS_1sigma {
    label: "20リング（-1σ）"
    group_label: "a238_2332_チャンバ内周土圧平均"
    type: number
    sql: ${avg_chamber_doatsu_naishu_avg_20r} - (${stddev_chamber_doatsu_naishu_avg_20r} * 1) ;;
  }

  # 計算が不明のためコメントアウト
  # measure: a238_2332_20R_0sigma {
  #   label: "20リング（0σ）"
  #   group_label: "a238_2332_チャンバ内周土圧平均"
  #   type: number
  #   sql: ${chamber_doatsu_naishu_avg_20r_avg} ;;
  # }

  measure: a238_2332_20R_PLUS_1sigma {
    label: "20リング（+1σ）"
    group_label: "a238_2332_チャンバ内周土圧平均"
    type: number
    sql: ${avg_chamber_doatsu_gaishu_avg_20r} + (${stddev_chamber_doatsu_gaishu_avg_20r} * 1) ;;
  }

  measure: a238_2332_20R_PLUS_2sigma {
    label: "20リング（+2σ）"
    group_label: "a238_2332_チャンバ外周土圧平均"
    type: number
    sql: ${avg_chamber_doatsu_naishu_avg_20r} + (${stddev_chamber_doatsu_naishu_avg_20r} * 2) ;;
  }

}
