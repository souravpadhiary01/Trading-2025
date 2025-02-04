using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Configuration;
using System.Web.Services;

public partial class upload : System.Web.UI.Page
{
    private const string FtpFolder = "ftp://msksoftware.co.in/httpdocs/tradingdoc/";
    private const string FtpUsername = "mskuser";
    private const string FtpPassword = "Swadhin@#12";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Page initialization if needed
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
    public static string Insert(string Amount, string pic, string path, string ClientId)
    {
        try
        {
            // Upload files to FTP
            string picFilePath = string.Empty;

            if (!string.IsNullOrEmpty(pic) && !string.IsNullOrEmpty(path))
            {
                bool picUploaded = UploadFileToFtp(pic, path);
                if (picUploaded)
                {
                    picFilePath = "https://msksoftware.co.in/tradingdoc/" + path;
                }
                else
                {
                    return "Error: File upload failed.";
                }
            }

            // Database insertion logic
            string constr = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                string insertQuery = @"
INSERT INTO [tradedata].[tradeadmin].[upload] 
(Amount, MyDocPath, ClientId, status) 
VALUES 
(@Amount, @MyDocPath, @ClientId, 'pending')";


                using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                {
                    // Adding parameters to the query
                    cmd.Parameters.AddWithValue("@Amount", string.IsNullOrEmpty(Amount) ? "0" : Amount);
                    cmd.Parameters.AddWithValue("@MyDocPath", picFilePath);
                    cmd.Parameters.AddWithValue("@ClientId", string.IsNullOrEmpty(ClientId) ? "0" : ClientId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            return "Success";
        }
        catch (Exception ex)
        {
            Debug.WriteLine("Insertion failed: " + ex.Message);
            return "Error: " + ex.Message;
        }
    }

}
