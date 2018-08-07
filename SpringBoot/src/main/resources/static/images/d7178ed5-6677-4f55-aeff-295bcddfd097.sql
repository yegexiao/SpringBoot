-----------------------------------------------------------------------------------------------------------------------------------------------
prompt ģ����:����������������� ����:���� ��;����: ������ MM_RETURN_SCRAP ���ڣ�2018-07-25
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
'�����������������';

comment on column MM_RETURN_SCRAP.RETURN_SCRAP_ID is
'�������������id';

comment on column MM_RETURN_SCRAP.SCRAP_RECEIPT_ID is
'����������ⵥid';

comment on column MM_RETURN_SCRAP.DEPT_ID is
'����ID';

comment on column MM_RETURN_SCRAP.DEPT_CODE is
'���ű���';

comment on column MM_RETURN_SCRAP.DEPT_NAME is
'��������';

comment on column MM_RETURN_SCRAP.STATUS is
'״̬';

comment on column MM_RETURN_SCRAP.WAREHOUSE_ID is
'�ֿ�ID';

comment on column MM_RETURN_SCRAP.WAREHOUSE_NAME is
'�ֿ�����';

comment on column MM_RETURN_SCRAP.REASON is
'���ԭ��';

comment on column MM_RETURN_SCRAP.SCRAP_DATE is
'���ʱ��';

comment on column MM_RETURN_SCRAP.BACK_FLAG is
'���˱��';

comment on column MM_RETURN_SCRAP.DATA_AREA is
'��������';

comment on column MM_RETURN_SCRAP.CREATOR_ID is
'�Ƶ���ID';

comment on column MM_RETURN_SCRAP.CREATOR is
'�Ƶ���';

comment on column MM_RETURN_SCRAP.CREATE_DATE is
'�Ƶ�����';

comment on column MM_RETURN_SCRAP.MODIFY_DATE is
'����޸�ʱ��';

comment on column MM_RETURN_SCRAP.VALIDATE_FLAG is
'�ϱ�����ʶ';

comment on column MM_RETURN_SCRAP.PROCESS_INSTANCE_ID is
'������ʵ����Ψһ��ʶ';

comment on column MM_RETURN_SCRAP.REMARK is
'��ע';


-----------------------------------------------------------------------------------------------------------------------------------------------
prompt ģ����:���������������ϸ ����:���� ��;����: ������ MM_RETURN_SCRAP_ITEM ���ڣ�2018-07-25
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
'���������������ϸ';

comment on column MM_RETURN_SCRAP_ITEM.RETURN_SCRAP_ITEM_ID is
'�����������ϸID';

comment on column MM_RETURN_SCRAP_ITEM.RETURN_SCRAP_ID is
'���������ID';

comment on column MM_RETURN_SCRAP_ITEM.SCRAP_RECEIPT_ITEM_ID is
'���������ϸID';

comment on column MM_RETURN_SCRAP_ITEM.SCRAP_RECEIPT_ID is
'������ⵥID';

comment on column MM_RETURN_SCRAP_ITEM.IDENTIFY_ID is
'��������';

comment on column MM_RETURN_SCRAP_ITEM.IDENTIFY_ITEM_ID is
'������ϸID';

comment on column MM_RETURN_SCRAP_ITEM.CARD_NO is
'��Ƭ���';

comment on column MM_RETURN_SCRAP_ITEM.MATERIAL_CLASS is
'���ʷ���';

comment on column MM_RETURN_SCRAP_ITEM.MATERIAL_ID is
'���ʱ���';

comment on column MM_RETURN_SCRAP_ITEM.MATERIAL_NAME is
'��������';

comment on column MM_RETURN_SCRAP_ITEM.SPEC is
'����ͺ�';

comment on column MM_RETURN_SCRAP_ITEM.UNIT_ID is
'������λID';

comment on column MM_RETURN_SCRAP_ITEM.UNIT_NAME is
'������λ';

comment on column MM_RETURN_SCRAP_ITEM.WAREHOUSE_ID is
'��λID';

comment on column MM_RETURN_SCRAP_ITEM.WAREHOUSE_NAME is
'��λ����';

comment on column MM_RETURN_SCRAP_ITEM.WAREHOUSE_FULL_NAME is
'��λȫ��';

comment on column MM_RETURN_SCRAP_ITEM.DATA_AREA is
'��������';

comment on column MM_RETURN_SCRAP_ITEM.TAX is
'��λ˰��';

comment on column MM_RETURN_SCRAP_ITEM.UNIT_PRICE is
'����';

comment on column MM_RETURN_SCRAP_ITEM.TOTAL_TAX is
'˰��';

comment on column MM_RETURN_SCRAP_ITEM.TOTAL_PRICE is
'���';

comment on column MM_RETURN_SCRAP_ITEM.QTY is
'�������';

comment on column MM_RETURN_SCRAP_ITEM.CREATE_DATE is
'����ʱ��';

comment on column MM_RETURN_SCRAP_ITEM.MODIFY_DATE is
'�����޸�ʱ��';
