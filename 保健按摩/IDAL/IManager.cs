using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.IDAL
{
    public interface IManager
    {
        int Add(Model.Manager model);

        int uPAdmin(int id);

        int downAdmin(int id);

        System.Data.DataSet GetList(string strWhere);
        System.Data.DataSet GetList(int Top, string strWhere, string filedOrder);

        bool Delete(int id);

        System.Data.DataTable GetPage(string sqlWhere, int PageIndex, int PageSize, out int RecordCount, out int PageCount);

        int has(string strWhere);

        Model.Manager GetModel(int id);

        bool Update(Model.Manager manager);

        bool changes(string repair);

        bool upworks(string username);
    }
}
