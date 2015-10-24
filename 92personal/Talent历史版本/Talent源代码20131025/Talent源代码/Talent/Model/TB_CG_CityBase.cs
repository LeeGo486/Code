using System;
namespace Talent.Model
{
    /// <summary>
    /// TB_CG_CityBase:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class TB_CG_CityBase
    {
        public TB_CG_CityBase()
        { }
        #region Model
        private int _cb_no;
        private string _cb_name;
        private string _cb_shopnum;
        private string _cb_num;
        private string _cb_setup;
        private string _cb_je;
        private string _cb_des;
        private string _cb_x;
        private string _cb_y;
        private string _SP_Area;
        private string _SP_Mode;
        private string _SP_AVGBase;
        private string _SP_MAXBase;
        private string _SP_MINBase;
        private string _SP_CompanyParRatio;
        private string _SP_PersonalParRatio;
        private string _SP_CompanyWorkRatio;
        private string _SP_PersonalWorkRatio;
        private string _SP_CompanyBirthRatio;
        private string _SP_PersonalInjuryRatio;
        private string _SP_CompanyMedicalRatio;
        private string _SP_PersonalMedicalRatio;
        private string _SP_CompanySimulateRatio;
        private string _SP_PersonalSimulateRatio;
        private string _SP_SocialDate;
        private string _SP_HealthDate;
        private string _SP_SocialAMDate;
        private string _SP_SocialData;
        private string _SP_SocialLocalPolicy;
        private string _SP_BusinessTransact;
        private string _MP_Mode;
        private string _MP_MAXBase;
        private string _MP_MINBase;
        private string _MP_CompanyRatio;
        private string _MP_PersonalRatio;
        private string _MP_MPFAdjustDate;
        private string _MP_MPFAMDate;
        private string _MP_MPFLocalPolicy;
        private string _PP_PerPolicyOne;
        private string _PP_PerPolicyTwo;
        private string _WP_WelfarePolicyOne;
        private string _WP_WelfarePolicyTwo;

        private string _WT_WPType;
        private string _WT_Color;
        private string _SP_Remark1;
        private string _SP_DateTime;

        

        public int CB_No
        {
            set { _cb_no = value; }
            get { return _cb_no; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string CB_Name
        {
            set { _cb_name = value; }
            get { return _cb_name; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string CB_Des
        {
            set { _cb_des = value; }
            get { return _cb_des; }
        }
        /// <summary>

        /// 
        /// </summary>
        public string cb_shopnum
        {
            set { _cb_shopnum = value; }
            get { return _cb_shopnum; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string CB_Num
        {
            set { _cb_num = value; }
            get { return _cb_num; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string cb_setup
        {
            set { _cb_setup = value; }
            get { return _cb_setup; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string CB_Je
        {
            set { _cb_je = value; }
            get { return _cb_je; }
        }

        public string CB_X
        {
            set { _cb_x = value; }
            get { return _cb_x; }
        }

        public string CB_Y
        {
            set { _cb_y = value; }
            get { return _cb_y; }
        }
        public string WT_WPType
        {
            set { _WT_WPType = value; }
            get { return _WT_WPType; }
        }
        public string WT_Color
        {
            set { _WT_Color = value; }
            get { return _WT_Color; }
        }

        public string SP_Area
        {
            set { _SP_Area = value; }
            get { return _SP_Area; }
        }
        public string SP_Mode
        {
            set { _SP_Mode = value; }
            get { return _SP_Mode; }
        }
        public string SP_AVGBase
        {
            set { _SP_AVGBase = value; }
            get { return _SP_AVGBase; }
        }
        public string SP_MAXBase
        {
            set { _SP_MAXBase = value; }
            get { return _SP_MAXBase; }
        }
        public string SP_MINBase
        {
            set { _SP_MINBase = value; }
            get { return _SP_MINBase; }
        }
        public string SP_CompanyParRatio
        {
            set { _SP_CompanyParRatio = value; }
            get { return _SP_CompanyParRatio; }
        }
        public string SP_PersonalParRatio
        {
            set { _SP_PersonalParRatio = value; }
            get { return _SP_PersonalParRatio; }
        }     
        public string SP_CompanyWorkRatio
        {
            set { _SP_CompanyWorkRatio = value; }
            get { return _SP_CompanyWorkRatio; }
        }
        public string SP_PersonalWorkRatio
        {
            set { _SP_PersonalWorkRatio = value; }
            get { return _SP_PersonalWorkRatio; }
        }   
        public string SP_CompanyBirthRatio
        {
            set { _SP_CompanyBirthRatio = value; }
            get { return _SP_CompanyBirthRatio; }
        }   
        public string SP_PersonalInjuryRatio
        {
            set { _SP_PersonalInjuryRatio = value; }
            get { return _SP_PersonalInjuryRatio; }
        }   
        public string SP_CompanyMedicalRatio
        {
            set { _SP_CompanyMedicalRatio = value; }
            get { return _SP_CompanyMedicalRatio; }
        }   
        public string SP_PersonalMedicalRatio
        {
            set { _SP_PersonalMedicalRatio = value; }
            get { return _SP_PersonalMedicalRatio; }
        }    
        public string SP_CompanySimulateRatio
        {
            set { _SP_CompanySimulateRatio = value; }
            get { return _SP_CompanySimulateRatio; }
        }    
        public string SP_PersonalSimulateRatio
        {
            set { _SP_PersonalSimulateRatio = value; }
            get { return _SP_PersonalSimulateRatio; }
        }
        public string SP_SocialDate
        {
            set { _SP_SocialDate = value; }
            get { return _SP_SocialDate; }
        }
        public string SP_HealthDate
        {
            set { _SP_HealthDate = value; }
            get { return _SP_HealthDate; }
        }
        public string SP_SocialAMDate
        {
            set { _SP_SocialAMDate = value; }
            get { return _SP_SocialAMDate; }
        }
         
        public string SP_SocialData
        {
            set { _SP_SocialData = value; }
            get { return _SP_SocialData; }
        }
        
        public string  SP_SocialLocalPolicy
        {
            set { _SP_SocialLocalPolicy = value; }
            get { return _SP_SocialLocalPolicy; }
        }
        
        public string  SP_BusinessTransact
        {
            set { _SP_BusinessTransact = value; }
            get { return _SP_BusinessTransact; }
        }
         
        public string MP_Mode
        {
            set { _MP_Mode = value; }
            get { return _MP_Mode; }
        }
         
        public string MP_MAXBase
        {
            set { _MP_MAXBase = value; }
            get { return _MP_MAXBase; }
        }
         
        public string MP_MINBase
        {
            set { _MP_MINBase = value; }
            get { return _MP_MINBase; }
        }
         
        public string MP_CompanyRatio
        {
            set { _MP_CompanyRatio = value; }
            get { return _MP_CompanyRatio; }
        }
         
        public string  MP_PersonalRatio
        {
            set { _MP_PersonalRatio = value; }
            get { return _MP_PersonalRatio; }
        }
        
        public string MP_MPFAdjustDate
        {
            set { _MP_MPFAdjustDate = value; }
            get { return _MP_MPFAdjustDate; }
        }

        public string MP_MPFAMDate
        {
            set { _MP_MPFAMDate = value; }
            get { return _MP_MPFAMDate; }
        }
        
        public string MP_MPFLocalPolicy
        {
            set { _MP_MPFLocalPolicy = value; }
            get { return _MP_MPFLocalPolicy; }
        }
       
        public string  PP_PerPolicyOne
        {
            set { _PP_PerPolicyOne = value; }
            get { return _PP_PerPolicyOne; }
        }
         
        public string  PP_PerPolicyTwo
        {
            set { _PP_PerPolicyTwo = value; }
            get { return _PP_PerPolicyTwo; }
        }
       
        public string  WP_WelfarePolicyOne
        {
            set { _WP_WelfarePolicyOne = value; }
            get { return _WP_WelfarePolicyOne; }
        }
        
        public string WP_WelfarePolicyTwo
        {
            set { _WP_WelfarePolicyTwo = value; }
            get { return _WP_WelfarePolicyTwo; }
        }

        public string SP_Remark1
        {
            set { _SP_Remark1 = value; }
            get { return _SP_Remark1; }
        }


        public string SP_DateTime
        {
            set { _SP_DateTime = value; }
            get { return _SP_DateTime; }
        }
        /// <summary>
        /// 
        /// </summary>
        
          
        #endregion Model

    }
}

