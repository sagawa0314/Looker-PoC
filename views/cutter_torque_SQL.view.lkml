view: cutter_torque_sql {
  parameter: kushin_mode {
    type: unquoted
    allowed_value: {
      label: "掘進中"
      value: "kushinchu"
    }
    allowed_value: {
      label: "停止中"
      value: "teishichu"
    }
    allowed_value: {
      label: "組立中"
      value: "kumitatechu"
    }
    allowed_value: {
      label: "定常掘進"
      value: "teijokushin"
    }
    allowed_value: {
      label: "掘進開始"
      value: "kushunstart"
    }
    allowed_value: {
      label: "掘進中／停止中／組立中"
      value: "kushin_teishi_kumitate"
    }
    allowed_value: {
      label: "掘進中／定常掘進／掘進開始"
      value: "kushin_teijo_start"
    }
  }

  derived_table: {
    sql:
       SELECT
         ring_no AS a004_2001
         ,data_datetime AS datetime
         ,cutter_torque AS a246_2340
         ,AVG(ifnull(cutter_torque, 0)) OVER (ORDER BY data_datetime ROWS BETWEEN 30 PRECEDING AND 1 PRECEDING) AS a246_2340_30sec_AVG
         ,AVG(ifnull(cutter_torque, 0)) OVER (ORDER BY data_datetime ROWS BETWEEN 600 PRECEDING AND 1 PRECEDING) AS a246_2340_10min_AVG
         ,AVG(ifnull(cutter_torque, 0)) OVER (ORDER BY ring_no RANGE BETWEEN 30 PRECEDING AND 1 PRECEDING) AS cutter_torque_30r_avg
         ,STDDEV(ifnull(cutter_torque, 0)) OVER (ORDER BY ring_no RANGE BETWEEN 30 PRECEDING AND 1 PRECEDING) AS cutter_torque_30r_stddev
       FROM
         shield.d_Tbl_genba_k_csv_info_time d1
       {% if kushin_mode._parameter_value == 'kushinchu' %}
         WHERE d1.kushin_mode = 1
       {% elsif kushin_mode._parameter_value == 'teishichu' %}
         WHERE d1.kushin_mode = 2
       {% elsif kushin_mode._parameter_value == 'kumitatechu' %}
         WHERE d1.kushin_mode = 3
       {% elsif kushin_mode._parameter_value == 'teijokushin' %}
         WHERE d1.kushin_mode = 4
       {% elsif kushin_mode._parameter_value == 'kushunstart' %}
         WHERE d1.kushin_mode = 5
       {% elsif kushin_mode._parameter_value == 'kushin_teishi_kumitate' %}
         WHERE d1.kushin_mode in (1, 2, 3)
       {% elsif kushin_mode._parameter_value == 'kushin_teijo_start' %}
         WHERE d1.kushin_mode in (1, 4, 5)
       {% else %}
       {% endif %}
    ;;
  }

  dimension: a004_2001 {
    label: "a004_2001_リング番号"
    type: number
    sql: ${TABLE}.a004_2001 ;;
  }

  dimension_group: datetime {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.datetime ;;
  }

#  dimension: datetime {
#    label: "日時"
#    type: date
#    primary_key: yes
#    sql: ${TABLE}.datetime ;;
#  }

  measure: start_datetime {
    label: "最小日時"
    type: min
    sql: ${TABLE}.datetime ;;
  }

  measure: end_datetime {
    label: "最大日時"
    type: max
    sql: ${TABLE}.datetime ;;
  }

  measure: a246_2340 {
    label: "a246_2340_カッタートルク"
    type: average
    sql: ${TABLE}.a246_2340 ;;
  }

  measure: a246_2340_30sec_AVG {
    label: "a246_2340_カッタートルク_過去30秒の平均"
    type: average
    sql: ${TABLE}.a246_2340_30sec_AVG ;;
  }

  measure: a246_2340_10min_AVG {
    label: "a246_2340_カッタートルク_過去10分の平均"
    type: average
    sql: ${TABLE}.a246_2340_10min_AVG ;;
  }

  measure: cutter_torque_30r_avg {
    label: "a246_2340_カッタートルク_過去30Rの平均"
    type: average
    sql: ${TABLE}.cutter_torque_30r_avg ;;
  }

  measure: cutter_torque_30r_stddev {
    label: "a246_2340_カッタートルク_過去30Rの標準偏差"
    type: average
    sql: ${TABLE}.cutter_torque_30r_stddev ;;
  }


}
