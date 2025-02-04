using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Services;
using System.Configuration;
using System.Web.Script.Serialization;

public partial class profile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) { }

    public class ClientDetail : IDisposable
    {
        public string ClientName { get; set; }
        public string MobileNo { get; set; }
        public string JoiningDate { get; set; }
        public string ReferBy { get; set; }
        public string NomineeName { get; set; }
        public string District { get; set; }

        private bool disposed = false;

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                disposed = true;
            }
        }

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
                            ClientName = reader["ClientName"] as string ?? "N/A",
                            MobileNo = reader["MobileNo"] as string ?? "N/A",
                            JoiningDate = !reader.IsDBNull(reader.GetOrdinal("JoiningDate"))
                                ? Convert.ToDateTime(reader["JoiningDate"]).ToString("dd-MM-yyyy")
                                : "N/A",
                            ReferBy = reader["ReferBy"] as string ?? "N/A",
                            NomineeName = reader["NomineeName"] as string ?? "N/A",
                            District = reader["Address"] as string ?? "N/A",
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
    }

    [WebMethod]
    public static List<AgreementDetails> GetAgreementsByClientId(string clientId)
    {
        List<AgreementDetails> agreements = new List<AgreementDetails>();
        string connectionString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;

        string query = @"
            SELECT 
                AgreementID, 
                TotalFund, 
                Term, 
                StartDate, 
                ExpireDate, 
                Priority, 
                CASE 
                    WHEN GETDATE() BETWEEN StartDate AND ExpireDate THEN 'Running'
                    ELSE 'Expired'
                END AS Status
            FROM tradedata.tradeadmin.aggrement
            WHERE ClientId = @ClientId";

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
                            agreements.Add(new AgreementDetails
                            {
                                AgreementID = reader["AgreementID"] as string ?? "N/A",
                                TotalFund = !reader.IsDBNull(reader.GetOrdinal("TotalFund"))
                                    ? Convert.ToDecimal(reader["TotalFund"])
                                    : 0m,
                                Term = reader["Term"] as string ?? "N/A",
                                StartDate = !reader.IsDBNull(reader.GetOrdinal("StartDate"))
                                    ? Convert.ToDateTime(reader["StartDate"]).ToString("dd/MM/yyyy")
                                    : "N/A",
                                ExpireDate = !reader.IsDBNull(reader.GetOrdinal("ExpireDate"))
                                    ? Convert.ToDateTime(reader["ExpireDate"]).ToString("dd/MM/yyyy")
                                    : "N/A",
                                Priority = reader["Priority"] as string ?? "N/A",
                                Status = reader["Status"] as string ?? "N/A"
                            });
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Error fetching agreements: " + ex.Message, ex);
        }

        return agreements;
    }

    [WebMethod]
    public static object GetTransactionHistory(string clientId)
    {
        if (string.IsNullOrEmpty(clientId))
        {
            return new { success = false, message = "Client ID is required!" };
        }

        List<Transaction> transactions = new List<Transaction>();
        string connectionString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = @"
                SELECT 
                    a.AgreementId,
                    a.DepositAmount,
                    a.DepositDate,
                    a.WithdrawalAmount,
                    a.WithdrawalDate,
                    a.ActiveFund,
                    a.Profit
                FROM tradedata.tradeadmin.FundManagement a
                LEFT JOIN tradedata.tradeadmin.aggrement b
                ON a.AgreementId = b.AgreementID 
                WHERE b.ClientId = @ClientId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ClientId", clientId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            transactions.Add(new Transaction
                            {
                                AgreementId = reader["AgreementId"].ToString(),
                                DepositAmount = reader["DepositAmount"] != DBNull.Value ? Convert.ToDecimal(reader["DepositAmount"]) : 0,
                                DepositDate = reader["DepositDate"] != DBNull.Value ? Convert.ToDateTime(reader["DepositDate"]).ToString("yyyy-MM-dd") : "",
                                WithdrawalAmount = reader["WithdrawalAmount"] != DBNull.Value ? Convert.ToDecimal(reader["WithdrawalAmount"]) : 0,
                                WithdrawalDate = reader["WithdrawalDate"] != DBNull.Value ? Convert.ToDateTime(reader["WithdrawalDate"]).ToString("yyyy-MM-dd") : "",
                                ActiveFund = reader["ActiveFund"] != DBNull.Value ? Convert.ToDecimal(reader["ActiveFund"]) : 0,
                                Profit = reader["Profit"] != DBNull.Value ? Convert.ToDecimal(reader["Profit"]) : 0
                            });
                        }
                    }
                }
            }

            return new { success = true, data = transactions };
        }
        catch (Exception ex)
        {
            // Log the error (optional)
            return new { success = false, message = "Error fetching transactions: " + ex.Message };
        }
    }

    public class Transaction
    {
        public string AgreementId { get; set; }
        public decimal DepositAmount { get; set; }
        public string DepositDate { get; set; }
        public decimal WithdrawalAmount { get; set; }
        public string WithdrawalDate { get; set; }
        public decimal ActiveFund { get; set; }
        public decimal Profit { get; set; }
    }
}