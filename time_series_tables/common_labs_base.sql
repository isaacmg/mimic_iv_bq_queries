CREATE TABLE mimic_iv.ld_commonlabs
  AS
    WITH labsstay AS (
      SELECT
          --  extracting the itemids for all the labevents that occur within the time bounds for our cohort
          l.itemid,
          la.stay_id
        FROM
          physionet-data.mimiciv_hosp.labevents AS l
          INNER JOIN mimic_iv.ld_labels AS la ON la.hadm_id = l.hadm_id
        WHERE l.valuenum IS NOT NULL
         AND (UNIX_SECONDS(CAST(CAST(l.charttime as DATE) AS TIMESTAMP)) - CAST(UNIX_SECONDS(CAST(CAST(la.intime as DATE) AS TIMESTAMP)) as FLOAT64)) / (60 * 60 * 24) BETWEEN -1 AND la.los
    ), avg_obs_per_stay AS (
      SELECT
          --  stick to the numerical data
          --  epoch extracts the number of seconds since 1970-01-01 00:00:00-00, we want to extract measurements between
          --  admission and the end of the patients' stay
          --  getting the average number of times each itemid appears in an icustay (filtering only those that are more than 2)
          obs_per_stay.itemid,
          avg(CAST(obs_per_stay.count as BIGNUMERIC)) AS avg_obs
        FROM
          (
            SELECT
                labsstay.itemid,
                count(*) AS count
              FROM
                labsstay
              GROUP BY 1, labsstay.stay_id
          ) AS obs_per_stay
        GROUP BY 1
        HAVING avg(CAST(obs_per_stay.count as BIGNUMERIC)) > 3
    )
    SELECT
        --  we want the features to have at least 3 values entered for the average patient
        d.label,
        count(DISTINCT labsstay.stay_id) AS count,
        a.avg_obs
      FROM
        labsstay
        INNER JOIN mimic_iv.d_labitems AS d ON d.itemid = labsstay.itemid
        INNER JOIN avg_obs_per_stay AS a ON a.itemid = labsstay.itemid
      GROUP BY 1, 3, labsstay.stay_id