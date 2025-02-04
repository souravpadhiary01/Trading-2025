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


public partial class Member : System.Web.UI.Page

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
    public static string Insertxx(
    string clientId, string MemberName, string joiningDate, string mobileNo, string whatsappNo,
    string EmailId, string Priority, string Address, string MemberId, string Password,
    string bankAccount, string adhaarNumber, string Commission, string Nominne,
    string pic, string path, string picx, string pathx, string picy, string pathy)
    {
        try
        {
            // Prepare file paths
            string PhotoPath = string.Empty;
            string AadhrPath = string.Empty;
            string BankDtlPath = string.Empty;

            // Upload PhotoPath
            if (!string.IsNullOrEmpty(pic) && !string.IsNullOrEmpty(path))
            {
                bool isPhotoUploaded = UploadFileToFtp(pic, path);
                if (isPhotoUploaded)
                {
                    PhotoPath = "https://msksoftware.co.in/tradingdoc/" + path;
                }
                else
                {
                    return "Error: Photo upload failed.";
                }
            }

            // Upload AadhrPath
            if (!string.IsNullOrEmpty(picx) && !string.IsNullOrEmpty(pathx))
            {
                bool isAadharUploaded = UploadFileToFtp(picx, pathx);
                if (isAadharUploaded)
                {
                    AadhrPath = "https://msksoftware.co.in/tradingdoc/" + pathx;
                }
                else
                {
                    return "Error: Aadhaar upload failed.";
                }
            }

            // Upload BankDtlPath
            if (!string.IsNullOrEmpty(picy) && !string.IsNullOrEmpty(pathy))
            {
                bool isBankDetailsUploaded = UploadFileToFtp(picy, pathy);
                if (isBankDetailsUploaded)
                {
                    BankDtlPath = "https://msksoftware.co.in/tradingdoc/" + pathy;
                }
                else
                {
                    return "Error: Bank details upload failed.";
                }
            }

            // Database connection string
            string constr = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;

            // Insert into database
            using (SqlConnection con = new SqlConnection(constr))
            {
                const string insertQuery = @"
                INSERT INTO [tradedata].[tradeadmin].[membersxy] 
                (clientId, MemberName, joiningDate, mobileNo, whatsappNo, EmailId,
                 Priority, Address, MemberId, Password, bankAccount, adhaarNumber,
                 Commission, Nominee, PhotoPath, AadhrPath, BankDtlPath) 
                VALUES 
                (@clientId, @MemberName, @joiningDate, @mobileNo, @whatsappNo, @EmailId,
                 @Priority, @Address, @MemberId, @Password, @bankAccount, @adhaarNumber,
                 @Commission, @Nominee, @PhotoPath, @AadhrPath, @BankDtlPath)";

                using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                {
                    cmd.Parameters.AddWithValue("@clientId", clientId);
                    cmd.Parameters.AddWithValue("@MemberName", string.IsNullOrEmpty(MemberName) ? string.Empty : MemberName);
                    cmd.Parameters.AddWithValue("@joiningDate", string.IsNullOrEmpty(joiningDate) ? DBNull.Value : (object)joiningDate);
                    cmd.Parameters.AddWithValue("@mobileNo", string.IsNullOrEmpty(mobileNo) ? string.Empty : mobileNo);
                    cmd.Parameters.AddWithValue("@whatsappNo", string.IsNullOrEmpty(whatsappNo) ? string.Empty : whatsappNo);
                    cmd.Parameters.AddWithValue("@EmailId", string.IsNullOrEmpty(EmailId) ? string.Empty : EmailId);
                    cmd.Parameters.AddWithValue("@Priority", string.IsNullOrEmpty(Priority) ? string.Empty : Priority);
                    cmd.Parameters.AddWithValue("@Address", string.IsNullOrEmpty(Address) ? string.Empty : Address);
                    cmd.Parameters.AddWithValue("@MemberId", string.IsNullOrEmpty(MemberId) ? string.Empty : MemberId);
                    cmd.Parameters.AddWithValue("@Password", string.IsNullOrEmpty(Password) ? string.Empty : Password);
                    cmd.Parameters.AddWithValue("@bankAccount", string.IsNullOrEmpty(bankAccount) ? string.Empty : bankAccount);
                    cmd.Parameters.AddWithValue("@adhaarNumber", string.IsNullOrEmpty(adhaarNumber) ? string.Empty : adhaarNumber);
                    cmd.Parameters.AddWithValue("@Commission", string.IsNullOrEmpty(Commission) ? string.Empty : Commission);
                    cmd.Parameters.AddWithValue("@Nominee", string.IsNullOrEmpty(Nominne) ? string.Empty : Nominne);
                    cmd.Parameters.AddWithValue("@PhotoPath", PhotoPath);
                    cmd.Parameters.AddWithValue("@AadhrPath", AadhrPath);
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