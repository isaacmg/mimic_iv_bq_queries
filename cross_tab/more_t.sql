create table ld_flat as
  select distinct i.stay_id as patientunitstayid, p.gender, (extract(year from i.intime) - p.anchor_year + p.anchor_age) as age,
    adm.ethnicity, i.first_careunit, adm.admission_location, adm.insurance, ev.height, ev.weight,
    extract(hour from i.intime) as hour, ev.eyes, ev.motor, ev.verbal
    from ld_labels as la
    inner join patients as p on p.subject_id = la.subject_id
    inner join icustays as i on i.stay_id = la.stay_id
    inner join admissions as adm on adm.hadm_id = la.hadm_id