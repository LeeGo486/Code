<%
Class F22System_Dm
'全局变量
'用户信息==========================================================
Public System_Conn                  'str 数据库连接字符串
Public System_UserId                'str 用户编号
Public System_UserName    			'str 用户名称
public System_UserPass    			'str 用户密码
public System_UserAdmin             'int 是否为管理员 1-超级管理员
public System_Login       			'bit 登录状态
public System_LockDate    			'str 锁帐日期
public System_UserType    			'int 用户类型：0-总公司；1-分公司；2-代理商；3-加盟商
public System_UnitId      			'str 所属代理商编号
public System_UnitName    			'str 所属代理商名称
public System_DepotId               'str 默认收货仓
public System_DepotName             'str 默认收货仓名称
public System_Get_Depotid           '总公司收货仓库编号
public System_Get_Depotname         '总公司收货仓库
public System_Set_Depotid           '总公司发货仓库编号
public System_Set_DepotName         '总公司发货仓库
public System_ParentId              'str 代理商上级ID
public System_UserPower(13) 		'int 总权限:0-管理员；1-导出；2-打印；3-审核；4-登帐；5-新增；6-删除；7-反审核；
                            		'           8-反登帐；9-零售价；10-结算价；11-成本价；12-绑定电脑；13-记录日志；
public System_EditUserList  		'str 当前用户可以修改操作员单据的列表
'预警设置==========================================================
public Setup_EditBill    			'bit 是否可以修改别人的单据
public Setup_InputDouble 			'bit 是否可以输入重复款
public Setup_Nowstock_Bj 			'int 目前库存小于0报警： 0-允许；1-提示；2-不允许
public Setup_Kpstock_Bj  			'int 可配库存小于0报警： 0-允许；1-提示；2-不允许
public Setup_ShowPic     			'int 调用图库方式： 0-当前数据库；1-F117PICTURE
public Setup_RoundType   			'int 四舍五入方式： 0-四舍五入；1-只入不舍；2-只舍不入；3-无效
public Setup_IndepotCz  			'int 入库单是否参照审核： 0-允许；1-不允许
public Setup_IndepotPrice 			'int 生产入库单结算价默认价方式： 0-零售价；1-成本价
public Setup_IndepotSked  			'int 入库参照计划时控制： 0-不提示；1-只提示；2-入库必须小于等于计划
public Setup_QuotaJmCz  			'int 加盟配货单是否参照审核：0-允许；1-不允许
public Setup_QuotaJmJe  			'int 加盟配货时金额不足控制：0-不提示；1-只提示；2-必须大于
public Setup_QuotaJmJecz  			'int 加盟配货单金额参照方式：0-目前可用余额+信誉额；1-目前余额+信誉额
public Setup_QuotaJmSend  			'bit 加盟配货单登帐时通知仓库发货
public Setup_SellCz     			'int 加盟发货单是否参照审核：0-允许；1-不允许
public Setup_SellJe     			'int 加盟发货时金额不足控制：0-不提示；1-只提示；2-必须大于
public Setup_SellJecz   			'int 加盟发货单金额参照方式：0-目前可用余额+信誉额；1-目前余额+信誉额
public Setup_OutIndentTh  			'int 加盟退货审核控制：0-不控制；1-控制金额；2-按款式季度控制金额
public Setup_OutIndentNstyle  		'int 从未发过款的退货方式：0-允许；1-不允许
public Setup_OutIndentBstyle  		'int 补过货的款退货方式：0-允许；1-不允许
public Setup_OutIndentStyleF  		'int 款式退货发货控制方式：0-按款；1-按款+色；2-按款+色+码
public Setup_OutIndentStyleS  		'int 款式退货收货控制方式：0-按款；1-按款+色；2-按款+色+码
public Setup_OutIndentPrice   		'int 退货单单价控制：0-保持退货单上单价不变；1-用退货申请替换退货单上的单价
public Setup_SizeType         		'int 尺码多抬头报表查询时交叉方式：0-旧方式；1-新方式
public Setup_SizeShowType     		'int 尺码多抬头显示方式：0-按尺码档案中的尺码组；1-按款式种类；2-按款式大类；
                                    '                        3-按款式小类；4-按款式布种；5-按款式科目
public Setup_QuotaZySend            'bit 自营配货单登帐时通知仓库发货
public Setup_Cost                   'int 成本价计算方式：0-移动加权平均；1-固定款式成本
public Setup_SaveTm                 'int 扫描条码时是否记录条码流水号：0-不记录；1-记录
public Setup_SaveVip                'bit 零售单保存时判断VIP是否存在
public Setup_CheckBoxJm             'bit 加盟发货登帐检查装箱数
public Setup_CheckBoxZy             'bit 自营发货登帐检查装箱数
public Setup_ZeroZk                 'bit 零折扣表示结算价为零的货品
public Setup_GetCheck				'bit 调拨收货单必须点货方可审核
public Setup_AheadDay               'int 提前通知跟进的天数
public Setup_OverDay                'int 超过不提示的天数
public Setup_Reflash                'int 刷新事务的时间/分

End Class
%>