using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
/// <summary>
/// Summary description for Connection
/// </summary>
public class Connection
{
	public Connection()
	{
		//
		//constructor logic here
		//
	}

    private static SqlConnection sqlConnection;

    /// <summary>
    /// get sql connection 
    /// </summary>
    /// <returns>sqlConnection object</returns>
    public static SqlConnection GetConnection()
    {
        var connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        sqlConnection = new SqlConnection(connectionString);
        return sqlConnection;
    }

    /// <summary>
    /// check if sql connection state is closed then open the connection
    /// </summary>
    /// <returns>sqlConnection object</returns>
    public static SqlConnection OpenConnection()
    {
        if (sqlConnection.State == System.Data.ConnectionState.Closed)
            sqlConnection.Open();
        return sqlConnection;
    }

    /// <summary>
    /// check if sql connection state is open then close the connection
    /// </summary>
    /// <returns>sqlConnection object</returns>
    public static SqlConnection CloseConnection()
    {
        if (sqlConnection.State == System.Data.ConnectionState.Open)
            sqlConnection.Close();
        return sqlConnection;
    }// TODO: Add 
}