CREATE TABLE mimic_iv.timeserieslab_final as SELECT * FROM mimic_iv.ld_timeserieslab as t INNER JOIN`gmap-997.mimic_iv.ld_common2` as l 
on t.labname=l.label

-- TIMES OUT THOUGHH :( ,