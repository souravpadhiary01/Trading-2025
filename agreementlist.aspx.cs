using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;
using System.Web.Services;
using System.Net;
using System.Text.RegularExpressions;

using System.Threading;
using System.Threading.Tasks;

using System.Web.Script.Services;


public partial class agreementlist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public class AgreementData
    {
        public string ClientName { get; set; }
        public string AgreementID { get; set; }
        public decimal TotalFund { get; set; }
        public string Refer { get; set; }
        public string Priority { get; set; }
        public string StartDate { get; set; }
        public string ExpireDate { get; set; }
        public decimal ProfitClient { get; set; }
    }
    [WebMethod]
    public static List<AgreementData> GetAgreementData()
    {
        List<AgreementData> agreementDataList = new List<AgreementData>();

        string connString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;


        string query = @"SELECT  [ClientName], [AgreementID], [TotalFund], 
                         [refer], [Priority], [StartDate], [expireDate], [profitclient]
                         FROM [tradedata].[tradeadmin].[aggrement]";

        using (SqlConnection con = new SqlConnection(connString))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        AgreementData data = new AgreementData
                        {
                            ClientName = reader["ClientName"].ToString(),
                            AgreementID = reader["AgreementID"].ToString(),
                            TotalFund = reader["TotalFund"] != DBNull.Value ? Convert.ToDecimal(reader["TotalFund"]) : 0,
                            Refer = reader["refer"].ToString(),
                            Priority = reader["Priority"].ToString(),
                            StartDate = Convert.ToDateTime(reader["StartDate"]).ToString("dd-MM-yyyy"),
                            ExpireDate = Convert.ToDateTime(reader["expireDate"]).ToString("dd-MM-yyyy"),
                            ProfitClient = reader["profitclient"] != DBNull.Value ? Convert.ToDecimal(reader["profitclient"]) : 0
                        };

                        agreementDataList.Add(data);
                    }
                }
            }
        }

        return agreementDataList;
    }
}