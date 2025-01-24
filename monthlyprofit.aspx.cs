using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;

public partial class monthlyprofit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    // Data model for agreement data
    public class MonthlyProfit
    {
        public string AgreementID { get; set; }
        public string ClientName { get; set; }
        public decimal Funds { get; set; }
        public string Term { get; set; }
        public string Priority { get; set; }
        public string StartDate { get; set; }
        public string ExpireDate { get; set; }
        public string BankAccount { get; set; }
        public string ReferBy { get; set; }
    }

    [WebMethod]
    public static List<MonthlyProfit> Getmonthlyprofit()
    {
        List<MonthlyProfit> MonthlyprofitList = new List<MonthlyProfit>();

        string connString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;

        string query = @"  WITH CTE AS (
    SELECT 
        [AgreementID], 
        [ClientName], 
        [TotalFund], 
        [Term], 
        [Priority], 
        [StartDate], 
        [expireDate], 
        [Accountlink], 
        [refer] AS ReferBy,
        ROW_NUMBER() OVER (PARTITION BY [AgreementID] ORDER BY [tid] DESC) AS RowNum
    FROM 
        [tradedata].[tradeadmin].[aggrement]
)
SELECT 
    [AgreementID], 
    [ClientName], 
    [TotalFund], 
    [Term], 
    [Priority], 
    [StartDate], 
    [expireDate], 
    [Accountlink], 
    ReferBy
FROM 
    CTE
WHERE 
    RowNum = 1;";

        using (SqlConnection con = new SqlConnection(connString))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        MonthlyProfit data = new MonthlyProfit
                        {
                            AgreementID = reader["AgreementID"].ToString(),
                            ClientName = reader["ClientName"].ToString(),
                            Funds = reader["TotalFund"] != DBNull.Value ? Convert.ToDecimal(reader["TotalFund"]) : 0,
                            Term = reader["Term"].ToString(),
                            Priority = reader["Priority"].ToString(),
                            StartDate = Convert.ToDateTime(reader["StartDate"]).ToString("dd-MM-yyyy"),
                            ExpireDate = Convert.ToDateTime(reader["expireDate"]).ToString("dd-MM-yyyy"),
                            BankAccount = reader["Accountlink"].ToString(),
                            ReferBy = reader["ReferBy"].ToString(),
                        };

                        MonthlyprofitList.Add(data);
                    }
                }
            }
        }

        return MonthlyprofitList;
    }
}
