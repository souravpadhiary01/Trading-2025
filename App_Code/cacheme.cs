using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Data.SqlClient;

using System.Configuration;

using System.Text.RegularExpressions;

/// <summary>
/// Summary description for cacheme
/// </summary>
/// 

[System.ComponentModel.DataObject]
public class cacheme
{
    public static DataTable dlvry = new DataTable();
    public static DataTable dlvryodr = new DataTable();
	public cacheme()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public static void LoadStaticCache()
    {
        DATABASE db = new DATABASE();

        //dlvry = db.returnDt("select * from FamilyHierarchy where status = 'active' or status='pending'");
        dlvryodr = db.returnDt("select * from tbl_postdata");
        //BookDetails_BLL.EmployeeHandler.GetEmployeeListch = emp.GetEmployeeList();
        //BookDetails_BLL.EmployeeHandler.GetSlidcat = emp.GetSliderlist(); 
    }


    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]


    public DataTable Getdlvry()
    {
        HttpContext.Current.Session["dlvryrpt"] = dlvry;
        return (DataTable)HttpContext.Current.Session["dlvryrpt"];
    }

    public DataTable Getdlvryodr()
    {
        HttpContext.Current.Session["dlvryrptodr"] = dlvryodr;
        return (DataTable)HttpContext.Current.Session["dlvryrptodr"];
    }
}