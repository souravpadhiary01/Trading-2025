using System;
using System.Collections.Generic;
using System.Linq;
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
using AjaxControlToolkit;
using System.Drawing;
using System.Web.UI.HtmlControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.Reflection;
using Razorpay.Api;
using System.Threading;
using System.Threading.Tasks;
using Newtonsoft.Json;
using ClosedXML.Excel;
using System.Web.Script.Services;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.ComponentModel.ToolboxItem(false)]
[System.Web.Script.Services.ScriptService]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{

    public WebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string YourWebMethod(List<RootObject> rootObjects)
    {
        foreach (var rootObject in rootObjects)
        {
            // Access DataDyna list
            List<DikshitDTO> dataDynaList = rootObject.DataDyna;

            // Access Datadina list
            List<EducationDTO> datadinaList = rootObject.Datadina;

            // Perform your operations here
            // For example, you can log or process the data
        }

        return "ok"; // Optionally, send a response back to the client
       // Context.Response.Write(new JavaScriptSerializer().Serialize(new { success = true }));
    }

    public class RootObject
    {
        public List<DikshitDTO> DataDyna { get; set; }
        public List<EducationDTO> Datadina { get; set; }
    }

    public class DikshitDTO
    {
        public string Property1 { get; set; }
        public string Property2 { get; set; }
    }

    public class EducationDTO
    {
        public string PropertyA { get; set; }
        public string PropertyB { get; set; }
    }
}
