

/*
 * 陈杰 JackChain
 * QQ:710782046
 * Email:ovenjackchain@gmail.com
 * Web:http://yj.ChinaCloudTech.com
 */
namespace DBHelper
{
    public class WMSFactory
    {
        public static YY_CommonMgr<Y_StyleFoundation> Y_StyleFoundation { get { return new YY_CommonMgr<Y_StyleFoundation>(); } }
        public static YY_CommonMgr<Y_GBCode> Y_GBCode { get { return new YY_CommonMgr<Y_GBCode>(); } }
        public static YY_CommonMgr<Y_StylePrint> Y_StylePrint { get { return new YY_CommonMgr<Y_StylePrint>(); } }
        public static YY_CommonMgr<Y_CareLabel> Y_CareLabel { get { return new YY_CommonMgr<Y_CareLabel>(); } }
        public static YY_CommonMgr<Y_StyleCareLabel> Y_StyleCareLabel { get { return new YY_CommonMgr<Y_StyleCareLabel>(); } }
		/*WMSPOINT*/
    }
}