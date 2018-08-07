-----------------------------------------------------------------------------------------------------------------------------------------------
prompt 模块名:报废物资入库冲红主单 姓名:余威 用途描述: 创建表 MM_RETURN_SCRAP 日期：2018-07-25
-----------------------------------------------------------------------------------------------------------------------------------------------
create table MM_RETURN_SCRAP 
(
   RETURN_SCRAP_ID      VARCHAR2(36)         not null,
   SCRAP_RECEIPT_ID     VARCHAR2(36),
   DEPT_ID              VARCHAR2(36),
   DEPT_CODE            VARCHAR2(50),
   DEPT_NAME            VARCHAR2(200),
   STATUS               VARCHAR2(20),
   WAREHOUSE_ID         VARCHAR2(36),
   WAREHOUSE_NAME       VARCHAR2(100),
   REASON               VARCHAR2(500),
   SCRAP_DATE           DATE,
   BACK_FLAG            CHAR(1),
   DATA_AREA            VARCHAR2(20),
   CREATOR_ID           VARCHAR2(36),
   CREATOR              VARCHAR2(30),
   CREATE_DATE          DATE,
   MODIFY_DATE          DATE,
   VALIDATE_FLAG        CHAR(1),
   PROCESS_INSTANCE_ID  VARCHAR2(40),
   REMARK               VARCHAR2(500),
   constraint PK_MM_RETURN_SCRAP primary key (RETURN_SCRAP_ID)
);

comment on table MM_RETURN_SCRAP is
'报废物资入库冲红主单';

comment on column MM_RETURN_SCRAP.RETURN_SCRAP_ID is
'报废物资入库冲红id';

comment on column MM_RETURN_SCRAP.SCRAP_RECEIPT_ID is
'报废物资入库单id';

comment on column MM_RETURN_SCRAP.DEPT_ID is
'部门ID';

comment on column MM_RETURN_SCRAP.DEPT_CODE is
'部门编码';

comment on column MM_RETURN_SCRAP.DEPT_NAME is
'部门名称';

comment on column MM_RETURN_SCRAP.STATUS is
'状态';

comment on column MM_RETURN_SCRAP.WAREHOUSE_ID is
'仓库ID';

comment on column MM_RETURN_SCRAP.WAREHOUSE_NAME is
'仓库名称';

comment on column MM_RETURN_SCRAP.REASON is
'冲红原因';

comment on column MM_RETURN_SCRAP.SCRAP_DATE is
'冲红时间';

comment on column MM_RETURN_SCRAP.BACK_FLAG is
'回退标记';

comment on column MM_RETURN_SCRAP.DATA_AREA is
'数据区域';

comment on column MM_RETURN_SCRAP.CREATOR_ID is
'制单人ID';

comment on column MM_RETURN_SCRAP.CREATOR is
'制单人';

comment on column MM_RETURN_SCRAP.CREATE_DATE is
'制单日期';

comment on column MM_RETURN_SCRAP.MODIFY_DATE is
'最后修改时间';

comment on column MM_RETURN_SCRAP.VALIDATE_FLAG is
'上报检查标识';

comment on column MM_RETURN_SCRAP.PROCESS_INSTANCE_ID is
'主流程实例的唯一标识';

comment on column MM_RETURN_SCRAP.REMARK is
'备注';


-----------------------------------------------------------------------------------------------------------------------------------------------
prompt 模块名:报废物资入库冲红明细 姓名:余威 用途描述: 创建表 MM_RETURN_SCRAP_ITEM 日期：2018-07-25
-----------------------------------------------------------------------------------------------------------------------------------------------
create table MM_RETURN_SCRAP_ITEM 
(
   RETURN_SCRAP_ITEM_ID VARCHAR2(36)         not null,
   RETURN_SCRAP_ID      VARCHAR2(36),
   SCRAP_RECEIPT_ITEM_ID VARCHAR2(36),
   SCRAP_RECEIPT_ID     VARCHAR2(36),
   IDENTIFY_ID          VARCHAR2(36),
   IDENTIFY_ITEM_ID     VARCHAR2(36),
   CARD_NO              VARCHAR2(50),
   MATERIAL_CLASS       VARCHAR2(200),
   MATERIAL_ID          VARCHAR2(36),
   MATERIAL_NAME        VARCHAR2(200),
   SPEC                 VARCHAR2(1000),
   UNIT_ID              NUMBER(10),
   UNIT_NAME            VARCHAR2(30),
   WAREHOUSE_ID         VARCHAR2(36),
   WAREHOUSE_NAME       VARCHAR2(100),
   WAREHOUSE_FULL_NAME  VARCHAR2(1000),
   DATA_AREA            VARCHAR2(20),
   TAX                  NUMBER(18,8),
   UNIT_PRICE           NUMBER(18,8),
   TOTAL_TAX            NUMBER(14,2),
   TOTAL_PRICE          NUMBER(14,2),
   QTY                  NUMBER(16,6)         default 0,
   CREATE_DATE          DATE,
   MODIFY_DATE          DATE,
   constraint PK_MM_RETURN_SCRAP_ITEM primary key (RETURN_SCRAP_ITEM_ID)
);

comment on table MM_RETURN_SCRAP_ITEM is
'报废物资入库冲红明细';

comment on column MM_RETURN_SCRAP_ITEM.RETURN_SCRAP_ITEM_ID is
'报废入库冲红明细ID';

comment on column MM_RETURN_SCRAP_ITEM.RETURN_SCRAP_ID is
'报废入库冲红ID';

comment on column MM_RETURN_SCRAP_ITEM.SCRAP_RECEIPT_ITEM_ID is
'报废入库明细ID';

comment on column MM_RETURN_SCRAP_ITEM.SCRAP_RECEIPT_ID is
'报废入库单ID';

comment on column MM_RETURN_SCRAP_ITEM.IDENTIFY_ID is
'鉴定表编号';

comment on column MM_RETURN_SCRAP_ITEM.IDENTIFY_ITEM_ID is
'鉴定明细ID';

comment on column MM_RETURN_SCRAP_ITEM.CARD_NO is
'卡片编号';

comment on column MM_RETURN_SCRAP_ITEM.MATERIAL_CLASS is
'物资分类';

comment on column MM_RETURN_SCRAP_ITEM.MATERIAL_ID is
'物资编码';

comment on column MM_RETURN_SCRAP_ITEM.MATERIAL_NAME is
'物资名称';

comment on column MM_RETURN_SCRAP_ITEM.SPEC is
'规格型号';

comment on column MM_RETURN_SCRAP_ITEM.UNIT_ID is
'计量单位ID';

comment on column MM_RETURN_SCRAP_ITEM.UNIT_NAME is
'计量单位';

comment on column MM_RETURN_SCRAP_ITEM.WAREHOUSE_ID is
'仓位ID';

comment on column MM_RETURN_SCRAP_ITEM.WAREHOUSE_NAME is
'仓位名称';

comment on column MM_RETURN_SCRAP_ITEM.WAREHOUSE_FULL_NAME is
'仓位全称';

comment on column MM_RETURN_SCRAP_ITEM.DATA_AREA is
'数据区域';

comment on column MM_RETURN_SCRAP_ITEM.TAX is
'单位税额';

comment on column MM_RETURN_SCRAP_ITEM.UNIT_PRICE is
'单价';

comment on column MM_RETURN_SCRAP_ITEM.TOTAL_TAX is
'税额';

comment on column MM_RETURN_SCRAP_ITEM.TOTAL_PRICE is
'金额';

comment on column MM_RETURN_SCRAP_ITEM.QTY is
'冲红数量';

comment on column MM_RETURN_SCRAP_ITEM.CREATE_DATE is
'创建时间';

comment on column MM_RETURN_SCRAP_ITEM.MODIFY_DATE is
'最新修改时间';
