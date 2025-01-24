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

using System.Drawing;
using System.Web.UI.HtmlControls;

using System.Reflection;

using System.Threading;
using System.Threading.Tasks;

using System.Web.Script.Services;
using System.IdentityModel.Protocols.WSTrust;

public partial class Transaction : System.Web.UI.Page
{
    private const string FtpFolder = "ftp://msksoftware.co.in/httpdocs/forestdoc/";
    private const string FtpUsername = "mskuser";
    private const string FtpPassword = "Swadhin@#12";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Initialize page if needed
        }
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



    [WebMethod(EnableSession = true)]
    public static string Insert(
     string clientName, string mobileNo, string joiningDate,
     string whatsappNo, string emailId, string referBy,
     string priority, string address, string Status, string clientId,
     string passwordx, string bankAccount, string IFSC, string adhaarNumber,
     string nomineeName, string whatsappNotification,
     string msgNotification, string emailNotification,
     string pic, string path, string picx, string pathx,
     string picy, string pathy, string picz, string pathz,string place)
    {
        try
        {
            // Check for existing ClientId
            string constr = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                const string checkQuery = "SELECT COUNT(*) FROM [tradedata].[tradeadmin].[registrations] WHERE ClientId = @ClientId";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                {
                    checkCmd.Parameters.AddWithValue("@ClientId", clientId);

                    con.Open();
                    int count = (int)checkCmd.ExecuteScalar();
                    con.Close();

                    if (count > 0)
                    {
                        return "Error: Client ID already exists.";
                    }
                }
            }

            // Prepare file paths
            string PhotoPath = string.Empty;
            string AadhrPath = string.Empty;
            string BankDtlPath = string.Empty;
            string PanPath = string.Empty;

            string baseUrl = "https://msksoftware.co.in/forestdoc/";

            // Upload files
            if (!string.IsNullOrEmpty(pic) && !string.IsNullOrEmpty(path))
            {
                if (UploadFileToFtp(pic, path))
                    PhotoPath = baseUrl + path;
                else
                    return "Error: Photo upload failed for " + path;
            }
            if (!string.IsNullOrEmpty(picx) && !string.IsNullOrEmpty(pathx))
            {
                if (UploadFileToFtp(picx, pathx))
                    AadhrPath = baseUrl + pathx;
                else
                    return "Error: Aadhaar upload failed for " + pathx;
            }
            if (!string.IsNullOrEmpty(picy) && !string.IsNullOrEmpty(pathy))
            {
                if (UploadFileToFtp(picy, pathy))
                    BankDtlPath = baseUrl + pathy;
                else
                    return "Error: Bank details upload failed for " + pathy;
            }
            if (!string.IsNullOrEmpty(picz) && !string.IsNullOrEmpty(pathz))
            {
                if (UploadFileToFtp(picz, pathz))
                    PanPath = baseUrl + pathz;
                else
                    return "Error: PAN upload failed for " + pathz;
            }

            // Insert data into database
            using (SqlConnection con = new SqlConnection(constr))
            {
                const string insertQuery = @"
            INSERT INTO [tradedata].[tradeadmin].[registrations] 
            (ClientName, MobileNo, JoiningDate, WhatsappNo, EmailId, 
            ReferBy, Priority, Address, Status, ClientId, Password, 
            BankAccount, IFSC, AdhaarNumber, NomineeName, WhatsappNotification, 
            MsgNotification, EmailNotification, MyDocPath, AadhrPath, 
            PanPath, BankDtlPath,place) 
            VALUES 
            (@ClientName, @MobileNo, @JoiningDate, @WhatsappNo, @EmailId,
            @ReferBy, @Priority, @Address, @Status, @ClientId, @Password,
            @BankAccount, @IFSC, @AdhaarNumber, @NomineeName, @WhatsappNotification,
            @MsgNotification, @EmailNotification, @MyDocPath, @AadhrPath,
            @PanPath, @BankDtlPath,@place)";

                using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                {
                    // Add parameters with null checking
                    cmd.Parameters.AddWithValue("@ClientName", clientName ?? string.Empty);
                    cmd.Parameters.AddWithValue("@MobileNo", mobileNo ?? string.Empty);
                    cmd.Parameters.AddWithValue("@JoiningDate", joiningDate ?? string.Empty);
                    cmd.Parameters.AddWithValue("@WhatsappNo", whatsappNo ?? string.Empty);
                    cmd.Parameters.AddWithValue("@EmailId", emailId ?? string.Empty);
                    cmd.Parameters.AddWithValue("@ReferBy", referBy ?? string.Empty);
                    cmd.Parameters.AddWithValue("@Priority", priority ?? string.Empty);
                    cmd.Parameters.AddWithValue("@Address", address ?? string.Empty);
                    cmd.Parameters.AddWithValue("@Status", Status ?? string.Empty);
                    cmd.Parameters.AddWithValue("@ClientId", clientId ?? string.Empty);
                    cmd.Parameters.AddWithValue("@Password", passwordx ?? string.Empty);
                    cmd.Parameters.AddWithValue("@BankAccount", bankAccount ?? string.Empty);
                    cmd.Parameters.AddWithValue("@IFSC", IFSC ?? string.Empty);
                    cmd.Parameters.AddWithValue("@AdhaarNumber", adhaarNumber ?? string.Empty);
                    cmd.Parameters.AddWithValue("@NomineeName", nomineeName ?? string.Empty);
                    cmd.Parameters.AddWithValue("@WhatsappNotification", whatsappNotification ?? string.Empty);
                    cmd.Parameters.AddWithValue("@MsgNotification", msgNotification ?? string.Empty);
                    cmd.Parameters.AddWithValue("@EmailNotification", emailNotification ?? string.Empty);
                    cmd.Parameters.AddWithValue("@MyDocPath", PhotoPath);
                    cmd.Parameters.AddWithValue("@AadhrPath", AadhrPath);
                    cmd.Parameters.AddWithValue("@PanPath", PanPath);
                    cmd.Parameters.AddWithValue("@BankDtlPath", BankDtlPath);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            return "Success";
        }
        catch (Exception ex)
        {
         
            System.Diagnostics.Debug.WriteLine("Registration failed: " + ex.Message);
            return "Error: " + ex.Message;

        }
    }


}