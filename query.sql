USE lebara_mobile_prod;
GO

--***CREATE INDEXES***--
create index IX_addresses_createdTS on addresses(createdTS)
create index IX_adyenpaymenttransentries_p_time on adyenpaymenttransentries(p_time)
create index IX_paymentinfos_createdTS on paymentinfos(createdTS)
create index IX_paymenttransactions_createdTS on paymenttransactions(createdTS)
create index IX_orderentries_createdTS on orderentries(createdTS)
create index IX_orders_createdTS on orders(createdTS)
create index IX_paymnttrnsctentries_createdTS on paymnttrnsctentries(createdTS)
create index IX_carts_createdTS on carts(createdTS)
create index IX_users_p_uid on users(p_uid)
create index IX_users_createdTS on users(createdTS);
GO

--execution time

--***SELECT COUNT***---
SELECT COUNT(*) m FROM medias AS m JOIN mediafolders AS mf ON m.p_folder = mf.PK WHERE (mf.p_qualifier = 'cronJob')
SELECT COUNT(*) FROM cronjobs WHERE (p_code LIKE 'OrderStatusChange-%' AND p_endtime >= GETDATE()-30 and p_endtime <  GETDATE())
SELECT COUNT(*) cj FROM cronjobs AS cj JOIN jobs AS j ON j.PK = cj.p_job WHERE (j.p_code LIKE 'sync%')
SELECT COUNT(*) cj FROM cronjobs AS cj JOIN jobs AS j ON j.PK = cj.p_job WHERE (j.p_code LIKE 'solrIndexerJob%')
SELECT COUNT(*) cj FROM cronjobs AS cj JOIN jobs AS j ON j.PK = cj.p_job WHERE (j.p_code LIKE 'ImpEx-Export')
SELECT COUNT(*) cj FROM cronjobs AS cj JOIN jobs AS j ON j.PK = cj.p_job WHERE (j.p_code LIKE 'ImpEx-Import')
SELECT COUNT(*) cj FROM cronjobs AS cj JOIN jobs AS j ON j.PK = cj.p_job WHERE (j.p_code LIKE 'CompareCatalogVersionsJob')
SELECT COUNT(*) FROM cronjobhistories WHERE p_jobcode IN ('solrIndexerJob', 'ImpEx-Export', 'ImpEx-Import', 'executeFlexibleSearchJob') OR p_jobcode LIKE 'solrIndexerJob%'
SELECT COUNT(*) FROM cronjobhistories WHERE p_jobcode LIKE 'orderStatusChangeJob' AND createdTS >= GETDATE()-30 and createdTS <  GETDATE()
SELECT COUNT(*) FROM adyenpaymenttransentries WHERE adyenpaymenttransentries.p_time >= GETDATE()-30 and adyenpaymenttransentries.p_time <  GETDATE()
SELECT COUNT(*) FROM addresses WHERE addresses.createdTS >= GETDATE()-30 and addresses.createdTS <  GETDATE()
SELECT COUNT(*) FROM paymentinfos WHERE paymentinfos.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
SELECT COUNT(*) FROM paymenttransactions WHERE paymenttransactions.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
SELECT COUNT(*) FROM orderentries WHERE orderentries.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
SELECT COUNT(*) FROM orderpersonaldetails WHERE orderpersonaldetails.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
SELECT COUNT(*) FROM numberportability WHERE createdTS >= GETDATE()-30 and createdTS <  GETDATE()
SELECT COUNT(*) FROM orders WHERE orders.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
SELECT COUNT(*) FROM paymnttrnsctentries WHERE paymnttrnsctentries.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
SELECT COUNT(*) FROM cartentries WHERE cartentries.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
SELECT COUNT(*) FROM carts WHERE carts.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
SELECT COUNT(*) FROM tasklogs WHERE tasklogs.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
SELECT COUNT(*) FROM processes WHERE processes.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
SELECT COUNT(*) FROM processparameters WHERE processparameters.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
SELECT COUNT(*) FROM activationtransaction WHERE activationtransaction.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
SELECT COUNT(*) FROM users WHERE (users.p_uid LIKE '%@%' OR users.p_uid LIKE '%|%') and createdTS >= GETDATE()-30 and createdTS <  GETDATE();
GO

---***DELETE DATA FROM TABLES***---
WHILE (SELECT COUNT(*) m FROM medias AS m JOIN mediafolders AS mf ON m.p_folder = mf.PK WHERE (mf.p_qualifier = 'cronJob')) > 0
BEGIN
   DELETE m FROM medias AS m JOIN mediafolders AS mf ON m.p_folder = mf.PK WHERE (mf.p_qualifier = 'cronJob')
END
WHILE (SELECT COUNT(*) FROM cronjobs WHERE (p_code LIKE 'OrderStatusChange-%' AND p_endtime >= GETDATE()-30 and p_endtime <  GETDATE())) > 0
BEGIN
   DELETE FROM cronjobs WHERE (p_code LIKE 'OrderStatusChange-%' AND p_endtime >= GETDATE()-30 and p_endtime <  GETDATE())
END
WHILE (SELECT COUNT(*) cj FROM cronjobs AS cj JOIN jobs AS j ON j.PK = cj.p_job WHERE (j.p_code LIKE 'sync%')) > 0
BEGIN
   DELETE cj FROM cronjobs AS cj JOIN jobs AS j ON j.PK = cj.p_job WHERE (j.p_code LIKE 'sync%')
END
WHILE (SELECT COUNT(*) cj FROM cronjobs AS cj JOIN jobs AS j ON j.PK = cj.p_job WHERE (j.p_code LIKE 'solrIndexerJob%')) > 0
BEGIN
   DELETE cj FROM cronjobs AS cj JOIN jobs AS j ON j.PK = cj.p_job WHERE (j.p_code LIKE 'solrIndexerJob%')
END
WHILE (SELECT COUNT(*) cj FROM cronjobs AS cj JOIN jobs AS j ON j.PK = cj.p_job WHERE (j.p_code LIKE 'ImpEx-Export')) > 0
BEGIN
   DELETE cj FROM cronjobs AS cj JOIN jobs AS j ON j.PK = cj.p_job WHERE (j.p_code LIKE 'ImpEx-Export')
END
WHILE (SELECT COUNT(*) cj FROM cronjobs AS cj JOIN jobs AS j ON j.PK = cj.p_job WHERE (j.p_code LIKE 'ImpEx-Import')) > 0
BEGIN
   DELETE cj FROM cronjobs AS cj JOIN jobs AS j ON j.PK = cj.p_job WHERE (j.p_code LIKE 'ImpEx-Import')
END
WHILE (SELECT COUNT(*) cj FROM cronjobs AS cj JOIN jobs AS j ON j.PK = cj.p_job WHERE (j.p_code LIKE 'CompareCatalogVersionsJob')) > 0
BEGIN
   DELETE cj FROM cronjobs AS cj JOIN jobs AS j ON j.PK = cj.p_job WHERE (j.p_code LIKE 'CompareCatalogVersionsJob')
END
WHILE (SELECT COUNT(*) FROM cronjobhistories WHERE p_jobcode IN ('solrIndexerJob', 'ImpEx-Export', 'ImpEx-Import', 'executeFlexibleSearchJob') OR p_jobcode LIKE 'solrIndexerJob%') > 0
BEGIN
   DELETE FROM cronjobhistories WHERE p_jobcode IN ('solrIndexerJob', 'ImpEx-Export', 'ImpEx-Import', 'executeFlexibleSearchJob') OR p_jobcode LIKE 'solrIndexerJob%'
END
WHILE (SELECT COUNT(*) FROM cronjobhistories WHERE p_jobcode LIKE 'orderStatusChangeJob' AND createdTS >= GETDATE()-30 and createdTS <  GETDATE()) > 0
BEGIN
   DELETE FROM cronjobhistories WHERE p_jobcode LIKE 'orderStatusChangeJob' AND createdTS >= GETDATE()-30 and createdTS <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM adyenpaymenttransentries WHERE adyenpaymenttransentries.p_time >= GETDATE()-30 and adyenpaymenttransentries.p_time <  GETDATE()) > 0
BEGIN
   DELETE TOP (100000) FROM adyenpaymenttransentries WHERE adyenpaymenttransentries.p_time >= GETDATE()-30 and adyenpaymenttransentries.p_time <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM addresses WHERE addresses.createdTS >= GETDATE()-30 and addresses.createdTS <  GETDATE()) > 0
BEGIN
   DELETE TOP (100000) FROM addresses WHERE addresses.createdTS >= GETDATE()-30 and addresses.createdTS <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM paymentinfos WHERE paymentinfos.createdTS >= GETDATE()-30 and createdTS <  GETDATE()) > 0
BEGIN
   DELETE TOP (100000) FROM paymentinfos WHERE paymentinfos.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM paymenttransactions WHERE paymenttransactions.createdTS >= GETDATE()-30 and createdTS <  GETDATE()) > 0
BEGIN
   DELETE TOP (100000) FROM paymenttransactions WHERE paymenttransactions.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM orderentries WHERE orderentries.createdTS >= GETDATE()-30 and createdTS <  GETDATE()) > 0
BEGIN
   DELETE TOP (100000) FROM orderentries WHERE orderentries.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM orderpersonaldetails WHERE orderpersonaldetails.createdTS >= GETDATE()-30 and createdTS <  GETDATE()) > 0
BEGIN
   DELETE TOP (100000) FROM orderpersonaldetails WHERE orderpersonaldetails.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM numberportability WHERE createdTS >= GETDATE()-30 and createdTS <  GETDATE() ) > 0
BEGIN
   DELETE TOP (100000) FROM numberportability WHERE createdTS >= GETDATE()-30 and createdTS <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM orders WHERE orders.createdTS >= GETDATE()-30 and createdTS <  GETDATE()) > 0
BEGIN
   DELETE TOP (100000) FROM orders WHERE orders.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM paymnttrnsctentries WHERE paymnttrnsctentries.createdTS >= GETDATE()-30 and createdTS <  GETDATE()) > 0
BEGIN
   DELETE TOP (100000) FROM paymnttrnsctentries WHERE paymnttrnsctentries.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM cartentries WHERE cartentries.createdTS >= GETDATE()-30 and createdTS <  GETDATE()) > 0
BEGIN
   DELETE TOP (100000) FROM cartentries WHERE cartentries.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM carts WHERE carts.createdTS >= GETDATE()-30 and createdTS <  GETDATE()) > 0
BEGIN
   DELETE TOP (100000) FROM carts WHERE carts.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM tasklogs WHERE tasklogs.createdTS >= GETDATE()-30 and createdTS <  GETDATE()) > 0
BEGIN
   DELETE TOP (100000) FROM tasklogs WHERE tasklogs.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM processes WHERE processes.createdTS >= GETDATE()-30 and createdTS <  GETDATE()) > 0
BEGIN
   DELETE TOP (100000) FROM processes WHERE processes.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM processparameters WHERE processparameters.createdTS >= GETDATE()-30 and createdTS <  GETDATE()) > 0
BEGIN
   DELETE TOP (100000) FROM processparameters WHERE processparameters.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM activationtransaction WHERE activationtransaction.createdTS >= GETDATE()-30 and createdTS <  GETDATE()) > 0
BEGIN
   DELETE TOP (100000) FROM activationtransaction WHERE activationtransaction.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM simevent WHERE simevent.createdTS >= GETDATE()-30 and createdTS <  GETDATE()) > 0
BEGIN
   DELETE TOP (100000) FROM simevent WHERE simevent.createdTS >= GETDATE()-30 and createdTS <  GETDATE()
END
WHILE (SELECT COUNT(*) FROM users WHERE (users.p_uid LIKE '%@%' OR users.p_uid LIKE '%|%') and createdTS >= GETDATE()-30 and createdTS <  GETDATE()) > 0
BEGIN
   DELETE TOP (100000) FROM users WHERE (users.p_uid LIKE '%@%' OR users.p_uid LIKE '%|%') and createdTS >= GETDATE()-30 and createdTS <  GETDATE()
END;
GO

--***DROP INDEXES***--


IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_addresses_createdTS' AND object_id = OBJECT_ID('dbo.addresses'))
BEGIN
        drop index addresses.IX_addresses_createdTS
END
IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_adyenpaymenttransentries_p_time' AND object_id = OBJECT_ID('dbo.adyenpaymenttransentries'))
BEGIN
        drop index adyenpaymenttransentries.IX_adyenpaymenttransentries_p_time
END
IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_paymentinfos_createdTS' AND object_id = OBJECT_ID('dbo.paymentinfos'))
BEGIN
        drop index paymentinfos.IX_paymentinfos_createdTS
END
IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_paymenttransactions_createdTS' AND object_id = OBJECT_ID('dbo.paymenttransactions'))
BEGIN
        drop index paymenttransactions.IX_paymenttransactions_createdTS
END
IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_orderentries_createdTS' AND object_id = OBJECT_ID('dbo.orderentries'))
BEGIN
        drop index orderentries.IX_orderentries_createdTS
END
IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_orders_createdTS' AND object_id = OBJECT_ID('dbo.orders'))
BEGIN
        drop index orders.IX_orders_createdTS
END
IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_paymnttrnsctentries_createdTS' AND object_id = OBJECT_ID('dbo.paymnttrnsctentries'))
BEGIN
        drop index paymnttrnsctentries.IX_paymnttrnsctentries_createdTS
END
IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_carts_createdTS' AND object_id = OBJECT_ID('dbo.carts'))
BEGIN
        drop index carts.IX_carts_createdTS
END
IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_users_p_uid' AND object_id = OBJECT_ID('dbo.users'))
BEGIN
        drop index users.IX_users_p_uid
END
IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_users_createdTS' AND object_id = OBJECT_ID('dbo.users'))
BEGIN
        drop index users.IX_users_createdTS
END;
GO

exec sp_msforeachtable 'update statistics ? with sample 1 percent, norecompute';
GO
