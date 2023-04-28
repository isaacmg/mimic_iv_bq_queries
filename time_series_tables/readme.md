This code aims to replicate the queries found in [TPC Loss Prediction](https://github.com/EmmaRocheteau/TPC-LoS-prediction/blob/master/MIMIC_preprocessing/timeseries.sql). Many of these queries did not play well with BQ (small size but complex join logic and functions) at all so they had to be edited into smaller queries that run step by step. Here I will outline the order to run these queries for purposes of creation.


Query creating chart ld_commonchart

1. Run the 