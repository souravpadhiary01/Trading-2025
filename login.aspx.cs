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

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Iterate through the header controls and hide them
            foreach (Control control in Page.Header.Controls)
            {
                // Attempt to cast the control to HtmlControl
                System.Web.UI.HtmlControls.HtmlControl htmlControl = control as System.Web.UI.HtmlControls.HtmlControl;

                if (htmlControl != null)
                {
                    // Check for <link> elements
                    if (htmlControl.TagName != null && htmlControl.TagName.Equals("link", StringComparison.OrdinalIgnoreCase))
                    {
                        htmlControl.Visible = false;
                    }
                    // Check for <script> elements
                    else if (htmlControl.TagName != null && htmlControl.TagName.Equals("script", StringComparison.OrdinalIgnoreCase))
                    {
                        htmlControl.Visible = false;
                    }
                }
            }
        }
        // Page initialization logic
    }

    [WebMethod(EnableSession = true)]
    public static string user( User data)
    {
        // Validate input
        if (string.IsNullOrEmpty(data.UserID) || string.IsNullOrEmpty(data.Password))
        {
            return "Both UserID and Password are required.";
        }

        // Connection string from Web.config
        string constr = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;

        try
        {
           
            DATABASE db = new DATABASE();

            DataTable dt = db.returnDt("SELECT ClientId,Password FROM tradeadmin.registrations WHERE ClientId = '"+data.UserID+ "' AND Password = '" + data.Password + "'");

            if (dt.Rows.Count > 0)
            {
                HttpCookie cookie = new HttpCookie("usrid")
                {
                    Value = dt.Rows[0]["ClientId"].ToString(),
                Expires = DateTime.Now.AddDays(30) // Set the expiration date
                };

                // Add the cookie to the response
                HttpContext.Current.Response.Cookies.Add(cookie);
                return dt.Rows[0]["ClientId"].ToString();
            }
            else
            {
                return "not found";
            }
        }
        catch (Exception ex)
        {
            return "{ex.Message}";
        }
    }
}

// Define the User class for the JSON data structure
public class User : IDisposable
{
    public string UserID { get; set; }
    public string Password { get; set; }

    public void Dispose()
    {
        // Release unmanaged resources here if any (e.g., file handles, network connections)
        GC.SuppressFinalize(this); // Suppress finalization for this instance
    }
}
