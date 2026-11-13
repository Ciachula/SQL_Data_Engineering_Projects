/*

Question: Which skills are associated with the highest salaries for data engineers?
- Compute the median salary for every skill listed in data engineer job postings
- Include only remote positions that state a salary
- Add the number of postings per skill to show demand alongside pay
- Why? Combining salary and frequency shows which skills are both well paid and widely
  requested, making it easier to decide which skills are worth learning first

*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
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
HAVING
    COUNT(jpf.*) > 100
ORDER BY
    median_salary DESC
LIMIT 25;

/*
Key insights:

- Salary range: all top 25 skills have a median salary between $147.5K and $210K.
- Pay vs. demand: the best-paid skills are rarely the most requested ones.
- Software engineering skills pay well: many top-paying skills come from
  backend development. Data engineers with strong programming skills earn more.
- Infrastructure and DevOps: Terraform, Kubernetes, Ansible, VMware, Bitbucket
  and Atlassian show that infrastructure-as-code, containers and CI/CD
  experience are valued in data engineering roles.
- Databases beyond SQL: Neo4j ($170K), MongoDB ($162K) and Redis ($149K)
  show a premium for graph, document and in-memory databases.
- Low sample sizes: Zoom (127), Crystal (129) and VMware (136) have very few
  postings, so their medians are less reliable and should not be over-interpreted.

Conclusion: For the best balance of pay and job opportunities, focus on Terraform,
Kubernetes and Airflow (high demand with $150K+ salaries), then add a backend
language such as Golang to reach the higher salary range.

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ golang     │      184000.0 │          912 │
│ terraform  │      184000.0 │         3248 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169616.0 │          582 │
│ zoom       │      168438.0 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ django     │      155000.0 │          265 │
│ bitbucket  │      155000.0 │          478 │
│ crystal    │      154224.0 │          129 │
│ c          │      151500.0 │          444 │
│ atlassian  │      151500.0 │          249 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ node       │      150000.0 │          179 │
│ airflow    │      150000.0 │         9996 │
│ ruby       │      150000.0 │          736 │
│ css        │      150000.0 │          262 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ ansible    │      148798.0 │          475 │
│ jupyter    │      147500.0 │          400 │
├────────────┴───────────────┴──────────────┤
│ 25 rows                         3 columns │
└───────────────────────────────────────────┘
*/