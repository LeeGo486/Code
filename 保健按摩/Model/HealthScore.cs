using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
    public class HealthScore
    {

        public HealthScore()
        {

        }
        public HealthScore(int fid,string orderid,string doctor,int lidao,int jifa,int shushidu,int liaoxiao,int jiafa
            ,int fuwutaidu,int totalsum,string createperson,string createtime,string descripiton)
        {
            _fid = fid;
            _orderid = orderid;
          
            _doctor = doctor;
            _liaoxiao = liaoxiao;
            _lidao = lidao;
            _shushidu = shushidu;
            _jifa = jifa;
            _fuwutaidu = fuwutaidu;
            _totalsum = totalsum;
            _description = descripiton;
            _createperson = createperson;
            _createtime = createtime;
        }



        private int _fid;
        private string _orderid;
        private string _doctor;
        private int _lidao;
        private int _shushidu;
        private int _liaoxiao;
        private int _jifa;
        private int _fuwutaidu;
        private int _totalsum;
        private string _description;
        private string _createperson;
        private string _createtime;

        public int fid
        {
            set { _fid = value; }
            get { return _fid; }
        }
        public string  orderid
        {
            set { _orderid = value; }
            get { return _orderid; }
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
        public string description
        {
            set { _description = value; }
            get { return _description; }
        }
        public string  createtime
        {
            set { _createtime = value; }
            get { return _createtime; }
        }

        public string  createperson
        {
            set { _createperson = value; }
            get { return _createperson; }
        }
        //返回自动增长的ID
        private string ReturnAutoID()
        {
            return "fid";
        }
    }
}
