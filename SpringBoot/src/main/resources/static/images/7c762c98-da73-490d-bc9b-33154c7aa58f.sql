
-----------------------------------------------------------------------------------------------------------------------------------------------
prompt 模块名:报废物资入库冲红-审批完成过账 姓名:余威 用途描述: 创建存储过程 P_MM_FINISH_RETURN_SCRAP 日期：2018-07-25
-----------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE P_MM_FINISH_RETURN_SCRAP(V_RETURN_SCRAP_ID IN VARCHAR2,
                                                     V_DATA_AREA      IN VARCHAR2,
                                                     FLAG             OUT NUMBER) IS
  -- 用途说明：（资产系统V2.2项目--物资）审批完成报废物资入库冲红单
  -- 维护组：物资仓储配送开发组
  -- 创建日期：2018-07-19
  -- 详细说明：
  -- V_RETURN_SCRAP_ID 报废物资入库冲红单号
  -- V_DATA_AREA 数据区域
  -- FLAG 返回1表示审批成功，0表示失败

  V_MAKR_MATERIAL  VARCHAR2(200); -- 计量物资开关
  V_FMIS_INTERFACE VARCHAR2(200); -- 物资系统与FMIS系统接口开关

BEGIN

  BEGIN
                   
    -- 更新鉴定明细的已入库数量
    MERGE INTO MM_WASTER_IDENTIFY_ITEM T1
         USING (SELECT RII.IDENTIFY_ITEM_ID, SUM(RII.QTY) AS QTY
                  FROM MM_RETURN_SCRAP_ITEM RII
                 WHERE RII.DATA_AREA = V_DATA_AREA
                   AND RII.RETURN_SCRAP_ID = V_RETURN_SCRAP_ID
                   GROUP BY RII.IDENTIFY_ITEM_ID) T2
         ON (T1.IDENTIFY_ITEM_ID = T2.IDENTIFY_ITEM_ID)
         WHEN MATCHED THEN
           UPDATE
              SET T1.RECEIPT_QTY = T1.RECEIPT_QTY - T2.QTY , T1.MODIFY_DATE = SYSDATE
            WHERE T1.DATA_AREA = V_DATA_AREA;
            
     --更新报废物资入库冲红单的状态为审批完成
     update MM_RETURN_SCRAP MM
        set MM.STATUS = 'audited', MM.MODIFY_DATE = SYSDATE
      WHERE MM.RETURN_SCRAP_ID = V_RETURN_SCRAP_ID;
/*
SELECT RII.IDENTIFY_ITEM_ID, SUM(RII.QTY) AS QTY
             FROM MM_RETURN_IDLE_ITEM RII
            WHERE RII.DATA_AREA = V_DATA_AREA
              AND RII.RETURN_IDLE_ID = V_RETURN_IDLE_ID
            GROUP BY RII.IDENTIFY_ITEM_ID)*/
    -- 获取计量物资开关
    -- 计量闲置物资待办不允许冲红，暂时不进行处理
    /*SELECT CASE
             WHEN LOWER(PC.VALUE) = 'yes' THEN
              'yes'
             WHEN LOWER(PC.VALUE) = 'no' THEN
              'no'
             WHEN INSTR(LOWER(PC.VALUE), V_DATA_AREA) > 0 THEN
              'yes'
             ELSE
              'no'
           END
      INTO V_MAKR_MATERIAL
      FROM PUB_CONFIG PC
     WHERE PC.KEY = 'ct.lcam.interfacesswitch.markMaterial';

    IF V_MAKR_MATERIAL = 'yes' THEN
      -- 修改鉴定中间表的同步标识符为"N"
      MERGE INTO MMYX_WASTE_IDENTITY T1
      USING (SELECT MSR.MMYX_WASTER_IDENTIFY_ID
               FROM MM_MARK_SCRAP_RECEIPT MSR
              WHERE MSR.DATA_AREA = V_DATA_AREA
                AND EXISTS
              (SELECT 1
                       FROM MM_RETURN_SCRAP RI
                      WHERE RI.DATA_AREA = V_DATA_AREA
                        AND RI.RETURN_SCRAP_ID = V_RETURN_SCRAP_ID
                        AND MSR.SCRAP_RECEIPT_ID = RI.SCRAP_RECEIPT_ID)) T2
      ON (T1.MMYX_WASTER_IDENTIFY_ID = T2.MMYX_WASTER_IDENTIFY_ID)
      WHEN MATCHED THEN
        UPDATE SET T1.SYNCHRON_FLAG = 'N' WHERE T1.DATA_AREA = V_DATA_AREA;
    END IF;
*/
    -- 物资系统与FMIS系统接口开关
    SELECT CASE
             WHEN LOWER(PC.VALUE) = 'yes' THEN
              'yes'
             WHEN LOWER(PC.VALUE) = 'no' THEN
              'no'
             WHEN INSTR(LOWER(PC.VALUE), V_DATA_AREA) > 0 THEN
              'yes'
             ELSE
              'no'
           END
      INTO V_FMIS_INTERFACE
      FROM PUB_CONFIG PC
     WHERE PC.KEY = 'ct.mm.materialtofmis.interfaceswitch';

    IF V_FMIS_INTERFACE = 'yes' THEN
      -- 创建与财务同步中间表数据
      INSERT INTO MM_FMIS_BILL
        (BILL_ID,
         OBJECT_ID,
         OBJECT_TYPE,
         INTERFACE_TYPE,
         SYN_FLAG,
         SYN_COUNT,
         CREATE_DATE,
         MODIFY_DATE)
      VALUES
        (SQ_MM_FMIS_BILL_PK.NEXTVAL,
         V_RETURN_SCRAP_ID,
         'returnScrap',
         'returnScrap',
         0,
         0,
         SYSDATE,
         SYSDATE);
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
      FLAG := 0;
      -- 捕获异常后回滚并记录日志
      ROLLBACK;
      P_MM_INSERT_SYNERRORLOG('P_MM_FINISH_RETURN_SCRAP',
                              SUBSTR('审批完成报废物资入库冲红单时出错：' ||
                                     DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                                     1,
                                     500));

      RETURN;
  END;
  COMMIT;
  FLAG := 1;
END P_MM_FINISH_RETURN_SCRAP;
/