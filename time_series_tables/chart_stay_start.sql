CREATE TABLE mimic_iv.inner_common_chart as SELECT
      --  extracting the itemids for all the chartevents that occur within the time bounds for our cohort
      ch.itemid,
      la.stay_id
    FROM
      mimic_iv.chartevents AS ch
      INNER JOIN mimic_iv.ld_labels AS la ON la.stay_id = ch.stay_id
    WHERE ch.valuenum IS NOT NULL
     AND (UNIX_SECONDS(CAST(CAST(ch.charttime as DATE) AS TIMESTAMP)) - CAST(UNIX_SECONDS(CAST(CAST(la.intime as DATE) AS TIMESTAMP)) as FLOAT64)) / (60 * 60 * 24) BETWEEN -1 AND la.los