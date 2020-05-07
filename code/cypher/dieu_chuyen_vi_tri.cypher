
--*** INIT

CREATE (n1:Emp3), (n2:Emp3), (n3:Emp3)
SET
n1.sid='HN-01', 
n1.name='Mr.1',
n1.from=1991,
n2.sid='HN-02', 
n2.name='Mr.2',
n2.from=1992,
n3.sid='HN-03', 
n3.name='Mr.3',
n3.from=1993
CREATE (n1)-[r12:IS_MANAGER_OF]->(n2), (n2)-[r23:IS_MANAGER_OF]->(n3)
SET r12.from=1992, r23.from=1993
RETURN n1, n2, n3

--*** LAY CAY NHAN SU O THOI DIEM HIEN TAI
MATCH (n:Emp3)
WHERE n.to IS NULL
OPTIONAL MATCH (:Emp3)-[r:IS_MANAGER_OF]-(:Emp3)
WHERE r.to IS NULL
RETURN n, r

--*** Chuyen n3 len truong phong, ngang hang n2
-- Pre-cond: expire vi tri vao thoi diem 2019, them vi tri vao thoi diem 2020

MATCH (n3:Emp3)<-[r23:IS_MANAGER_OF]-(n2), (n1:Emp3)
WHERE n3.name='Mr.3' AND n1.sid='HN-01'
SET n3.to=2019, n3.expired=true, r23.to=2019, r23.expired=true
CREATE (n4:Emp3)<-[r14:IS_MANAGER_OF]-(n1)
SET n4.sid='HN-04', n4.name=n3.name, n4.from=2020, r14.from=2020
RETURN n1,n2,n4

--*** Query cay nhan su vao thoi diem 2000

MATCH (n:Emp3)
WHERE n.from <= 2000
	AND (n.to IS NULL OR n.to >= 2000)
OPTIONAL MATCH (:Emp3)-[r:IS_MANAGER_OF]-(:Emp3)
WHERE r.from <= 2000
	AND (r.to IS NULL OR r.to >= 2000)
RETURN n, r
-- (output nodes: HN-01, HN-02, HN-03)

--*** Query cay nhan su vao thoi diem 2020

MATCH (n:Emp3)
WHERE n.from <= 2020
	AND (n.to IS NULL OR n.to >= 2020)
OPTIONAL MATCH (:Emp3)-[r:IS_MANAGER_OF]-(:Emp3)
WHERE r.from <= 2020
	AND (r.to IS NULL OR r.to >= 2020)
RETURN n, r
-- (output nodes: HN-01, HN-02, HN-04)

--*** Mr.3 (HN-04) tiep tuc quay tro lai lam cap duoi cua Mr.2 (HN-02)
-- Pre-cond: expire vi tri vao thoi diem 2029, them vi tri vao thoi diem 2030
MATCH (n4:Emp3)<-[r14:IS_MANAGER_OF]-(n1), (n2:Emp3)
WHERE n4.sid='HN-04' AND n2.sid='HN-02'
SET n4.to=2029, n4.expired=true, r14.to=2029, r14.expired=true
CREATE (n5:Emp3)<-[r25:IS_MANAGER_OF]-(n2)
SET n5.sid='HN-05', n5.name=n4.name, n5.from=2030, r25.from=2030
RETURN n1,n2,n5

--*** Them nhan su Mr.6 dc quan ly boi Mr.2
MATCH (n2:Emp3)
WHERE n2.sid='HN-02'
CREATE (n6:Emp3)<-[r26:IS_MANAGER_OF]-(n2)
SET n6.sid='HN-06', n6.name='Mr.6', n6.from=2040, r26.from=2040

--** Chuyen Mr.6 sang cho Mr.1 quan ly truc tiep (vi tri cong viec KHONG doi)
-- Pre-cond: expire relation IS_MANAGER_OF vao thoi diem 2049, relation moi thi from 2050
MATCH (n6:Emp3)<-[r26:IS_MANAGER_OF]-(n2:Emp3), (n1:Emp3)
WHERE n1.sid='HN-01' AND n2.sid='HN-02' AND n6.sid='HN-06' AND r26.to IS NULL
SET r26.to=2049, r26.expired=true
CREATE (n6)<-[r16:IS_MANAGER_OF]-(n1)
SET r16.from=2050
