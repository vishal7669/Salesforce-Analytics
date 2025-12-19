select * from opportunity;

-- kpi1 --

SELECT 
    SUM(CAST(REPLACE(Expected_Amount, '$', '') AS DECIMAL(10, 2))) AS total_expected_amount
FROM 
    opportunity
WHERE 
    Expected_Amount IS NOT NULL;

-- kpi2 --


  SELECT 
    COUNT(*) AS Active_Opportunities
FROM 
    opportunity
WHERE 
    Closed = 'FALSE';
    
    -- kpi3 --
    
    SELECT 
    (SUM(CASE WHEN `Won` = 'TRUE' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS Conversion_Rate_Percent
FROM 
    opportunity;
    
   -- kpi4 --
 
    SELECT 
    ROUND(
        (SUM(CASE WHEN Won = 'True' THEN 1 ELSE 0 END) /
         NULLIF(SUM(CASE WHEN Stage IN ('Closed Won', 'Closed Lost') THEN 1 ELSE 0 END), 0)
        ) * 100, 
        2
    ) AS Win_Rate_Percentage
FROM 
    opportunity;

 -- kpi5 --  
 
 SELECT 
    ROUND(
        (SUM(CASE WHEN `Stage` = 'Closed Lost' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2
    ) AS loss_rate_percent
FROM 
    opportunity;
    
    --  kpi6 --
    
    SELECT
    DATE_FORMAT(STR_TO_DATE(Close_Date, '%m/%d/%Y'), '%Y-%m') AS month,
    COUNT(*) AS total_opportunities,
    SUM(CASE WHEN Won = TRUE THEN 1 ELSE 0 END) AS won_opportunities,
    SUM(CASE WHEN `Stage` = 'Closed Lost' THEN 1 ELSE 0 END) AS lost_opportunities,
    SUM(CASE WHEN Closed = FALSE THEN 1 ELSE 0 END) AS open_opportunities
FROM
    opportunity
WHERE
    Close_Date IS NOT NULL
GROUP BY
    month
ORDER BY
    month;


-- kpi7 --

SELECT
    Close_Date,
    SUM(CAST(Replace(Replace(Expected_Amount,',',''),'$','') AS DECIMAL(15,2))) AS daily_expected,
    SUM(CAST(Replace(Replace(Amount, ',',''),'$','') AS DECIMAL(15,2))) AS daily_forecast,
    SUM(SUM(CAST(Replace(Replace(Expected_Amount,',',''),'$','') AS DECIMAL(15,2)))) OVER (ORDER BY 'Close Date') AS running_expected_total,
    SUM(SUM(CAST(Replace(Replace(Amount,',',''),'$','') AS DECIMAL(15,2)))) OVER (ORDER BY 'Close Date') AS running_forecast_total
FROM
    opportunity
WHERE
    Close_Date IS NOT NULL
GROUP BY
    Close_Date
ORDER BY
    Close_Date;
    
    
    -- kpi8 --
    
    SELECT
    Close_Date AS close_date,
    COUNT(*) AS daily_total,
    SUM(CASE WHEN LOWER(TRIM(Closed)) != 'true' THEN 1 ELSE 0 END) AS daily_active,
    SUM(COUNT(*)) OVER (ORDER BY Close_Date) AS cumulative_total,
    SUM(SUM(CASE WHEN LOWER(TRIM(Closed)) != 'true' THEN 1 ELSE 0 END)) OVER (ORDER BY Close_Date) AS cumulative_active
FROM
    opportunity
WHERE
    Close_Date IS NOT NULL
GROUP BY
    Close_Date
ORDER BY
    Close_Date;
    
    -- kpi9 --
    
    SELECT
    Close_Date AS close_date,
    COUNT(*) AS daily_total,
    SUM(CASE WHEN LOWER(TRIM(Stage)) = 'closed won' THEN 1 ELSE 0 END) AS daily_closed_won,
    SUM(COUNT(*)) OVER (ORDER BY Close_Date) AS cumulative_total,
    SUM(SUM(CASE WHEN LOWER(TRIM(Stage)) = 'closed won' THEN 1 ELSE 0 END)) OVER (ORDER BY Close_Date) AS cumulative_closed_won
FROM
    opportunity
WHERE
    Close_Date IS NOT NULL
GROUP BY
    Close_Date
ORDER BY
    Close_Date;
    
    -- kpi10 --
    
    SELECT
	Close_Date AS close_date,
    COUNT(*) AS daily_closed,
    SUM(CASE WHEN LOWER(TRIM(Stage)) = 'closed won' THEN 1 ELSE 0 END) AS daily_closed_won,
    SUM(COUNT(*)) OVER (ORDER BY Close_Date) AS cumulative_closed,
    SUM(SUM(CASE WHEN LOWER(TRIM(Stage)) = 'closed won' THEN 1 ELSE 0 END)) OVER (ORDER BY Close_Date) AS cumulative_closed_won
FROM
    opportunity
WHERE
    Close_Date IS NOT NULL
    AND LOWER(TRIM(Stage)) IN ('closed won', 'closed lost')
GROUP BY
    Close_Date
ORDER BY
    Close_Date;
    
   -- kpi 11-- 
    
    SELECT 
    'Opportunity Type',
    SUM(CAST(REPLACE(REPLACE(Expected_Amount, '$', ''), ',', '') AS DECIMAL(18,2))) AS Total_Expected_Amount
FROM 
    opportunity
WHERE 
    Expected_Amount IS NOT NULL
GROUP BY 
    'Opportunity Type'
ORDER BY 
    Total_Expected_Amount DESC;


-- kpi 12--

SELECT 
    Industry,
    COUNT(*) AS Opportunity_Count
FROM 
    opportunity
WHERE 
    Industry IS NOT NULL
GROUP BY 
    Industry
ORDER BY 
    Opportunity_Count DESC;
