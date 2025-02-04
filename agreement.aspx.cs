using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Net;
using System.Activities.Statements;
using System.Web;
using System.Data;
using System.Globalization;
using System.Security.Cryptography;


public partial class agreement : System.Web.UI.Page
{
    private const string FtpFolder = "ftp://msksoftware.co.in/httpdocs/tradingdoc/";
    private const string FtpUsername = "mskuser";
    private const string FtpPassword = "Swadhin@#12";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            
            // Initialize page if needed
        }
      
    }
    private static bool UploadFileToFtp(string picData, string filePath)
    {
        if (string.IsNullOrEmpty(filePath) || string.IsNullOrEmpty(picData))
        {
            return false;
        }

        try
        {
            string[] picParts = picData.Split(',');
            if (picParts.Length < 2)
            {
                return false;
            }

            byte[] bytes = Convert.FromBase64String(picParts[1]);
            string[] pathParts = filePath.Split('.');
            if (pathParts.Length < 2)
            {
                return false;
            }

            string fullPath = string.Format("{0}{1}profile.{2}", FtpFolder, pathParts[0], pathParts[1]);

            FtpWebRequest request = (FtpWebRequest)WebRequest.Create(fullPath);
            request.Method = WebRequestMethods.Ftp.UploadFile;
            request.Credentials = new NetworkCredential(FtpUsername, FtpPassword);
            request.ContentLength = bytes.Length;
            request.UsePassive = true;
            request.UseBinary = true;
            request.ServicePoint.ConnectionLimit = bytes.Length;
            request.EnableSsl = false;

            using (Stream requestStream = request.GetRequestStream())
            {
                requestStream.Write(bytes, 0, bytes.Length);
            }

            using (FtpWebResponse response = (FtpWebResponse)request.GetResponse())
            {
                return response.StatusCode == FtpStatusCode.ClosingData;
            }
        }
        catch (WebException ex)
        {
            FtpWebResponse response = ex.Response as FtpWebResponse;
            string errorMessage = response != null ? response.StatusDescription : ex.Message;
            System.Diagnostics.Debug.WriteLine(string.Format("FTP Upload failed: {0}", errorMessage));
            return false;
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(string.Format("Upload failed: {0}", ex.Message));
            return false;
        }
    }

    private static string GetUploadedPath(string baseFileName, string path)
    {
        if (string.IsNullOrEmpty(path))
        {
            return string.Empty;
        }

        string[] pathParts = path.Split('.');
        if (pathParts.Length < 2)
        {
            return string.Empty;
        }

        return string.Format("https://msksoftware.co.in/httpdocs/tradingdoc/{0}profile.{1}", pathParts[0], pathParts[1]);
    }

    public class AgreementDetails
    {
        public string ClientName { get; set; }
        public string ClientID { get; set; }
        public decimal TransactionAmount { get; set; }
        public string ClientReceipt { get; set; }
    
        public string AgreementID { get; set; }
        public string AgreementDocument { get; set; }
        public string Refer { get; set; }
        public decimal Percentage { get; set; }
        public string Priority { get; set; }
        public decimal TotalFund { get; set; }
        public DateTime StartDate { get; set; }
        public int Term { get; set; }
        public DateTime ExpireDate { get; set; }
        public decimal ProfitClient { get; set; }
        public string AccountLink { get; set; }
        public DateTime CurrentTransaction { get; set; }
        public int DaysInvestment { get; set; }
        public string Pic { get; set; }
        public string Path { get; set; }
        public string IFSC { get; set; }
        public string calculatedProfit { get; set; }
         public string UploadId { get; set; }



       


    }

    [WebMethod]
    public static string abcd(AgreementDetails formData)
    {
        try
        {
           
            string picFilePath = string.Empty;

            // Check if Pic and Path are provided
            if (!string.IsNullOrEmpty(formData.Pic) && !string.IsNullOrEmpty(formData.Path))
            {
                bool picUploaded = UploadFileToFtp(formData.Pic, formData.Path);
                if (picUploaded)
                {
                    picFilePath = "https://msksoftware.co.in/tradingdoc/" + formData.Path;
                }
                else
                {
                    return "Error: File upload failed.";
                }
            }

            string constr = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;

            using (SqlConnection con = new SqlConnection(constr))
            {
                const string insertQuery = @"
            INSERT INTO [tradedata].[tradeadmin].[aggrement] 
            (ClientName, ClientID, TransactionAmount, ClientReceipt, AgreementID, 
             AgreementDocument, Refer, Percentage, Priority, TotalFund, StartDate, Term, 
             ExpireDate, ProfitClient, AccountLink, CurrentTransaction, DaysInvestment, ClientReceiptpath, IFSC, profit, [upload])
            VALUES 
            (@ClientName, @ClientID, @TransactionAmount, @ClientReceipt, @AgreementID, 
             @AgreementDocument, @Refer, @Percentage, @Priority, @TotalFund, @StartDate, @Term, 
             @ExpireDate, @ProfitClient, @AccountLink, @CurrentTransaction, @DaysInvestment, @ClientReceiptpath, @IFSC, @profit, @UploadId)";

                using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                {
                    cmd.Parameters.AddWithValue("@ClientName", formData.ClientName ?? string.Empty);
                    cmd.Parameters.AddWithValue("@ClientID", formData.ClientID ?? string.Empty);
                    cmd.Parameters.AddWithValue("@TransactionAmount", formData.TransactionAmount);
                    cmd.Parameters.AddWithValue("@ClientReceipt", formData.ClientReceipt ?? string.Empty);
             
                    cmd.Parameters.AddWithValue("@AgreementID", formData.AgreementID ?? string.Empty);
                    cmd.Parameters.AddWithValue("@AgreementDocument", formData.AgreementDocument ?? string.Empty);
                    cmd.Parameters.AddWithValue("@Refer", formData.Refer ?? string.Empty);
                    cmd.Parameters.AddWithValue("@Percentage", formData.Percentage);
                    cmd.Parameters.AddWithValue("@Priority", formData.Priority ?? string.Empty);
                    cmd.Parameters.AddWithValue("@TotalFund", formData.TotalFund);
                    cmd.Parameters.AddWithValue("@StartDate", formData.StartDate);
                    cmd.Parameters.AddWithValue("@Term", formData.Term);
                    cmd.Parameters.AddWithValue("@ExpireDate", formData.ExpireDate);
                    cmd.Parameters.AddWithValue("@ProfitClient", formData.ProfitClient);
                    cmd.Parameters.AddWithValue("@AccountLink", formData.AccountLink ?? string.Empty);
                    cmd.Parameters.AddWithValue("@CurrentTransaction", formData.CurrentTransaction);
                    cmd.Parameters.AddWithValue("@DaysInvestment", formData.DaysInvestment);
                    cmd.Parameters.AddWithValue("@ClientReceiptpath", picFilePath ?? string.Empty);
                    cmd.Parameters.AddWithValue("@IFSC", formData.IFSC ?? string.Empty);
                    cmd.Parameters.AddWithValue("@profit", formData.calculatedProfit ?? string.Empty);
                    cmd.Parameters.AddWithValue("@UploadId", formData.UploadId ?? string.Empty);
                

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                const string updateQuery = @"
            UPDATE [tradedata].[tradeadmin].[upload]
            SET [status] = 'success'
            WHERE [uploadId] = @UploadId";

                using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
                {
                    updateCmd.Parameters.AddWithValue("@UploadId", formData.UploadId ?? string.Empty);
                    int rowsAffected = updateCmd.ExecuteNonQuery();

                    if (rowsAffected == 0)
                    {
                        return "Error: Upload ID not found or no rows were updated.";
                    }
                }
            }

         
                CultureInfo indianCulture = new CultureInfo("en-IN");
                int currentMonth = DateTime.Now.Month;
                string currentMonthName = indianCulture.DateTimeFormat.GetMonthName(currentMonth);

                decimal monthlyInterestRate = formData.ProfitClient;
                int daysInMonth = DateTime.DaysInMonth(DateTime.Now.Year, currentMonth);
                decimal rateOfInterestPerDay = monthlyInterestRate / daysInMonth;

                DATABASE DB = new DATABASE();
                DataTable fr = DB.returnDt("select * from FundManagement where AgreementId='" + formData.AgreementID + "'");

                if (fr.Rows.Count == 0)
                {
                    // Insert new record if AgreementId does not exist
                    using (SqlConnection con = new SqlConnection(constr))
                    {
                        con.Open();
                        SqlCommand cmd = new SqlCommand(
                            "INSERT INTO FundManagement (AgreementId, DepositAmount, DepositDate, ActiveFund, RateOfInterestPerDay, NumberOfDays, Status, Profit, Denomination,datex) " +
                            "VALUES (@AgreementId, @DepositAmount, @DepositDate, @ActiveFund, @RateOfInterestPerDay, 0, 'I', 0, @Denomination,@datex)", con);

                        cmd.Parameters.AddWithValue("@AgreementId", formData.AgreementID ?? string.Empty);
                        cmd.Parameters.AddWithValue("@DepositAmount", formData.TransactionAmount);
                        cmd.Parameters.AddWithValue("@DepositDate", formData.StartDate);
                        cmd.Parameters.AddWithValue("@ActiveFund", formData.TransactionAmount); // ActiveFund is the initial deposit
                        cmd.Parameters.AddWithValue("@RateOfInterestPerDay", rateOfInterestPerDay);
                        cmd.Parameters.AddWithValue("@Denomination", currentMonthName);
                    int dayOfMonth = formData.StartDate.Day;
                    cmd.Parameters.AddWithValue("@datex", dayOfMonth);

                    cmd.ExecuteNonQuery();
                    }
                }
            else
            {
                // Fetch the latest ActiveFund and DepositDate for the given AgreementId

                DataTable latestFundData = DB.returnDt(
                    " SELECT TOP 1 ActiveFund,RateOfInterestPerDay ,NumberOfDays,Status,[tradedata].[tradeadmin].[FundManagement].Profit,Denomination, datex,[tradedata].[tradeadmin].[aggrement].AgreementId,profitclient FROM tradedata.tradeadmin.FundManagement left join [tradedata].[tradeadmin].[aggrement] on "+
  " [tradedata].[tradeadmin].[aggrement].AgreementID = [tradedata].[tradeadmin].[FundManagement].AgreementId"+
 " WHERE [tradedata].[tradeadmin].[FundManagement].AgreementId = '" + formData.AgreementID + "'  ORDER BY [Id] DESC");

                DataTable prdt = DB.returnDt("select sum (ActiveFund) as activefund from tradedata.tradeadmin.FundManagement where AgreementId = '" + formData.AgreementID + "' and (Status = 'I' or Status ='D')");

                // Calculate the updated ActiveFund
                decimal existingActiveFund = Convert.ToDecimal(latestFundData.Rows[0]["ActiveFund"]);
                decimal newActiveFund = 0;
                decimal rti = Convert.ToDecimal(latestFundData.Rows[0]["RateOfInterestPerDay"]);
                decimal noof = Convert.ToDecimal(latestFundData.Rows[0]["NumberOfDays"]);
                string status = latestFundData.Rows[0]["Status"].ToString();
                decimal profit = Convert.ToDecimal(latestFundData.Rows[0]["Profit"]);
                string Deno = latestFundData.Rows[0]["Denomination"].ToString();
                decimal datex = Convert.ToDecimal(latestFundData.Rows[0]["datex"]);

                // got the difference of days 
                decimal dfr = daysInMonth - datex;
                int totaldays = ((formData.StartDate) - (formData.ExpireDate)).Days;
                // per day principal
                decimal prdy = Convert.ToDecimal(prdt.Rows[0]["ActiveFund"].ToString()) / totaldays;

                decimal prft = Decimal.Multiply(prdy, Decimal.Divide(rti, 100)); 
                // calculate the interest
                //     dailyProfitRate = (transactionAmount * monthlyProfitPercentage) / (daysInMonth * 100);

                decimal totpr = dfr * prft;

               
                using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(
                        "INSERT INTO tradedata.tradeadmin.FundManagement (AgreementId, DepositAmount, DepositDate, ActiveFund, RateOfInterestPerDay, NumberOfDays, Status, Profit, Denomination) " +
                        "VALUES (@AgreementId, @DepositAmount, @DepositDate, @ActiveFund, @RateOfInterestPerDay, @NumberOfDays, 'D', @Profit, @Denomination)", con);

                    cmd.Parameters.AddWithValue("@AgreementId", formData.AgreementID ?? string.Empty);
                    cmd.Parameters.AddWithValue("@DepositAmount", formData.TransactionAmount);
                    cmd.Parameters.AddWithValue("@DepositDate", formData.CurrentTransaction);
                    cmd.Parameters.AddWithValue("@ActiveFund", newActiveFund); // Updated ActiveFund
                    cmd.Parameters.AddWithValue("@RateOfInterestPerDay", rti);
                    cmd.Parameters.AddWithValue("@Denomination", currentMonthName);
                    cmd.Parameters.AddWithValue("@NumberOfDays", dfr);
               
                    cmd.Parameters.AddWithValue("@Profit", prft);




                    cmd.ExecuteNonQuery();
                }
            }

            return "Success";
        }
        catch (Exception ex)
        {
            // Log the error for debugging purposes
            System.Diagnostics.Debug.WriteLine(ex.Message);
            return ex.Message;
        }

    }


    [WebMethod]
    public static string GenerateNewAgreementID(string clientID)
    {
        string constr = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;

        if (string.IsNullOrEmpty(clientID) || clientID.Length < 5)
            return "Invalid Client ID";

        string clientSuffix = clientID.Substring(clientID.Length - 5); // Last 5 digits of ClientID
        string prefix = "AG" + clientSuffix;
        string newAgreementID = "";

        using (SqlConnection conn = new SqlConnection(constr))
        {
            conn.Open();

            // Insert a new record to get the auto-increment Id
            SqlCommand insertCmd = new SqlCommand(
                "INSERT INTO AgreementID (ClientID) OUTPUT INSERTED.Id VALUES (@ClientID)", conn);
            insertCmd.Parameters.AddWithValue("@ClientID", clientID);

            int newId = (int)insertCmd.ExecuteScalar(); // Get the auto-generated Id

            // Generate the AgreementID using the new Id
            newAgreementID = prefix + "_" + newId;

            // Update the AgreementID field
            SqlCommand updateCmd = new SqlCommand(
                "UPDATE AgreementID SET AgreementID = @AgreementID WHERE Id = @Id", conn);
            updateCmd.Parameters.AddWithValue("@AgreementID", newAgreementID);
            updateCmd.Parameters.AddWithValue("@Id", newId);
            updateCmd.ExecuteNonQuery();
        }
      
       

        return newAgreementID;
    }

    [WebMethod]
    public static string ExistingclientID(string clientID, DateTime currentTransactionDate)
    {
        // Connection string (replace with your actual connection string)
        string constr = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;

        // Query to fetch the latest AgreementID and its StartDate for the given ClientID
        string query = @"
    SELECT TOP 1 [AgreementID], [StartDate]
    FROM [tradedata].[tradeadmin].[aggrement]
    WHERE [ClientID] = @ClientID
    ORDER BY [CreatedDate] DESC"; // Ordering by CreatedDate in descending order to get the latest one

        string agreementID = "";
        DateTime? startDate = null;

        // Using SQL connection and command
        using (SqlConnection conn = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@ClientID", clientID);
                conn.Open();

                // Execute the query and fetch the result
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        agreementID = reader["AgreementID"].ToString();
                        startDate = reader["StartDate"] != DBNull.Value ? (DateTime)reader["StartDate"] : (DateTime?)null;
                    }
                }
            }
        }

        // Validation: Check if the current transaction date is in the next month relative to StartDate
        if (startDate.HasValue)
        {
            // Start of the month following the StartDate
            DateTime startOfNextMonth = new DateTime(startDate.Value.Year, startDate.Value.Month, 1).AddMonths(1);

            // If the currentTransactionDate is on or after the start of the next month, it's invalid
            if (currentTransactionDate >= startOfNextMonth)
            {
                return "Error: Current transaction cannot occur in or after the next month relative to the start date.";
            }
        }
        else
        {
            return "Error: No StartDate found for the given ClientID.";
        }

        return agreementID; // Return the latest AgreementID if validation passes
    }


    [WebMethod]
    public static AgreementDetailsx FetchAgreementDetails(string agreementID)
    {
        // Connection string (replace with your actual connection string)
        string constr = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;

        // Query to fetch the agreement details using AgreementID
        string query = @"
    SELECT 
        [StartDate], 
        [Term], 
        [expireDate],
        [TotalFund],
         [Priority]
    FROM [tradedata].[tradeadmin].[aggrement]
    WHERE [AgreementID] = @AgreementID";

        // Initialize the AgreementDetails object
        AgreementDetailsx agreementDetails = new AgreementDetailsx
        {
            StartDate = string.Empty,
            Term = string.Empty,
            ExpireDate = string.Empty,
            TotalFund = string.Empty,
            Priority = string.Empty
        };

        // Using SQL connection and command
        using (SqlConnection conn = new SqlConnection(constr))
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@AgreementID", agreementID);
                    conn.Open();

                    // Execute the query using SqlDataReader
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            // Read data from the reader
                            while (reader.Read())
                            {
                                agreementDetails.StartDate = reader["StartDate"] != DBNull.Value
                                    ? Convert.ToDateTime(reader["StartDate"]).ToString("yyyy-MM-dd")
                                    : string.Empty;

                                agreementDetails.Term = reader["Term"] != DBNull.Value
                                    ? reader["Term"].ToString()
                                    : string.Empty;

                                agreementDetails.ExpireDate = reader["ExpireDate"] != DBNull.Value
                                    ? Convert.ToDateTime(reader["ExpireDate"]).ToString("yyyy-MM-dd")
                                    : string.Empty;

                                agreementDetails.TotalFund = reader["TotalFund"] != DBNull.Value
                                   ? reader["TotalFund"].ToString()
                                   : string.Empty;

                                agreementDetails.Priority = reader["Priority"] != DBNull.Value
                                   ? reader["Priority"].ToString()
                                   : string.Empty;
                            }
                        }
                        else
                        {
                            // No rows found
                            throw new Exception("No data found for the given AgreementID.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log or handle the exception
                throw new Exception("Error fetching agreement details: " + ex.Message);
            }
        }

        return agreementDetails; // Return the details to the frontend
    }

    public class AgreementDetailsx
    {
        public string StartDate { get; set; }
        public string Term { get; set; }
        public string ExpireDate { get; set; }
        public string TotalFund { get; set; }
        public string Priority { get;  set; }
    }


    [WebMethod]
    public static object GetBankDetails(string clientId)
    {
        string constr = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(constr))
        {
            conn.Open();
            string query = "SELECT BankAccount, IFSC FROM [tradedata].[tradeadmin].[registrations] WHERE ClientId = @ClientId";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@ClientId", clientId);

            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                return new
                {
                    BankAccount = reader["BankAccount"] != DBNull.Value ? reader["BankAccount"].ToString() : "",
                    IFSC = reader["IFSC"] != DBNull.Value ? reader["IFSC"].ToString() : ""
                };
            }
        }

        return null; // Return null if no record is found
    }


}
