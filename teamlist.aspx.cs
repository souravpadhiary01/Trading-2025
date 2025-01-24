using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class teamlist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public class TeamDetails
    {
       
        public string MemberID { get; set; }
        public string MemberName { get; set; }
        public string Joining { get; set; }
        public int NoOfClients { get; set; }
        public string Priority { get; set; }
        public double ClientFunds { get; set; }
        public double ClientProfits { get; set; }
        public string Action { get; set; }

        // Constructor to initialize default values
        public TeamDetails()
        {
            NoOfClients = 0;
            ClientFunds = 0.0;
            ClientProfits = 0.0;
            Action = "View/Edit";
        }
    }

    [WebMethod]
    public static List<TeamDetails> GetTeamList()
    {
        List<TeamDetails> teamList = new List<TeamDetails>();
        string connectionString = ConfigurationManager.ConnectionStrings["tradedata"].ConnectionString;
        string query = "SELECT [memberid], [ClientName], [JoiningDate], [Priority] FROM [tradedata].[tradeadmin].[registrationsx]";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand(query, connection);
            connection.Open();

            using (SqlDataReader reader = cmd.ExecuteReader())
            {
               
                while (reader.Read())
                {
                    teamList.Add(new TeamDetails
                    {
                        
                        MemberID = reader["memberid"].ToString(),
                        MemberName = reader["ClientName"].ToString(),
                        Joining = Convert.ToDateTime(reader["JoiningDate"]).ToString("dd/MM/yyyy"),
                        Priority = reader["Priority"].ToString()
                    });
                }
            }
        }

        return teamList;
    }
}