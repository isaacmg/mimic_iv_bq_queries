CREATE TABLE mimic_iv.ld_common2 as SELECT * FROM mimic_iv.ld_commonlabs, `gmap-997.mimic_iv.distinct_count` as d1
 WHERE d1.c > 73181 * NUMERIC '0.26'
