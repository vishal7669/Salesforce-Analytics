select * from leadtable;

-- kpi 1 --

SELECT COUNT(*) AS total_leads
FROM leadtable;

-- kpi 3 --

SELECT 
  (COUNT(CASE WHEN Converted = 'True' THEN 1 END) * 100.0 / COUNT(*)) AS conversion_rate_percentage
FROM leadtable;

-- kpi 4 --

SELECT DISTINCT `Converted Account ID`
FROM leadtable
WHERE `Converted Account ID` IS NOT NULL;


-- kpi 5 --

SELECT DISTINCT `Converted Opportunity ID`
FROM leadtable
WHERE `Converted Opportunity ID` IS NOT NULL;

-- kpi 6--

SELECT `Lead Source`, COUNT(*) AS total_leads
FROM leadtable
GROUP BY `Lead Source`
ORDER BY total_leads DESC;

-- kpi 7--

SELECT Industry, COUNT(*) AS total_leads
FROM leadtable
GROUP BY Industry
ORDER BY total_leads DESC;

-- kpi 8--

SELECT Status, COUNT(*) AS total_leads
FROM leadtable
GROUP BY Status
ORDER BY total_leads DESC;












