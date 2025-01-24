using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;

public partial class profile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public class ClientDetail : IDisposable
    {
        // Properties
        public string ClientName { get; set; }
        public string MobileNo { get; set; }
        public string JoiningDate { get; set; }
        public string ReferBy { get; set; }
        public string NomineeName { get; set; }
        public string District { get; set; }



        // To keep track of whether Dispose has been called.
        private bool disposed = false;

        // Constructor
        public ClientDetail()
        {
            // Initialize any resources if needed (although none are necessary in this case).
        }

        // Implement IDisposable to free resources
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        // Protected Dispose method for resource cleanup
        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    // Dispose managed resources (if any).
                    // No managed resources to dispose in this class, but this is the place to do so if needed.
                }

                // Dispose unmanaged resources (if any).
                // No unmanaged resources to dispose in this class.

                disposed = true;
            }
        }

        // Destructor (finalizer)
        ~ClientDetail()
        {
            Dispose(false);
        }
    }


    [WebMethod]
    public static IEnumerable<ClientDetail> GetClientDetails(string clientId)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;

        string query = @"SELECT [ClientName], [MobileNo], [JoiningDate], 
                     [ReferBy], [NomineeName], [Address]
                     FROM [tradedata].[tradeadmin].[registrations] 
                     WHERE [ClientId] = @ClientId";

        var clientDetails = new List<ClientDetail>();

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@ClientId", clientId);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        clientDetails.Add(new ClientDetail
                        {
                            ClientName = reader["ClientName"].ToString(),
                            MobileNo = reader["MobileNo"].ToString(),
                            JoiningDate = Convert.ToDateTime(reader["JoiningDate"]).ToString("dd-MM-yyyy"),
                            ReferBy = reader["ReferBy"].ToString(),
                            NomineeName = reader["NomineeName"].ToString(),
                            District = reader["Address"].ToString(),

                        });
                    }
                }
            }
        }

        return clientDetails;
    }

    public class AgreementDetails
    {
        public string AgreementID { get; set; }
        public decimal TotalFund { get; set; }
        public string Term { get; set; }
        public string StartDate { get; set; }
        public string ExpireDate { get; set; }
        public string Priority { get; set; }
        public string Status { get; set; }
        public int NoOfPayments { get; set; }
    }

    [WebMethod]
    public static List<AgreementDetails> GetAgreementsByClientId(string clientId)
    {
        List<AgreementDetails> agreements = new List<AgreementDetails>();
        string connectionString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;

        string query = @"
    WITH LatestTransactions AS (
    SELECT 
        [AgreementID],
        [TransactionAmount],
        [TotalFund],
        [Term],
        [StartDate],
        [ExpireDate],
        [Priority],
        [CreatedDate],
        ROW_NUMBER() OVER (PARTITION BY [AgreementID] ORDER BY [CreatedDate] DESC) AS rn
    FROM 
        [tradedata].[tradeadmin].[aggrement]
    WHERE 
        [ClientId] = @ClientId
)
SELECT 
    [AgreementID],
    [TotalFund],
    [Term],
    [StartDate],
    [ExpireDate],
    [Priority],
    (SELECT COUNT(*) 
     FROM [tradedata].[tradeadmin].[aggrement] AS sub 
     WHERE sub.[AgreementID] = main.[AgreementID]) AS NoOfPayments
FROM 
    LatestTransactions main
WHERE 
    rn = 1 
ORDER BY 
    [CreatedDate] DESC;";


        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ClientId", clientId);
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var currentDate = DateTime.Now;
                            agreements.Add(new AgreementDetails
                            {
                                AgreementID = reader["AgreementID"].ToString(),
                                TotalFund = Convert.ToDecimal(reader["TotalFund"]),
                                Term = reader["Term"].ToString(),
                                StartDate = Convert.ToDateTime(reader["StartDate"]).ToString("dd/MM/yyyy"),
                                ExpireDate = Convert.ToDateTime(reader["ExpireDate"]).ToString("dd/MM/yyyy"),
                                Priority = reader["Priority"].ToString(),
                                Status = Convert.ToDateTime(reader["StartDate"]) <= currentDate && Convert.ToDateTime(reader["ExpireDate"]) >= currentDate
                ? "Running"
                : "Expired",
                                NoOfPayments = Convert.ToInt32(reader["NoOfPayments"])
                            });
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Log the exception (Consider using a logging framework like log4net or NLog)
            throw new Exception("Error fetching agreements: " + ex.Message, ex);
        }

        return agreements;
    }
}