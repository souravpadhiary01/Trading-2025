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

public partial class alltransactions : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    [WebMethod]
    public static List<ClientTransactionDTO> GetAllTransactions()
    {
        List<ClientTransactionDTO> client = new List<ClientTransactionDTO>();

        String connectionString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            try
            {
                string query = @"
SELECT 
    r.ClientName, 
    r.referBy, 
    u.Amount, 
    u.CreatedDate, 
    u.ClientId,
    u.MyDocPath,
    u.uploadId
FROM 
    registrations r 
RIGHT OUTER JOIN 
    upload u 
ON 
    u.ClientId = r.ClientId
WHERE 
    u.status = 'pending'";

                con.Open();
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            

                          

                            client.Add(new ClientTransactionDTO
                            {
                                ClientName = reader.IsDBNull(0) ? string.Empty : reader.GetString(0),
                                ReferBy = reader.IsDBNull(1) ? string.Empty : reader.GetString(1),
                                Amount = reader.IsDBNull(2) ? 0 : reader.GetDecimal(2),
                                CreatedDate = reader.IsDBNull(3) ? string.Empty : reader.GetDateTime(3).ToString("dd/MM/yyyy HH:mm:ss"),
                                ClientId = reader.IsDBNull(4) ? string.Empty : reader.GetString(4),
                                MyDocPath = reader.IsDBNull(5) ? string.Empty : reader.GetString(5),
                                uploadId = reader.IsDBNull(6) ? 0 : reader.GetInt32(6)
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error fetching data: " + ex.Message);
            }
        }

        return client;
    }

    public class ClientTransactionDTO
    {
        public string ClientName { get; set; }
        public string ReferBy { get; set; }
        public decimal Amount { get; set; }
        public string CreatedDate { get; set; }
        public string ClientId { get; set; }
        public string MyDocPath { get; set; }
        public int uploadId { get; set; }
    }


 [System.Web.Services.WebMethod]
    public static string GetClientName(string clientId)
    {
        String connectionString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;
        string clientName = string.Empty;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT ClientName FROM [tradedata].[tradeadmin].[registrations] WHERE ClientId = @ClientId";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@ClientId", clientId);
                conn.Open();
                object result = cmd.ExecuteScalar();
                clientName = result != null ? result.ToString() : string.Empty;
            }
        }

        return clientName;
    }
   


}