/* Q: What are the top-paying Data Analyst jobs?
- Identify the top 10 Data Analyst roles, that are in the UK.
- Focus on job postings wth specified salaries (no NULLs).
*/

SELECT
    job_id,
    job_title,
    name AS company_name,
    salary_year_avg
FROM
    job_postings_fact
LEFT JOIN company_dim ON
    job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
    AND job_location = 'United Kingdom'
ORDER BY
    salary_year_avg DESC
LIMIT 10;