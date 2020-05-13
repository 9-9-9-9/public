--** INIT
CREATE 
(e1:Emp8 {name: 'HN-01', from: 2010}),
(e2:Emp8 {name: 'HN-02', from: 2010}),
(e3:Emp8 {name: 'HN-03', from: 2010}),
(e4:Emp8 {name: 'HN-04', from: 2001})
CREATE 
(e1)-[:IS_MANAGER_OF {from: 2010}]->(e2),
(e2)-[:IS_MANAGER_OF {from: 2010}]->(e3),
(e2)-[:IS_MANAGER_OF {from: 2001}]->(e4)
CREATE
(e1)-[:HAS_COMMISSION {from: 2010}]->(c:Commission8 {name: 'C', from: 2010}),
(e1)-[:HAS_MANAGEMENT_FEE {from: 2010}]->(m:ManagementFee8 {name: 'M', from: 2010}),
(e1)-[:HAS_KPI {from: 2010}]->(k1:Kpi8 {name: '1', from: 2010}),
(e1)-[:HAS_KPI {from: 2001}]->(k2:Kpi8 {name: '2', from: 2001})
CREATE
(k1)-[:HAS_SUB {from: 2010}]->(k11:Kpi8 {name: '1.1', from: 2010}),
(k1)-[:HAS_SUB {from: 2010}]->(k12:Kpi8 {name: '1.2', from: 2010}),
(k1)-[:HAS_SUB {from: 2001}]->(k13:Kpi8 {name: '1.3', from: 2001})

--** FIRST VIEW

MATCH (na:Emp8)
WHERE na.from <= 2010 AND (na.to IS NULL OR na.to >= 2010)
MATCH 
(n:Emp8)-[r:IS_MANAGER_OF]-(:Emp8), 
(:Emp8)-[hc:HAS_COMMISSION]->(c:Commission8), 
(:Emp8)-[hmf:HAS_MANAGEMENT_FEE]->(mf:ManagementFee8), 
(:Emp8)-[hk:HAS_KPI]->(k:Kpi8), 
(:Kpi8)-[hs:HAS_SUB]->(sk:Kpi8)
WHERE 
n.from <= 2010 AND (n.to IS NULL OR n.to >= 2010)
AND r.from <= 2010 AND (r.to IS NULL OR r.to >= 2010)
AND hc.from <= 2010 AND (hc.to IS NULL OR hc.to >= 2010)
AND c.from <= 2010 AND (c.to IS NULL OR c.to >= 2010)
AND hmf.from <= 2010 AND (hmf.to IS NULL OR hmf.to >= 2010)
AND mf.from <= 2010 AND (mf.to IS NULL OR mf.to >= 2010)
AND k.from <= 2010 AND (k.to IS NULL OR k.to >= 2010)
AND hk.from <= 2010 AND (hk.to IS NULL OR hk.to >= 2010)
AND hs.from <= 2010 AND (hs.to IS NULL OR hs.to >= 2010)
AND sk.from <= 2010 AND (sk.to IS NULL OR sk.to >= 2010)
return na, n, r, hc, c, hmf, mf, k, hk, hs, sk

--* RESIGN

-- (Tree of targets)
MATCH (e:Emp8 {name: 'HN-01'})
OPTIONAL MATCH (e)-[imo:IS_MANAGER_OF]-(e2:Emp8)
WHERE imo.to IS NULL
OPTIONAL MATCH (e)-[hc:HAS_COMMISSION]->(c)
WHERE hc.to IS NULL
OPTIONAL MATCH (e)-[hk:HAS_KPI]->(k:Kpi8)
WHERE hk.to IS NULL
OPTIONAL MATCH (e)-[hmf:HAS_MANAGEMENT_FEE]->(mf)
WHERE hmf.to IS NULL
OPTIONAL MATCH (k)-[hs:HAS_SUB]->(k2s:Kpi8)
WHERE hs.to IS NULL AND k2s.to IS NULL
RETURN e, e2, imo, hc, c, hk, k, hmf, mf, hs, k2s

-- (Expire)
MATCH (e:Emp8 {name: 'HN-01'})
OPTIONAL MATCH (e)-[imo:IS_MANAGER_OF]-(e2:Emp8)
WHERE imo.to IS NULL
OPTIONAL MATCH (e)-[hc:HAS_COMMISSION]->(c)
WHERE hc.to IS NULL
OPTIONAL MATCH (e)-[hk:HAS_KPI]->(k:Kpi8)
WHERE hk.to IS NULL
OPTIONAL MATCH (e)-[hmf:HAS_MANAGEMENT_FEE]->(mf)
WHERE hmf.to IS NULL
OPTIONAL MATCH (k)-[hs:HAS_SUB]->(k2s:Kpi8)
WHERE hs.to IS NULL AND k2s.to IS NULL
SET e.to = 2020
,  e2.to = 2020
,  imo.to = 2020
,  hc.to = 2020
,  c.to = 2020
,  hk.to = 2020
,  k.to = 2020
,  hmf.to = 2020
,  mf.to = 2020
,  hs.to = 2020
,  k2s.to = 2020


