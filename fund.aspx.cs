using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class fund : System.Web.UI.Page
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






    public class AgreementData
    {
        public string TID { get; set; }
        public string ClientName { get; set; }
        public decimal Capital { get; set; }
        public string Term { get; set; }
        public string RefBy { get; set; }
    
      
    }
   
    [WebMethod]
    public static List<AgreementData> GetAgreementData()
    {
        List<AgreementData> agreementDataList = new List<AgreementData>();

        string connString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;


        string query = @"SELECT  [ClientName], [tid], [TotalFund], 
                         [refer], [term]
                         FROM [tradedata].[tradeadmin].[aggrement] where [Agreementdocument] = 'Pending'";

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
                            TID = reader["tid"].ToString(),
                            Capital = reader["TotalFund"] != DBNull.Value ? Convert.ToDecimal(reader["TotalFund"]) : 0,
                            RefBy = reader["refer"].ToString(),
                            Term = reader["term"].ToString(),
                           
                        };

                        agreementDataList.Add(data);
                    }
                }
            }
        }

        return agreementDataList;
    }

    [WebMethod]
    public static string UploadFile(string tid, string base64Data, string fileName)
    {
        try
        {
            // Validate inputs
            if (string.IsNullOrEmpty(tid) || string.IsNullOrEmpty(base64Data) || string.IsNullOrEmpty(fileName))
            {
                return "Error: Missing required data.";
            }

            // Decode Base64 file data
            byte[] fileBytes = Convert.FromBase64String(base64Data);

            // FTP file path
            string ftpFilePath = string.Format("{0}{1}", FtpFolder, fileName);

            // Upload file to FTP
            FtpWebRequest request = (FtpWebRequest)WebRequest.Create(ftpFilePath);
            request.Method = WebRequestMethods.Ftp.UploadFile;
            request.Credentials = new NetworkCredential(FtpUsername, FtpPassword);
            request.UseBinary = true;
            request.UsePassive = true;

            // Write file to FTP server
            using (Stream requestStream = request.GetRequestStream())
            {
                requestStream.Write(fileBytes, 0, fileBytes.Length);
            }

            // Confirm file upload
            using (FtpWebResponse response = (FtpWebResponse)request.GetResponse())
            {
                if (response.StatusCode != FtpStatusCode.ClosingData)
                {
                    return string.Format("Error uploading file: {0}", response.StatusDescription);
                }
            }

            // File successfully uploaded, save path in the database
            string filePathInDatabase = string.Format("https://msksoftware.co.in/tradingdoc/{0}", fileName);

            string constr = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                const string query = @"
                UPDATE [tradedata].[tradeadmin].[aggrement]
                SET aggdoc = @FilePath,[Agreementdocument] ='success'
                WHERE tid = @TID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FilePath", filePathInDatabase);
                    cmd.Parameters.AddWithValue("@TID", tid);

                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        return "Success";
                    }
                    else
                    {
                        return "Error: TID not found.";
                    }
                }
            }
        }
        catch (WebException ex)
        {
            FtpWebResponse response = ex.Response as FtpWebResponse;
            string errorMessage = response != null ? response.StatusDescription : ex.Message;
            System.Diagnostics.Debug.WriteLine(string.Format("FTP Upload failed: {0}", errorMessage));
            return string.Format("Error: {0}", errorMessage);
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.Message);
            return string.Format("Error: {0}", ex.Message);
        }
    }

}