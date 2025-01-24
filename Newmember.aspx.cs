using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Web.Services;
using System.Web.Script.Services;

public partial class Newmember : System.Web.UI.Page
{


    private const string FtpFolder = "ftp://msksoftware.co.in/httpdocs/forestdoc/";
    private const string FtpUsername = "mskuser";
    private const string FtpPassword = "Swadhin@#12";
    private static readonly string ConnectionString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string InsertInvestor(InvestorData data)
    {
        try
        {
            // Validate required fields
            if (string.IsNullOrWhiteSpace(data.clientId) ||
                string.IsNullOrWhiteSpace(data.mobileNo) ||
                string.IsNullOrWhiteSpace(data.joiningDate) ||
                string.IsNullOrWhiteSpace(data.password))
            {
                return "Required fields are missing.";
            }

            // Upload files to FTP
            string adhaarPath = UploadFileToFtp(data.picAdhaar, data.pathAdhaar);
            string photoPath = UploadFileToFtp(data.picPhoto, data.pathPhoto);
            string bankDocPath = UploadFileToFtp(data.picBank, data.pathBank);

            // Insert data into database
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                string query = @"
                    INSERT INTO registrationsx 
                    (ClientID, ClientName, MobileNo, JoiningDate, WhatsappNo, EmailId, 
                    Priority, Address, MemberID, Password, BankAccount, IFSC, 
                    AdhaarNumber, NomineeName, Place, WhatsappNotification, 
                    MsgNotification, EmailNotification, AadhrPath, MyDocPath, BankDtlPath)
                    VALUES 
                    (@ClientID, @ClientName, @MobileNo, @JoiningDate, @WhatsappNo, @EmailId, 
                    @Priority, @Address, @MemberID, @Password, @BankAccount, @IFSC, 
                    @AdhaarNumber, @NomineeName, @Place, @WhatsappNotification, 
                    @MsgNotification, @EmailNotification, @AadhrPath, @MyDocPath, @BankDtlPath)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ClientID", data.clientId);
                    command.Parameters.AddWithValue("@ClientName", data.clientname);
                    command.Parameters.AddWithValue("@MobileNo", data.mobileNo);
                    command.Parameters.AddWithValue("@JoiningDate", Convert.ToDateTime(data.joiningDate));
                    command.Parameters.AddWithValue("@WhatsappNo", string.IsNullOrWhiteSpace(data.whatsappNo) ? (object)DBNull.Value : data.whatsappNo);
                    command.Parameters.AddWithValue("@EmailId", string.IsNullOrWhiteSpace(data.emailId) ? (object)DBNull.Value : data.emailId);
                    command.Parameters.AddWithValue("@Priority", data.priority);
                    command.Parameters.AddWithValue("@Address", string.IsNullOrWhiteSpace(data.address) ? (object)DBNull.Value : data.address);
                    command.Parameters.AddWithValue("@MemberID", string.IsNullOrWhiteSpace(data.memberId) ? (object)DBNull.Value : data.memberId);
                    command.Parameters.AddWithValue("@Password", data.password);
                    command.Parameters.AddWithValue("@BankAccount", string.IsNullOrWhiteSpace(data.bankAccount) ? (object)DBNull.Value : data.bankAccount);
                    command.Parameters.AddWithValue("@IFSC", string.IsNullOrWhiteSpace(data.IFSC) ? (object)DBNull.Value : data.IFSC);
                    command.Parameters.AddWithValue("@AdhaarNumber", string.IsNullOrWhiteSpace(data.adhaarNumber) ? (object)DBNull.Value : data.adhaarNumber);
                    command.Parameters.AddWithValue("@NomineeName", string.IsNullOrWhiteSpace(data.nomineeName) ? (object)DBNull.Value : data.nomineeName);
                    command.Parameters.AddWithValue("@Place", string.IsNullOrWhiteSpace(data.place) ? (object)DBNull.Value : data.place);
                    command.Parameters.AddWithValue("@WhatsappNotification", data.whatsappNotification); // Pass boolean directly
                    command.Parameters.AddWithValue("@MsgNotification", data.msgNotification); // Pass boolean directly
                    command.Parameters.AddWithValue("@EmailNotification", data.emailNotification); // Pass boolean directly
                    command.Parameters.AddWithValue("@AadhrPath", adhaarPath ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@MyDocPath", photoPath ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@BankDtlPath", bankDocPath ?? (object)DBNull.Value);

                    command.ExecuteNonQuery();
                }
            }

            return "Investor added successfully";
        }
        catch (Exception ex)
        {
            // Log the full exception details
            System.Diagnostics.Debug.WriteLine("Error inserting investor: {ex}");
            return "Error: {ex.Message}";
        }
    }

    private static string UploadFileToFtp(string base64Data, string fileName)
    {
        if (string.IsNullOrEmpty(base64Data) || string.IsNullOrEmpty(fileName))
        {
            return null;
        }

        try
        {
            string[] dataParts = base64Data.Split(',');
            if (dataParts.Length < 2)
            {
                return null;
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
                return response.StatusCode == FtpStatusCode.ClosingData ? "https://msksoftware.co.in/forestdoc/" + fileName : null;
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("FTP upload failed: " + ex.Message);
            return null;
        }
    }

    // Data transfer object for investor information
    public class InvestorData
    {
        public string clientId { get; set; }
        public string clientname { get; set; }
        public string mobileNo { get; set; }
        public string joiningDate { get; set; }
        public string whatsappNo { get; set; }
        public string emailId { get; set; }
        public string priority { get; set; }
        public string address { get; set; }
        public string memberId { get; set; }
        public string password { get; set; }
        public string bankAccount { get; set; }
        public string IFSC { get; set; }
        public string adhaarNumber { get; set; }
        public string nomineeName { get; set; }
        public string place { get; set; }
        public bool whatsappNotification { get; set; }
        public bool msgNotification { get; set; }
        public bool emailNotification { get; set; }
        public string picAdhaar { get; set; }
        public string pathAdhaar { get; set; }
        public string picPhoto { get; set; }
        public string pathPhoto { get; set; }
        public string picBank { get; set; }
        public string pathBank { get; set; }
    }

    [WebMethod]
    public static string GetClientName(string clientId)
    {
        try
        {
            string constr = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;

            using (SqlConnection con = new SqlConnection(constr))
            {
                string query = "SELECT ClientName FROM registrationsx WHERE ClientID = @ClientID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ClientID", clientId);
                    con.Open();

                    object result = cmd.ExecuteScalar();
                    return result != null ? result.ToString() : null;
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error fetching client name: " + ex.Message);
            return null;
        }
    }


}
