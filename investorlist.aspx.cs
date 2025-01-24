using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Linq;

public partial class investorlist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static object GetClientData()
    {
        List<ClientData> dataList = new List<ClientData>();

        // Use the ClientDataService to get data
        using (ClientDataService service = new ClientDataService())
        {
            // Fetch data from the service
            dataList = service.GetClientData().ToList();
        }

        // Return the data to the client-side
        return new { data = dataList };
    }
   
    public class ClientDataService : IDisposable
    {
        private readonly SqlConnection _connection;

        public ClientDataService()
        {
            // Retrieve the connection string from Web.config or App.config
            string connString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;
            _connection = new SqlConnection(connString);
        }

        public IEnumerable<ClientData> GetClientData()
        {
            try
            {
                _connection.Open();
                string query = "SELECT  Id, ClientId, ClientName, JoiningDate, MobileNo, Status, Address, ReferBy, MyDocPath FROM tradedata.tradeadmin.registrations";

                using (SqlCommand cmd = new SqlCommand(query, _connection))
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        yield return new ClientData
                        {
                            Id = Convert.ToInt32(reader["Id"]),
                            ClientId = reader["ClientId"].ToString(),
                            ClientName = reader["ClientName"].ToString(),
                            JoiningDate = Convert.ToDateTime(reader["JoiningDate"]).ToString("dd/MM/yyyy"),
                            Mobile = reader["MobileNo"].ToString(),
                            Status = reader["Status"].ToString(),
                            Place = reader["Address"].ToString(),
                            ReferBy = reader["ReferBy"].ToString(),
                            ActiveDocuments = reader["MyDocPath"].ToString()
                        };
                    }
                }
            }
            finally
            {
                _connection.Close();
            }
        }

        public void Dispose()
        {
            if (_connection != null)
            {
                _connection.Dispose(); // Dispose of the SqlConnection
            }

            // Manually suppress finalization (for older versions of C#)
            System.GC.SuppressFinalize(this);
        }
    }

    public class ClientData : IDisposable
    {
        public int Id { get; set; }
        public string ClientId { get; set; }
        public string ClientName { get; set; }
        public string JoiningDate { get; set; }
        public string Mobile { get; set; }
        public string Status { get; set; }
        public string Place { get; set; }
        public string ReferBy { get; set; }
        public string ActiveDocuments { get; set; }

        // Implement IDisposable to manage resources
        public void Dispose()
        {
            // Clean up any unmanaged resources if needed
            GC.SuppressFinalize(this);
        }
    }
}
