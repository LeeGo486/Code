<%
Class F22System_Dm
'ȫ�ֱ���
'�û���Ϣ==========================================================
Public System_Conn                  'str ���ݿ������ַ���
Public System_UserId                'str �û����
Public System_UserName    			'str �û�����
public System_UserPass    			'str �û�����
public System_UserAdmin             'int �Ƿ�Ϊ����Ա 1-��������Ա
public System_Login       			'bit ��¼״̬
public System_LockDate    			'str ��������
public System_UserType    			'int �û����ͣ�0-�ܹ�˾��1-�ֹ�˾��2-�����̣�3-������
public System_UnitId      			'str ���������̱��
public System_UnitName    			'str ��������������
public System_DepotId               'str Ĭ���ջ���
public System_DepotName             'str Ĭ���ջ�������
public System_Get_Depotid           '�ܹ�˾�ջ��ֿ���
public System_Get_Depotname         '�ܹ�˾�ջ��ֿ�
public System_Set_Depotid           '�ܹ�˾�����ֿ���
public System_Set_DepotName         '�ܹ�˾�����ֿ�
public System_ParentId              'str �������ϼ�ID
public System_UserPower(13) 		'int ��Ȩ��:0-����Ա��1-������2-��ӡ��3-��ˣ�4-���ʣ�5-������6-ɾ����7-����ˣ�
                            		'           8-�����ʣ�9-���ۼۣ�10-����ۣ�11-�ɱ��ۣ�12-�󶨵��ԣ�13-��¼��־��
public System_EditUserList  		'str ��ǰ�û������޸Ĳ���Ա���ݵ��б�
'Ԥ������==========================================================
public Setup_EditBill    			'bit �Ƿ�����޸ı��˵ĵ���
public Setup_InputDouble 			'bit �Ƿ���������ظ���
public Setup_Nowstock_Bj 			'int Ŀǰ���С��0������ 0-����1-��ʾ��2-������
public Setup_Kpstock_Bj  			'int ������С��0������ 0-����1-��ʾ��2-������
public Setup_ShowPic     			'int ����ͼ�ⷽʽ�� 0-��ǰ���ݿ⣻1-F117PICTURE
public Setup_RoundType   			'int �������뷽ʽ�� 0-�������룻1-ֻ�벻�᣻2-ֻ�᲻�룻3-��Ч
public Setup_IndepotCz  			'int ��ⵥ�Ƿ������ˣ� 0-����1-������
public Setup_IndepotPrice 			'int ������ⵥ�����Ĭ�ϼ۷�ʽ�� 0-���ۼۣ�1-�ɱ���
public Setup_IndepotSked  			'int �����ռƻ�ʱ���ƣ� 0-����ʾ��1-ֻ��ʾ��2-������С�ڵ��ڼƻ�
public Setup_QuotaJmCz  			'int ����������Ƿ������ˣ�0-����1-������
public Setup_QuotaJmJe  			'int �������ʱ������ƣ�0-����ʾ��1-ֻ��ʾ��2-�������
public Setup_QuotaJmJecz  			'int ��������������շ�ʽ��0-Ŀǰ�������+�����1-Ŀǰ���+������
public Setup_QuotaJmSend  			'bit �������������ʱ֪ͨ�ֿⷢ��
public Setup_SellCz     			'int ���˷������Ƿ������ˣ�0-����1-������
public Setup_SellJe     			'int ���˷���ʱ������ƣ�0-����ʾ��1-ֻ��ʾ��2-�������
public Setup_SellJecz   			'int ���˷����������շ�ʽ��0-Ŀǰ�������+�����1-Ŀǰ���+������
public Setup_OutIndentTh  			'int �����˻���˿��ƣ�0-�����ƣ�1-���ƽ�2-����ʽ���ȿ��ƽ��
public Setup_OutIndentNstyle  		'int ��δ��������˻���ʽ��0-����1-������
public Setup_OutIndentBstyle  		'int �������Ŀ��˻���ʽ��0-����1-������
public Setup_OutIndentStyleF  		'int ��ʽ�˻��������Ʒ�ʽ��0-���1-����+ɫ��2-����+ɫ+��
public Setup_OutIndentStyleS  		'int ��ʽ�˻��ջ����Ʒ�ʽ��0-���1-����+ɫ��2-����+ɫ+��
public Setup_OutIndentPrice   		'int �˻������ۿ��ƣ�0-�����˻����ϵ��۲��䣻1-���˻������滻�˻����ϵĵ���
public Setup_SizeType         		'int �����̧ͷ�����ѯʱ���淽ʽ��0-�ɷ�ʽ��1-�·�ʽ
public Setup_SizeShowType     		'int �����̧ͷ��ʾ��ʽ��0-�����뵵���еĳ����飻1-����ʽ���ࣻ2-����ʽ���ࣻ
                                    '                        3-����ʽС�ࣻ4-����ʽ���֣�5-����ʽ��Ŀ
public Setup_QuotaZySend            'bit ��Ӫ���������ʱ֪ͨ�ֿⷢ��
public Setup_Cost                   'int �ɱ��ۼ��㷽ʽ��0-�ƶ���Ȩƽ����1-�̶���ʽ�ɱ�
public Setup_SaveTm                 'int ɨ������ʱ�Ƿ��¼������ˮ�ţ�0-����¼��1-��¼
public Setup_SaveVip                'bit ���۵�����ʱ�ж�VIP�Ƿ����
public Setup_CheckBoxJm             'bit ���˷������ʼ��װ����
public Setup_CheckBoxZy             'bit ��Ӫ�������ʼ��װ����
public Setup_ZeroZk                 'bit ���ۿ۱�ʾ�����Ϊ��Ļ�Ʒ
public Setup_GetCheck				'bit �����ջ����������������
public Setup_AheadDay               'int ��ǰ֪ͨ����������
public Setup_OverDay                'int ��������ʾ������
public Setup_Reflash                'int ˢ�������ʱ��/��

End Class
%>