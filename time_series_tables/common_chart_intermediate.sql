CREATE TABlE mimic_iv.ld_commonchart AS WITH chartstay AS (
 SELECT * FROM mimic_iv.inner_common_chart
), avg_obs_per_stay AS (
  SELECT
      --  stick to the numerical data
      --  epoch extracts the number of seconds since 1970-01-01 00:00:00-00, we want to extract measurements between
      --  admission and the end of the patients' stay
      --  getting the average number of times each itemid appears in an icustay (filtering only those that are more than 5)
      obs_per_stay.itemid,
      avg(CAST(obs_per_stay.count as BIGNUMERIC)) AS avg_obs
    FROM
      (
        SELECT
            chartstay.itemid,
            count(*) AS count
          FROM
            chartstay
          GROUP BY 1, chartstay.stay_id
      ) AS obs_per_stay
    GROUP BY 1
    HAVING avg(CAST(obs_per_stay.count as BIGNUMERIC)) > 5
)
SELECT * FROM chartstay