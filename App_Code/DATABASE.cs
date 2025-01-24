using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for DATABASE
/// </summary>
public class DATABASE
{
	public DATABASE()
	{
		//
		// TODO: Add constructor logic here
		//


	}

    public DataTable returnDt(string qry)
    {
        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter(qry, getCon());
        da.Fill(dt);
        return dt;
    }

    public DataSet returnDs(string qry)
    {
        DataSet ds1 = new DataSet();
        using (SqlConnection con = new SqlConnection(getConstr()))
        {
            using (SqlCommand cmd = new SqlCommand(qry))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataSet ds = new DataSet())
                    {
                        sda.Fill(ds);
                        ds1 = ds;
                      
                    }
                }
            }
        }
        return ds1;
    }

    public SqlConnection getCon()
    {
        SqlConnection cn = new SqlConnection(getConstr());
        return cn;
    }

    static string cnstr = "";
    #region Database String
    public string getConstr()
    {
        if (cnstr == "")
            cnstr = ConfigurationManager.ConnectionStrings["satsangdata"].ToString();
        return cnstr;
    }
    #endregion

    public bool ExecQry(SqlCommand EQ)
    {
        try
        {
            SqlConnection cn = new SqlConnection();
            cn = getCon();
            EQ.Connection = cn;
            cn.Open();
            EQ.ExecuteNonQuery();
            cn.Close();
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }

    }

    public SqlCommand getCmd(string[] fields, object[] values, string sp)
    {
        SqlConnection cn = new SqlConnection();
        cn = getCon();
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = sp;
        if (fields.Length == values.Length)
        {
            for (int x = 0; x < fields.Length; x++)
            {
                cmd.Parameters.AddWithValue(fields[x], values[x]);
            }
        }
        return cmd;
    }
}