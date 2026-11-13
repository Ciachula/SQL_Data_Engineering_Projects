/*

Question: Which skills are most sought after for remote data engineering roles?
- Find the 10 skills that appear most often in data engineer job postings
- Include only remote (work-from-home) positions
- Why? Shows which skills employers value most in remote data engineering,
  helping job seekers decide what to learn or highlight on their resumes

*/

SELECT
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf 
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 10;

/*

Summary of the most in-demand skills for remote data engineers:
SQL and Python lead the ranking by a wide margin, each appearing in roughly 29,000 postings,
almost twice as many as any other skill.
Cloud skills come next: AWS with about 18,000 postings and Azure with about 14,000.
Apache Spark takes fifth place with close to 13,000 postings, showing strong demand
for large-scale data processing.

Key insights:
- SQL and Python are the core skills every data engineer is expected to have
- Experience with a cloud platform (AWS or Azure) is a standard requirement
- Spark and other big data technologies remain highly valued
- Pipeline and data platform tools (Airflow, Snowflake, Databricks) appear frequently
- Java and GCP complete the top 10


┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
├────────────┴──────────────┤
│ 10 rows         2 columns │
└───────────────────────────┘
*/