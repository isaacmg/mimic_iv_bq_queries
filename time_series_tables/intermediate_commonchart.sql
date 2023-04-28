CREATE TABLE mimic_iv.intermediate_stay as SELECT 
    --  we want the features to have at least 5 values entered for the average patient
    d.label,
    chartstay.stay_id,
    count(DISTINCT chartstay.stay_id) AS count,
    a.avg_obs
  FROM
    `gmap-997.mimic_iv.ld_commonchart` as chartstay
    INNER JOIN mimic_iv.d_items AS d ON d.itemid = chartstay.itemid
    INNER JOIN mimic_iv.avg_obs_per_stay AS a ON a.itemid = chartstay.itemid
  GROUP BY 1, 4, chartstay.stay_id
