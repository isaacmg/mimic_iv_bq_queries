CREATE TABLE mimic_iv.ld_timeserieslab AS SELECT
    --  we extract the number of minutes in labresultoffset because this is how the data in eICU is arranged
    la.stay_id AS patientunitstayid,
    floor((UNIX_SECONDS(CAST(CAST(l.charttime as DATE) AS TIMESTAMP)) - CAST(UNIX_SECONDS(CAST(CAST(la.intime as DATE) AS TIMESTAMP)) as FLOAT64)) / 60) AS labresultoffset,
    d.label AS labname,
    l.valuenum AS labresult
  FROM
    `physionet-data.mimiciv_hosp.labevents` AS l
    INNER JOIN mimic_iv.d_labitems AS d ON d.itemid = l.itemid
    INNER JOIN mimic_iv.ld_common2 AS cl ON cl.label = d.label
    INNER JOIN --  only include the common labs
    mimic_iv.ld_labels AS la ON la.hadm_id = l.hadm_id
  WHERE (UNIX_SECONDS(CAST(CAST(l.charttime as DATE) AS TIMESTAMP)) - CAST(UNIX_SECONDS(CAST(CAST(la.intime as DATE) AS TIMESTAMP)) as FLOAT64)) / (60 * 60 * 24) BETWEEN -1 AND la.los
   AND l.valuenum IS NOT NULL
;
--  only extract data for the cohort
--  epoch extracts the number of seconds since 1970-01-01 00:00:00-00, we want to extract measurements between
--  admission and the end of the patients' stay
--  filter out null values
