using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Web.Script.Services;
using System.Web.Services;

public partial class teammonth : System.Web.UI.Page
{
    // FTP configuration
    private const string FtpFolder = "ftp://msksoftware.co.in/httpdocs/forestdoc/";
    private const string FtpUsername = "mskuser";
    private const string FtpPassword = "Swadhin@#12";
    private static readonly string ConnectionString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string InsertInvestor(InvestorData data)
    {
        if (data == null || string.IsNullOrEmpty(data.picfile) || string.IsNullOrEmpty(data.pathfile))
        {
            return "File data or file name is missing.";
        }

        try
        {
            // Upload file to FTP
            string filePath = UploadFileToFtp(data.picfile, data.pathfile);
            if (filePath == null)
            {
                return "File upload failed.";
            }

            // Insert data into the database
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                string query = @"
                INSERT INTO teamtransction 
                (membername, memberid, transctionamount, transctiontype, transctionby, phato, remark) 
                VALUES 
                (@membername, @memberid, @transctionamount, @transctiontype, @transctionby, @phato, @remark)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Bind parameters to prevent SQL injection
                    command.Parameters.AddWithValue("@membername", data.name ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@memberid", data.memberid ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@transctionamount", data.transctionamount ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@transctiontype", data.transctiontype ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@transctionby", data.transctionby ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@remark", data.remark ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@phato", filePath); // File path from FTP upload
                    
                    command.ExecuteNonQuery();
                }
            }

            return "Investor data inserted successfully.";
        }
        catch (SqlException ex)
        {
            Debug.WriteLine("SQL Error: " + ex.Message);
            return "Database error: " + ex.Message;
        }
        catch (Exception ex)
        {
            Debug.WriteLine("Error inserting investor data: " + ex.Message);
            return "Error: " + ex.Message;
        }
    }
    private static string UploadFileToFtp(string base64Data, string fileName)
    {
        if (string.IsNullOrEmpty(base64Data) || string.IsNullOrEmpty(fileName))
        {
            Debug.WriteLine("Base64 data or file name is missing.");
            return null;
        }

        try
        {
            string[] dataParts = base64Data.Split(',');
            if (dataParts.Length < 2)
            {
                Debug.WriteLine("Invalid Base64 data format.");
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
            request.EnableSsl = false;

            using (Stream requestStream = request.GetRequestStream())
            {
                requestStream.Write(fileBytes, 0, fileBytes.Length);
            }

            using (FtpWebResponse response = (FtpWebResponse)request.GetResponse())
            {
                if (response.StatusCode == FtpStatusCode.ClosingData)
                {
                    Debug.WriteLine("File uploaded successfully: " + fileName);
                    return "https://msksoftware.co.in/forestdoc/" + fileName;
                }
                else
                {
                    Debug.WriteLine("FTP upload failed with status: " + response.StatusDescription);
                    return null;
                }
            }
        }
        catch (Exception ex)
        {
            Debug.WriteLine("FTP upload failed: " + ex.Message);
            return null;
        }
    }

    public class InvestorData
    {
        public string name { get; set; } // Matches "name" column
        public string memberid { get; set; } // Matches "memberid" column
        public string transctionamount { get; set; } // Matches "amount" column
        public string transctiontype { get; set; } // Matches "type" column
        public string transctionby { get; set; } // Matches "transctionby" column
        public string remark { get; set; } // Matches "remark" column
        public string picfile { get; set; } // Base64 file data
        public string pathfile { get; set; } // File name (to be used for "filePath" column)
    }


}
