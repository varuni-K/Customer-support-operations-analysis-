-- =====================================================
-- Customer Support Operations & Performance Analysis
-- Database: support_db | Table: tickets (4,960 cleaned tickets)
-- Data source: synthetic dataset created for this project
-- =====================================================

USE support_db;

-- Q1. Which ticket categories generate the most tickets?
SELECT category, COUNT(*) AS total_tickets
FROM tickets
GROUP BY category
ORDER BY total_tickets DESC;

-- Q2. Which priority levels take the longest to resolve?
SELECT priority, ROUND(AVG(resolution_hours), 1) AS avg_hours
FROM tickets
WHERE resolution_hours IS NOT NULL
GROUP BY priority
ORDER BY avg_hours;

-- Q3. What percentage of tickets are resolved?
SELECT COUNT(*) AS total_tickets,
       SUM(CASE WHEN status = 'Resolved' THEN 1 ELSE 0 END) AS resolved_tickets,
       ROUND(100 * SUM(CASE WHEN status = 'Resolved' THEN 1 ELSE 0 END) / COUNT(*), 1) AS resolution_rate_pct
FROM tickets;

-- Q4. Which categories miss their SLA deadline most often?
SELECT category,
       COUNT(*) AS resolved_tickets,
       SUM(CASE WHEN sla_met = 'No' THEN 1 ELSE 0 END) AS missed_deadline,
       ROUND(100 * SUM(CASE WHEN sla_met = 'No' THEN 1 ELSE 0 END) / COUNT(*), 1) AS missed_pct
FROM tickets
WHERE sla_met IS NOT NULL
GROUP BY category
ORDER BY missed_pct DESC;

-- Q5. Does resolution time affect customer satisfaction?
SELECT CASE WHEN resolution_hours < 24 THEN '1. Under 24h'
            WHEN resolution_hours <= 48 THEN '2. 24 to 48h'
            ELSE '3. Over 48h' END AS time_bucket,
       COUNT(*) AS tickets,
       ROUND(AVG(satisfaction_score), 2) AS avg_rating
FROM tickets
WHERE resolution_hours IS NOT NULL AND satisfaction_score IS NOT NULL
GROUP BY time_bucket
ORDER BY time_bucket;

-- Q6. How do agents compare on speed and customer rating?
SELECT agent_id,
       COUNT(*) AS tickets,
       ROUND(AVG(resolution_hours), 1) AS avg_hours,
       ROUND(AVG(satisfaction_score), 2) AS avg_rating
FROM tickets
WHERE resolution_hours IS NOT NULL
GROUP BY agent_id
ORDER BY avg_hours;

-- =====================================================
-- Q7 (JOIN). Supporting table: agents (maps each agent to a team)
-- =====================================================
CREATE TABLE agents (
  agent_id VARCHAR(5) PRIMARY KEY,
  team VARCHAR(20)
);
INSERT INTO agents VALUES
('A01','Team Alpha'),('A02','Team Alpha'),('A03','Team Alpha'),('A04','Team Alpha'),('A05','Team Alpha'),
('A06','Team Beta'),('A07','Team Beta'),('A08','Team Beta'),('A09','Team Beta'),('A10','Team Beta'),
('A11','Team Gamma'),('A12','Team Gamma'),('A13','Team Gamma'),('A14','Team Gamma'),('A15','Team Gamma');

-- Q7. How do the teams compare on speed and customer rating? (uses JOIN)
SELECT a.team,
       COUNT(*) AS tickets,
       ROUND(AVG(t.resolution_hours), 1) AS avg_hours,
       ROUND(AVG(t.satisfaction_score), 2) AS avg_rating
FROM tickets t
JOIN agents a ON t.agent_id = a.agent_id
WHERE t.resolution_hours IS NOT NULL
GROUP BY a.team
ORDER BY avg_hours;
