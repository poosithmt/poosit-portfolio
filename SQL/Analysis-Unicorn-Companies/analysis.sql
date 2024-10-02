WITH top_industries AS (
    -- First CTE to find the top 3 performing industries by number of unicorns
    SELECT i.industry
    FROM industries AS i
    JOIN dates AS d
    USING(company_id)
    WHERE EXTRACT(year FROM d.date_joined) IN (2019, 2020, 2021)
    GROUP BY i.industry
    ORDER BY COUNT(*) DESC
    LIMIT 3  -- Top 3 industries
),
second_query AS (
    -- Second CTE to calculate the unicorn count and average valuation for each industry by year
    SELECT
        i.industry AS industry,
        EXTRACT(year FROM d.date_joined) AS year,
        COUNT(*) AS num_unicorns,
        AVG(f.valuation) AS average_valuation
    FROM industries AS i
    JOIN dates AS d
    USING(company_id)
    JOIN funding AS f
    USING(company_id)
    WHERE EXTRACT(year FROM d.date_joined) IN (2019, 2020, 2021)
    GROUP BY i.industry, year
)

SELECT
    sq.industry,
    sq.year,
    sq.num_unicorns,
    ROUND(sq.average_valuation / 1000000000, 2) AS average_valuation_billions
FROM second_query AS sq
WHERE sq.industry IN (SELECT industry FROM top_industries)
  AND sq.year IN (2019, 2020, 2021)
GROUP BY sq.industry, sq.year, sq.num_unicorns, sq.average_valuation
ORDER BY sq.industry, sq.year DESC;
