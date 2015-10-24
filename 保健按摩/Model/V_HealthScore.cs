using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
   public  class V_HealthScore
    {
         public V_HealthScore()
        {

        }
         public V_HealthScore( long fid,  string doctor, int lidao, int jifa, int shushidu, int liaoxiao, int jiafa
            ,int fuwutaidu,int totalsum,int countdoctor )
        {
            _fid = fid;
            _doctor = doctor;

            _liaoxiao = liaoxiao;
            _lidao = lidao;
            _shushidu = shushidu;
            _jifa = jifa;
            _fuwutaidu = fuwutaidu;
            _totalsum = totalsum;
            _countdoctor = countdoctor;
          
        }



         private long _fid;
        private string _doctor;
        private int _lidao;
        private int _shushidu;
        private int _liaoxiao;
        private int _jifa;
        private int _fuwutaidu;
        private int _totalsum;
        private int _countdoctor;


        public long fid
        {
            set { _fid = value; }
            get { return _fid; }
        }
       
        public string doctor
        {
            set { _doctor = value; }
            get { return _doctor; }

        }

        public int liaoxiao
        {
            set { _liaoxiao = value; }
            get { return _liaoxiao; }
        }
        public int lidao
        {
            set { _lidao = value; }
            get { return _lidao; }
        }
        public int shushidu
        {
            set { _shushidu = value; }
            get { return _shushidu; }
        }
        public int jifa
        {
            set { _jifa = value; }
            get { return _jifa; }
        }
        public int fuwutaidu
        {
            set { _fuwutaidu = value; }
            get { return _fuwutaidu; }
        }

        public int totalsum
        {
            set { _totalsum = value; }
            get { return _totalsum; }
        }

        public int countdoctor
        {
            set { _countdoctor = value; }
            get { return _countdoctor; }
        }
        
        //返回自动增长的ID
        private string ReturnAutoID()
        {
            return "fid";
        }
    }
}
