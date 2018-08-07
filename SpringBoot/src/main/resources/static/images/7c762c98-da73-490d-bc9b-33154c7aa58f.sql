
-----------------------------------------------------------------------------------------------------------------------------------------------
prompt ģ����:�������������-������ɹ��� ����:���� ��;����: �����洢���� P_MM_FINISH_RETURN_SCRAP ���ڣ�2018-07-25
-----------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE P_MM_FINISH_RETURN_SCRAP(V_RETURN_SCRAP_ID IN VARCHAR2,
                                                     V_DATA_AREA      IN VARCHAR2,
                                                     FLAG             OUT NUMBER) IS
  -- ��;˵�������ʲ�ϵͳV2.2��Ŀ--���ʣ�������ɱ�����������쵥
  -- ά���飺���ʲִ����Ϳ�����
  -- �������ڣ�2018-07-19
  -- ��ϸ˵����
  -- V_RETURN_SCRAP_ID ������������쵥��
  -- V_DATA_AREA ��������
  -- FLAG ����1��ʾ�����ɹ���0��ʾʧ��

  V_MAKR_MATERIAL  VARCHAR2(200); -- �������ʿ���
  V_FMIS_INTERFACE VARCHAR2(200); -- ����ϵͳ��FMISϵͳ�ӿڿ���

BEGIN

  BEGIN
                   
    -- ���¼�����ϸ�����������
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
            
     --���±�����������쵥��״̬Ϊ�������
     update MM_RETURN_SCRAP MM
        set MM.STATUS = 'audited', MM.MODIFY_DATE = SYSDATE
      WHERE MM.RETURN_SCRAP_ID = V_RETURN_SCRAP_ID;
/*
SELECT RII.IDENTIFY_ITEM_ID, SUM(RII.QTY) AS QTY
             FROM MM_RETURN_IDLE_ITEM RII
            WHERE RII.DATA_AREA = V_DATA_AREA
              AND RII.RETURN_IDLE_ID = V_RETURN_IDLE_ID
            GROUP BY RII.IDENTIFY_ITEM_ID)*/
    -- ��ȡ�������ʿ���
    -- �����������ʴ��첻�����죬��ʱ�����д���
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
      -- �޸ļ����м���ͬ����ʶ��Ϊ"N"
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
    -- ����ϵͳ��FMISϵͳ�ӿڿ���
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
      -- ���������ͬ���м������
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
      -- �����쳣��ع�����¼��־
      ROLLBACK;
      P_MM_INSERT_SYNERRORLOG('P_MM_FINISH_RETURN_SCRAP',
                              SUBSTR('������ɱ�����������쵥ʱ����' ||
                                     DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                                     1,
                                     500));

      RETURN;
  END;
  COMMIT;
  FLAG := 1;
END P_MM_FINISH_RETURN_SCRAP;
/