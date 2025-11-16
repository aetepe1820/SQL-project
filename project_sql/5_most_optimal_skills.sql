/* Q: What are the most optimal skills to learn?
- aka. High in-demand and High-paying.
*/

WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON
        skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON
        skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL 
        --AND job_location = 'United Kingdom'
    GROUP BY
        skills_dim.skill_id
), top_skills AS (
    SELECT
        skills_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS average_salary
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON
        skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON
        skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL 
        --AND job_location = 'United Kingdom'
    GROUP BY
        skills_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    average_salary
FROM
    skills_demand
INNER JOIN top_skills ON
    top_skills.skill_id = skills_demand.skill_id
ORDER BY
    demand_count DESC,
    average_salary DESC
LIMIT 10;