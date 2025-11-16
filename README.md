# Introduction
This project analyses the job postings data to identify the **highest-paying** Data Analyst roles, the **skills required** for them, and which skills offer the **best salary advantage**.

Accessing the Queries: [project_sql](/project_sql/)

# Background
The dataset used to identify these Data Analyst roles and skills contains the tables: **job_postings_fact, company_dim, skills_job_dim and skills_dim.**

Accessing the Tables: [csv_files](/csv_files/)

## Key questions that will be answered:
**1.** What are the **top-paying** Data Analyst **jobs** in the **UK**?

**2.** What **skills** are **required** for these top-paying jobs?

**3.** What are the **most in-demand skills** for Data Analysts?

**4.** What **skills** are associated with **higher salaries**?

**5.** What are the most **optimal skills** to learn?

# Tools I Used
To dive deeper into the Data Analyst job market, several softwares were used, including:

- **SQL:** This was used to query the database and extract key information.
- **PostgreSQL:** This was the chosen database management system.
- **Visual Studio Code:** This was used as my main environment for writing and running SQL queries.
- **Git & GitHub:** This was used to version-control the project, ensuring easy project tracking.
# Analysis
Each Query for this project aimed to investigate a specific aspect of the Data Analyst job market.

Here's how it was approached:

## 1. Top-paying Data Analyst jobs in the UK
To identify the highest-paying roles, I filtered Data Analyst positions by their average yearly salary, focusing on roles in the UK. 
```sql
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
    job_location = 'United Kingdom' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
The results from the query:

| Job Title                                     | Company                 | Salary (£) |
|-----------------------------------------------|--------------------------|------------|
| Market Data Lead Analyst                      | Deutsche Bank           | 180000     |
| Data Architect - Trading and Supply           | Shell                   | 156500     |
| Sr Data Analyst                               | Hasbro                  | 118140     |
| Fraud Data Analyst                            | esure Group             | 109000     |
| Project Data Analyst - Operational Excellence | Syngenta Group          | 105000     |
| Senior Scientist, Computational Biology       | Flagship Pioneering     | 89100      |
| Global IT Data Analytics Solutions Expert     | Campari Group           | 86400      |
| Data Analyst                                  | Nominet                 | 77017.5    |
| Data Analyst - Customer Services              | Informa Group Plc.      | 75550      |
| Global Mobility Data Analyst                  | CHANEL                  | 75067.5    |


Here's the breakdown of the findings:
 
- **Wide Salary Range** - The top 10 Data Analyst roles in the UK span from **£75,000 to £180,000**, indicating the salary potential of the field.
- **Diverse Employers** - Many companies in **unique sectors**, such as finance, energy, life sciences and technology, are involved in the recruitment of Data Analysts, signifying a **broad interest** in the role across different industries.
- **Job Title Variety** - There's also a **high diversity** in job titles, ranging from Data Analyst to Market Data Lead Analyst, reflecting varied roles and specializations within data analytics.

## 2. Skills required for top-paying jobs
After identifying the highest-paying roles, I joined those job-listings with the skills tables to find which technical skills were most frequently associated with top-paying positions.

```sql
WITH top_paying_jobs AS(
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
        job_location = 'United Kingdom' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills_dim.skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON
    skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN skills_dim ON
    skills_dim.skill_id = skills_job_dim.skill_id;
```
The results from the query:

| Job Title                                | Company                    | Salary (£) | Skill     |
|-------------------------------------------|-----------------------------|-------------|-----------|
| Market Data Lead Analyst                  | Deutsche Bank              | 180000      | Excel     |
| Data Architect - Trading and Supply       | Shell                      | 156500      | Shell     |
| Data Architect - Trading and Supply       | Shell                      | 156500      | Express   |
| Data Architect - Trading and Supply       | Shell                      | 156500      | Excel     |
| Data Architect - Trading and Supply       | Shell                      | 156500      | Flow      |
| Sr Data Analyst                           | Hasbro                     | 118140      | SQL       |
| Sr Data Analyst                           | Hasbro                     | 118140      | Python    |
| Sr Data Analyst                           | Hasbro                     | 118140      | Jupyter   |
| Sr Data Analyst                           | Hasbro                     | 118140      | Tableau   |
| Sr Data Analyst                           | Hasbro                     | 118140      | Power BI  |
| Sr Data Analyst                           | Hasbro                     | 118140      | Looker    |
| Fraud Data Analyst                        | esure Group                | 109000      | SQL       |
| Fraud Data Analyst                        | esure Group                | 109000      | Python    |
| Fraud Data Analyst                        | esure Group                | 109000      | SAS       |
| Fraud Data Analyst                        | esure Group                | 109000      | Excel     |
| Fraud Data Analyst                        | esure Group                | 109000      | Tableau   |
| Fraud Data Analyst                        | esure Group                | 109000      | SAS       |
| Project Data Analyst - Operational Excellence | Syngenta Group          | 105000      | Tableau   |
| Senior Scientist, Computational Biology   | Flagship Pioneering        | 89100       | Python    |
| Senior Scientist, Computational Biology   | Flagship Pioneering        | 89100       | GO        |
| Senior Scientist, Computational Biology   | Flagship Pioneering        | 89100       | Jupyter   |
| Senior Scientist, Computational Biology   | Flagship Pioneering        | 89100       | Git       |
| Senior Scientist, Computational Biology   | Flagship Pioneering        | 89100       | Unify     |
| Global IT Data Analytics Solutions Expert | Campari Group              | 86400       | Python    |
| Global IT Data Analytics Solutions Expert | Campari Group              | 86400       | R         |
| Global IT Data Analytics Solutions Expert | Campari Group              | 86400       | Azure     |
| Global IT Data Analytics Solutions Expert | Campari Group              | 86400       | Databricks|
| Global IT Data Analytics Solutions Expert | Campari Group              | 86400       | SAP       |
| Data Analyst                              | Nominet                    | 77017.5     | SQL       |
| Data Analyst                              | Nominet                    | 77017.5     | Python    |
| Data Analyst                              | Nominet                    | 77017.5     | R         |
| Data Analyst - Customer Services          | Informa Group Plc.         | 75550       | TypeScript|
| Data Analyst - Customer Services          | Informa Group Plc.         | 75550       | VBA       |
| Data Analyst - Customer Services          | Informa Group Plc.         | 75550       | Excel     |
| Data Analyst - Customer Services          | Informa Group Plc.         | 75550       | Power BI  |
| Data Analyst - Customer Services          | Informa Group Plc.         | 75550       | Notion    |
| Global Mobility Data Analyst              | CHANEL                     | 75067.5     | Excel     |


Here's the breakdown of the findings:
 
- **Skill Combination** - The top salaries combine both core skills like **SQL, Excel and Python**, with more niche skills such as **SAS and Express**, indicating the importance of foundations in higher-salary jobs.
- **Importance of Visualization** - Many companies value visualization tools such as **Tableau, Power BI and Looker**, showing their importance in all analyst positions.

## 3. Most in-demand skills for Data Analysts
To determine what employers request most often, I counted how frequently each skill appeared across Data Analyst job postings, giving me a clear view of the market's overall skill demand.

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON
    skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON
    skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'United Kingdom'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 10;
```
The results from the query:

| Skills     | Demand |
|------------|--------|
| SQL        | 867    |
| Excel      | 776    |
| Power BI   | 557    |
| Python     | 455    |
| Tableau    | 361    |
| R          | 238    |
| SAS        | 142    |
| Azure      | 136    |
| PowerPoint | 94     |
| Word       | 93     |

Here's the breakdown of the findings:
 
- **Domation of foundational tools** - Skills such as **SQL** (867 mentions) and **Excel** (776 mentions) are the most requested across all job postings, showing that fundamental data handling and spreadsheet skills remain essential.
- **The need for Visualization** - **Power BI** (557 mentions) and **Tableau **(361 mentions) both appear in the top 5 skills in-demand, highlighting the importance of data visualization to drive business insights through dashboards.
- **Programming** - **Python** (455 mentions) and **R** (238 mentions) appear as the most in-demand coding languages, reinforcing its role in data analytics and automation in machine-learning workflows.

## 4. Highest-paying skills for Data Analysts
I then calculated the average yearly salary associated with each skill, by joining salaries with their required skills, highlighting which skills tend to be linked together with higher compensation.

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON
    skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON
    skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location = 'United Kingdom'
GROUP BY
    skills
ORDER BY
    average_salary DESC
LIMIT 25;
```
The results from the query:

| Skills     |Average Salary (£)|
|------------|------------------|
| Shell      | 156500         |
| Flow       | 156500         |
| Looker     | 118140         |
| SAS        | 109000         |
| Express    | 104757         |
| Jupyter    | 103620         |
| Unify      | 89100          |
| Git        | 89100          |
| SAP        | 86400          |
| Azure      | 86400          |
| Databricks | 86400          |
| Python     | 83968          |
| Excel      | 82494          |
| R          | 81709          |
| Tableau    | 78428          |
| Go         | 77635          |
| Notion     | 75550          |
| VBA        | 75550          |
| TypeScript | 75550          |
| Power BI   | 74563          |
| Sheets     | 72900          |
| SQL        | 65818          |
| Terminal   | 53014          |
| Linux      | 53014          |

Here's the breakdown of the findings:

- **Specialized skills** - Skills like **Shell and Flow** top the list at **£156,500**, indicating that niche or highly technical expertise are required for significantly higher earning potential.
- **Programming** - **Python, Go and TypeScript** all appear with competitive salaries, reinforcing the value of versatile coding skills.
- **Foundational analyst tools** - Whilst not appearing towards the top of the list, skills like **Excel, Tableau, Power BI and SQL** still show solid salary standards, demondstrating the consistent demand and compensation for core analytical skills.


## 5. Most optimal skills to learn
Finally, by combining the demanded skills and the salary analyses, I identified the skills that are both highly requested and offer a strong compensation, making them the most strategic skills to learn. 

### Key changes to note:
In this section, filtering for only jobs in the UK has been removed, as it results in a very small sample size (<100), which would not allow an accurate representation of the results. Therefore, all job locations are taken into consideration when searching for the most optimal skill.

```sql
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
        -- AND job_location = 'United Kingdom'
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
```
The results from the query:

| Skills     | Demand | Average Salary (£)|
|------------|--------|----------------|
| SQL        | 3083   | 96435          |
| Excel      | 2143   | 86419          |
| Python     | 1840   | 101512         |
| Tableau    | 1659   | 97978          |
| R          | 1073   | 98708          |
| Power BI   | 1044   | 92324          |
| Word       | 527    | 82941          |
| PowerPoint | 524    | 88316          |
| SAS        | 500    | 93707          |

Here's the breakdown of the findings:
 
- **The value of SQL** - SQL with **3083 mentions**, is at the top of the list with a salary average of **£96,435**, signifying its importance for both job availability and earning potential.
- **The runner-ups** - **Excel** (2143 mentions), **Python** (1840 mentions)and **R** (1073 mentions) appear in the top 3 skills, proving how essential spreadsheet programming and coding are in the job market for Data Analysts.
- **Data visualization tools, yet again** - **Tableau** (1659 mentions) and **Power BI** (1044 mentions) consistently have shown a high demand and competitive pay, indicating that communication of data is an important skill to have as a Data Analyst.
- **Office Tools** - **Word** and **Powerpoint** also appear in the top 10. Whilst having a 6-fold lower demand than SQL, employers have shown to still value communication and documentation using these skills.

# What I Learned
Throughout this project, I strengthened my SQL skills and gained a clearer understanding of the data analytics job market. Here are the key takeaways:

**1. SQL Skills**

I learned how to use:

- CTEs to structure complex queries.
- Joins to combine job, company, and skill data.
- Aggregations to calculate demand counts and salary averages.
- Subqueries for comparing values against overall averages.
- Filtering and sorting to extract the top-paying jobs and most in-demand skills.

**2. Skills & Salary Analysis**

I learned how to link jobs with their required skills and identify:

- The most demanded skills.
- The highest-paying skills.
- The skills that offer the best overall value (high demand + high salary).

**3. Data Interpretation**

I improved at turning raw query results into insights to:
- Spot salary trends,
- Understand industry differences.
- Recognizing which skills matter most for Data Analyst roles.

**4. Project & Git Workflow**

I gained experience in:
- Organizing SQL scripts,
- Working with a clear analysis structure. 
- Using Git to track changes and manage the project.

# Conclusions
## New Insights

**1.** What are the **top-paying** Data Analyst **jobs** in the **UK**?

- The highest salaries ranged from **£75k to £180k**, showing strong earning potential.

- High-paying roles came from **finance, energy, life sciences, and tech**, highlighting industry diversity.

**2.** What **skills** are **required** for these top-paying jobs?

- Top-paying roles frequently required **Excel, SQL, Python, Tableau, Power BI, Shell, and Looker**.

- Both technical **programming skills and business intelligence tools** appeared across high-salary positions.

**3.** What are the **most in-demand skills** for Data Analysts?

- **SQL, Excel, Python, Tableau, and R** were the most frequently requested skills across all job postings.

- Demand heavily favored core data skills, especially SQL with the highest count.

**4.** What **skills** are associated with **higher salaries**?

- Skills like **Shell, Flow, Looker, SAS, and Jupyter** were associated with the highest average salaries.

- These tend to be specialized or niche tools, which **drives their salary up**.

**5.** What are the most **optimal skills** to learn?

- **SQL, Python, Tableau, R, and Power BI** ranked strong in both demand and salary.

- These skills offer the **best balance**, making them highly valuable for career growth.

