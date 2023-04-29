Many of the queries in the original paper did not translate well into BigQuery SQL and had to be broken up. Here is how we 

Fixing the `ld_timeserieslab` query

Fixing the `ld_commonlabs` query 

1. First we run `common_labs_base.sql`
 2. Then we run `ld_common2.sql`

Fixing the `ld_commonchart` query

1. First we create the `inner_common_chart` by running `inner_common_chart.sql`
    2. Then we run `common_chart_intermediate.sql`
    3. Then we create `intermediate_stay` by running `intermediate_stay.sql`...
    Note we did run the query 
    
    ```
    SELECT count(DISTINCT chartstay.stay_id) FROM mimic_iv.intermediate_stay as chartstay
    ``` 

    To get the value of 72717

    4. Finally we run `final_chartstay.sql` which creates `final_chartstay`
In the end this creates a table comparable to ld_commonchart



