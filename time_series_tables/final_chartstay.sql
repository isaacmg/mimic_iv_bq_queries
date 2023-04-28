CREATE TABLE mimic_iv.final_chartstay as SELECT * FROM mimic_iv.intermediate_stay as chartstay
WHERE 72717 > (
    SELECT
        --  only keep data that is present at some point for at least 25% of the patients, this gives us 129 chartevents features
        count(DISTINCT stay_id) AS count
      FROM
        mimic_iv.ld_labels
  ) * NUMERIC '0.25'
ORDER BY
  count DESC NULLS FIRST
