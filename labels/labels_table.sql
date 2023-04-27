CREATE TABLE mimic_iv.ld_labels AS SELECT
    i.subject_id,
    i.hadm_id,
    i.stay_id,
    i.intime,
    i.outtime,
    adm.hospital_expire_flag,
    i.los
  FROM
    physionet-data.mimiciv_icu.icustays AS i
    INNER JOIN physionet-data.mimiciv_hosp.admissions AS adm ON adm.hadm_id = i.hadm_id
    INNER JOIN physionet-data.mimiciv_hosp.patients AS p ON p.subject_id = i.subject_id
  WHERE i.los > div(5, 24)
   AND extract(YEAR from CAST(i.intime as DATE)) - p.anchor_year + p.anchor_age > 17
;
--  and exclude anyone who doesn't have at least 5 hours of data
--  only include adults
