view: kensho {
  sql_table_name: `shield.kensho`
    ;;

  dimension_group: column0 {
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
    sql: ${TABLE}.column0 ;;
  }

  dimension: column1 {
    type: number
    sql: ${TABLE}.column1 ;;
  }

  dimension: column2 {
    type: number
    sql: ${TABLE}.column2 ;;
  }

  dimension: column3 {
    type: number
    sql: ${TABLE}.column3 ;;
  }

  dimension: column4 {
    type: number
    sql: ${TABLE}.column4 ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
