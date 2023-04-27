create table  mimic_iv.extra_vars as
  select * from PIVOT(
    'select ch.stay_id, d.label, avg(valuenum) as value
      from mimic_ichartevents as ch
        inner join mimic_iv.icustays as i
          on ch.stay_id = i.stay_id
        inner join d_items as d
          on d.itemid = ch.itemid
        where ch.valuenum is not null
          and d.label in (''Admission Weight (Kg)'', ''GCS - Eye Opening'', ''GCS - Motor Response'', ''GCS - Verbal Response'', ''Height (cm)'')
          and ch.valuenum != 0
          and UNIX_SECONDS(''hour'', ch.charttime) - date_part(''hour'', i.intime) between -24 and 5
        group by ch.stay_id, d.label'
        ) as ct(stay_id integer, weight double precision, eyes double precision, motor double precision, verbal double precision, height double precision);
