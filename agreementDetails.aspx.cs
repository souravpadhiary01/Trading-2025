using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class agreementDetails : System.Web.UI.Page
{
    private const string FtpFolder = "ftp://msksoftware.co.in/httpdocs/forestdoc/";
    private const string FtpUsername = "mskuser";
    private const string FtpPassword = "Swadhin@#12";

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static List<AgreementDetails> GetAgreementData(string agreementId)
    {
        List<AgreementDetails> agreementDetailsList = new List<AgreementDetails>();

        // Connection string to your database
        string connString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            // SQL query
            string query = @"
        SELECT 
            a.[ClientId],
            r.[ClientName],
            r.[NomineeName] AS nominee,
            a.[refer],
            a.[Accountlink],
            a.AgreementID,
            a.[profit],
            r.[MobileNo] AS contact,
            a.[TotalFund] AS capital,
            a.[StartDate],
            a.[expireDate],
            a.[Term],
            a.[profitclient]
        FROM 
            [tradedata].[tradeadmin].[aggrement] a
        JOIN 
            [tradedata].[tradeadmin].[registrations] r
        ON 
            a.ClientId = r.ClientId
        WHERE 
            a.AgreementID = @AgreementID";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@AgreementID", agreementId);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                // Populate AgreementDetails object and add it to the list
                agreementDetailsList.Add(new AgreementDetails
                {
                    ClientId = reader["ClientId"].ToString(),
                    ClientName = reader["ClientName"].ToString(),
                    Nominee = reader["nominee"].ToString(),
                    Refer = reader["refer"].ToString(),
                    Accountlink = reader["Accountlink"].ToString(),
                    AgreementID = reader["AgreementID"].ToString(),
                    Profit = reader["profit"].ToString(),
                    Contact = reader["contact"].ToString(),
                    Capital = reader["capital"].ToString(),
                    StartDate = reader["StartDate"].ToString(),
                    ExpireDate = reader["expireDate"].ToString(),
                    Term = reader["Term"].ToString(),
                    ProfitClient = reader["profitclient"].ToString()
                });
            }
        }

        // Directly return the list
        return agreementDetailsList;
    }

    public class AgreementDetails
    {
        public string ClientId { get; set; }
        public string ClientName { get; set; }
        public string Nominee { get; set; }
        public string Refer { get; set; }
        public string Accountlink { get; set; }
        public string AgreementID { get; set; }
        public string Profit { get; set; }
        public string Contact { get; set; }
        public string Capital { get; set; }
        public string StartDate { get; set; }
        public string ExpireDate { get; set; }
        public string Term { get; set; }
        public string ProfitClient { get; set; }
    }

    [WebMethod]
    public static List<AgreementData> GetAgreementDatax(string agreementId)
    {
        List<AgreementData> agreementsList = new List<AgreementData>();

        try
        {
            string connString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // Updated query based on provided SQL
                string query = @"
                SELECT  
                    [TransactionAmount],
[StartDate],
                    [ClientReceipt],
                    [CurrentTransaction],
                    [DaysInvestment],
                    [ClientReceiptpath],
                    [profit]
                FROM [tradedata].[tradeadmin].[aggrement]
                WHERE [AgreementID] = @AgreementID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@AgreementID", agreementId);

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    // Map the data to AgreementData object
                    AgreementData agreement = new AgreementData
                    {
                        TransactionAmount = reader["TransactionAmount"].ToString(),
                        StartDate = Convert.ToDateTime(reader["StartDate"]).ToString("dd/MM/yyyy"),
                        ClientReceipt = reader["ClientReceipt"].ToString(),
                        CurrentTransaction = Convert.ToDateTime(reader["CurrentTransaction"]).ToString("dd/MM/yyyy"),
                        DaysInvestment = reader["DaysInvestment"].ToString(),
                        ClientReceiptPath = reader["ClientReceiptpath"].ToString(),
                        Profit = reader["profit"].ToString()
                    };

                    agreementsList.Add(agreement);
                }
            }
        }
        catch (Exception ex)
        {
            // Log the error or handle it accordingly
            return new List<AgreementData> { new AgreementData { TransactionAmount = ex.Message } };
        }

        return agreementsList;
    }


    public class AgreementData
    {
        public string TransactionAmount { get; set; }
        public string ClientReceipt { get; set; }
        public string CurrentTransaction { get; set; }
        public string DaysInvestment { get; set; }
        public string ClientReceiptPath { get; set; }
        public string Profit { get; set; }
        public string StartDate { get; set; }

    }
    private static bool UploadFileToFtp(string base64Data, string fileName)
    {
        if (string.IsNullOrEmpty(base64Data) || string.IsNullOrEmpty(fileName))
        {
            return false;
        }

        try
        {
            string[] dataParts = base64Data.Split(',');
            if (dataParts.Length < 2)
            {
                return false;
            }

            byte[] fileBytes = Convert.FromBase64String(dataParts[1]);

            string fullPath = FtpFolder + fileName;
            FtpWebRequest request = (FtpWebRequest)WebRequest.Create(fullPath);
            request.Method = WebRequestMethods.Ftp.UploadFile;
            request.Credentials = new NetworkCredential(FtpUsername, FtpPassword);
            request.ContentLength = fileBytes.Length;
            request.UsePassive = true;
            request.UseBinary = true;
            request.ServicePoint.ConnectionLimit = fileBytes.Length;
            request.EnableSsl = false;

            using (Stream requestStream = request.GetRequestStream())
            {
                requestStream.Write(fileBytes, 0, fileBytes.Length);
            }

            using (FtpWebResponse response = (FtpWebResponse)request.GetResponse())
            {
                return response.StatusCode == FtpStatusCode.ClosingData;
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("FTP upload failed: " + ex.Message);
            return false;
        }
    }

    [WebMethod]
    public static string SaveModalData(data data)
    {
        try
        {
            // Validate input data
            if (string.IsNullOrEmpty(data.agreementId))
            {
                return "Error: AgreementId is required.";
            }

            // Prepare file path for the database
            string filePathInDatabase = null;

            // Handle file upload if Base64 data is provided
            if (!string.IsNullOrEmpty(data.fileData) && !string.IsNullOrEmpty(data.fileName))
            {
                // Upload file to FTP server
                bool isUploaded = UploadFileToFtp(data.fileData, data.fileName);
                if (isUploaded)
                {
                    filePathInDatabase = string.Format("https://msksoftware.co.in/forestdoc/{0}", data.fileName);
                }
                else
                {
                    return "Error: Failed to upload file.";
                }
            }

            // Save form data to the database
            string connString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connString))
            {
                const string query = @"
            INSERT INTO [tradedata].[tradeadmin].[FundManagement]
            ([AgreementId], [WithdrawalAmount], [WithdrawalDate], [ActiveFund], [note], [pic], [Status])
            VALUES (@AgreementId, @WithdrawalAmount, @WithdrawalDate, @ActiveFund, @Note, @Pic, 'W')";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    // Map parameters to table columns
                    cmd.Parameters.AddWithValue("@AgreementId", data.agreementId);
                    cmd.Parameters.AddWithValue("@WithdrawalAmount", data.WithdrawalAmount);
                    cmd.Parameters.AddWithValue("@WithdrawalDate", Convert.ToDateTime(data.WithdrawalDate));
                    cmd.Parameters.AddWithValue("@ActiveFund", data.activeFund);
                    cmd.Parameters.AddWithValue("@Pic", filePathInDatabase ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@Note", data.note ?? (object)DBNull.Value);

                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        return "Success";
                    }
                    else
                    {
                        return "Error: No rows were affected.";
                    }
                }
            }
        }
        catch (SqlException sqlEx)
        {
            System.Diagnostics.Debug.WriteLine("SQL Error: " + sqlEx.Message);
            return "Error: Database operation failed.";
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
            return string.Format("Error: {0}", ex.Message);
        }
    }

    public class data
    {
        public string agreementId { get; set; }
        public decimal WithdrawalAmount { get; set; }
        public string WithdrawalDate { get; set; }
        public decimal activeFund { get; set; }
        public string fileData { get; set; }
        public string fileName { get; set; }
        public string note { get; set; }    
    }

    [WebMethod]
   
    public static decimal GetActiveFund(string agreementId)
    {
        try
        {
            string connString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connString))
            {
                const string query = "SELECT ActiveFund FROM [tradedata].[tradeadmin].[FundManagement] WHERE AgreementId = @AgreementId";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@AgreementId", agreementId);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        return Convert.ToDecimal(result); // Return ActiveFund value
                    }
                    else
                    {
                        return 0; // Return 0 if no record is found
                    }
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error fetching active fund: " + ex.Message);
            throw new Exception("Error fetching active fund.");
        }
    }

    [WebMethod]
   
    public static object GetClientData()
    {
        try
        {
            string connectionString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;
            List<object> clientData = new List<object>();

            string query = @"
            SELECT 
                [WithdrawalDate],
                [WithdrawalAmount],
                [ActiveFund],
                [pic],
                [note]
            FROM [tradedata].[tradeadmin].[FundManagement]";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            clientData.Add(new
                            {
                                TransactionDate = reader["WithdrawalDate"] != DBNull.Value
                                                  ? Convert.ToDateTime(reader["WithdrawalDate"]).ToString("yyyy-MM-dd")
                                                  : string.Empty,
                                WithdrawAmount = reader["WithdrawalAmount"] != DBNull.Value
                                                 ? Convert.ToDecimal(reader["WithdrawalAmount"])
                                                 : 0m,
                                ActiveFund = reader["ActiveFund"] != DBNull.Value
                                             ? Convert.ToDecimal(reader["ActiveFund"])
                                             : 0m,
                                File = reader["pic"] != DBNull.Value
                                      ? reader["pic"].ToString()
                                      : string.Empty,
                                Note = reader["note"] != DBNull.Value
                                      ? reader["note"].ToString()
                                      : string.Empty
                            });
                        }
                    }
                }
            }

            return new
            {
                data = clientData
            };
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error fetching data: " + ex.Message);
            return new
            {
                error = true,
                message = "Error fetching data: " + ex.Message
            };
        }
    }


}