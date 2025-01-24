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
using System.Web.Script.Serialization;
using System.Globalization;





/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.ComponentModel.ToolboxItem(false)]
[ScriptService]
public class WebService1 : System.Web.Services.WebService
{
    private static TimeZoneInfo India_Standard_Time = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string YourWebMethod(List<RootObject> rootObjects)
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
        return "ok";
        // Optionally, send a response back to the client
        // Context.Response.Write(new JavaScriptSerializer().Serialize(new { success = true }));
    }


    //public WebService1()
    //{

    //    //Uncomment the following line if using designed components 
    //    //InitializeComponent(); 
    //}

    [WebMethod]
    public string[] GetCustomers(string prefix)
    {
        List<string> customers = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["constr"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select MemberId, Name from FamilyHierarchy where " +
                "Name like @SearchText + '%'";
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}-{1}", sdr["Name"], sdr["MemberId"]));
                    }
                }
                conn.Close();
            }
            return customers.ToArray();
        }
    }



    [WebMethod]
    public string GenerateUniqueCode(int userId)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;
        string generatedCode = "";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            SqlCommand command = new SqlCommand("AddUniqueCodex", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add(new SqlParameter("@UserId", userId));
            SqlParameter outputParam = new SqlParameter("@Code", SqlDbType.NVarChar, 10)
            {
                Direction = ParameterDirection.Output
            };
            command.Parameters.Add(outputParam);
            connection.Open();
            command.ExecuteNonQuery();
            generatedCode = outputParam.Value.ToString();
            connection.Close();
        }

    //  return generatedCode.ToUpper();
          return generatedCode;
    }


    [WebMethod]
    // [System.Web.Services.WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<CaseData> GetAutoCompleteData()
    {
        List<CaseData> services = new List<CaseData>();

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT * FROM[satsangdata].[satsangadmin].[UniqueCodes]";

                cmd.Connection = conn;

                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        services.Add(new CaseData
                        {

                            Id = sdr["Id"].ToString(),
                            Code = sdr["Code"].ToString(),
                            UserId = sdr["UserId"].ToString(),
                            CreatedAt = sdr["CreatedAt"].ToString()
                        });
                    }
                }
            }
        }

        return services;
    }


    [WebMethod]
    // [System.Web.Services.WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<kendraData> GetAutoCompleteData33()
    {
        List<kendraData> services = new List<kendraData>();

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT * FROM[satsangdata].[satsangadmin].[kendra_tbl]";

                cmd.Connection = conn;

                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        services.Add(new kendraData
                        {

                            Id = sdr["Id"].ToString(),
                            Code = sdr["kendranm"].ToString()

                        });
                    }
                }
            }
        }

        return services;
    }


    [WebMethod]
    // [System.Web.Services.WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<staffData> GetAutoCompleteData334()
    {
        List<staffData> services = new List<staffData>();

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT id,fnm+' '+lnm as name FROM[satsangdata].[satsangadmin].[staff_tbl]";

                cmd.Connection = conn;

                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        services.Add(new staffData
                        {

                            Id = sdr["id"].ToString(),
                            Name = sdr["name"].ToString()

                        });
                    }
                }
            }
        }

        return services;
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<BookedSeat> GetBookedSeats(string busNumber)
    {
        List<BookedSeat> bookedSeats = new List<BookedSeat>();
        string connectionString = ConfigurationManager.ConnectionStrings["BusManagementDB"].ConnectionString;

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT [SeatNumber] FROM [dbo].[Bookings] WHERE [BusNumber] = @BusNumber";

            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@BusNumber", busNumber);
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        BookedSeat seat = new BookedSeat
                        {
                            SeatNumber = reader["SeatNumber"].ToString()
                        };
                        bookedSeats.Add(seat);
                    }
                }
            }
        }

        return bookedSeats;
    }


    [WebMethod]

    public string[] GetBuses(string trcx)
    {


        SqlConnection con1 = new SqlConnection();

        DATABASE DB = new DATABASE();
        //  DataTable gh = DB.returnDt("select * from tbl_regsa");
        //string sql = "insert into tbl_cat (catname) values ('" + name + "')";
        //con1 = DB.getCon();
        //SqlCommand cmmds = new SqlCommand(sql, con1); name,email,mob,adhaar,service,serid,addr,city,pin,pass
        //DB.ExecQry(cmmds);

        List<string> countries = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                //  cmd.CommandText = "   select MonthlyPayments.Mobile,Month ,EMI,PrincipalComponent,InterestComponent,RemainingBalance FROM MonthlyPayments join CustomerLoanInfo on CustomerLoanInfo.Mobile=MonthlyPayments.mobile where MonthlyPayments.mobile like '%' + @trcx +'%' ";                //cmd.CommandText = " select sum(mtch) as mt, name,mob,bnk,brn,accno,ifsc,acrfid,tbl_regsx.memid from  tbl_regsx inner join tbl_mtchpr on cast(tbl_mtchpr.memid as numeric(18,0)) = tbl_regsx.memid where (fls_sts='D' and tbl_regsx.kyc_sts='Pending' or tbl_regsx.kyc_sts='Done') and CONVERT(varchar, tbl_mtchpr.cdt, 101) = '05/17/2024' group by name,mob,bnk,brn,accno,ifsc,acrfid,tbl_regsx.memid";
                cmd.CommandText = "select BusName,BusNumber,DepartureTime,ArrivalTime from Buses where Route like '%' + @trcx +'%'";
                //  cmd.Parameters.AddWithValue("@trc", "%" + trc + "%");
                cmd.Parameters.AddWithValue("@trcx", "%" + trcx + "%");
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {

                        //countries.Add(string.Format("{0}*{1}*{2}*{3}*{4}*{5}", sdr["Mobile"], sdr["Name"], sdr["Email"], sdr["Loan"], sdr["Interest"], sdr["Period"]));
                        countries.Add(string.Format("{0}*{1}*{2}*{3}", sdr["BusName"], sdr["BusNumber"], sdr["DepartureTime"], sdr["ArrivalTime"]));

                    }
                }
                conn.Close();
            }
        }
        return countries.ToArray();

    }

    //[WebMethod]
    //public string ProcessgoalData(IEnumerable<Goal> dataDyna, IEnumerable<year> datadina)

    [System.Web.Services.WebMethod(EnableSession = true)]
    public string[] Getpartner(string name)
    {

        SqlConnection con1 = new SqlConnection();

        DATABASE DB = new DATABASE();

        //string sql = "insert into tbl_cat (catname) values ('" + name + "')";
        //con1 = DB.getCon();
        //SqlCommand cmmds = new SqlCommand(sql, con1); name,email,mob,adhaar,service,serid,addr,city,pin,pass
        //DB.ExecQry(cmmds);

        List<string> countries = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT fname+''+lname as name,CONVERT(varchar,dobm,6) as dobm,Mobile,Ocupati from Dikshitt where Code='" + name + "'";
                cmd.Parameters.AddWithValue("@SearchText", name);
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        countries.Add(string.Format("{0}*{1}*{2}*{3}", sdr["name"], sdr["dobm"], sdr["Mobile"], sdr["Ocupati"]));
                    }
                }
                conn.Close();
            }
        }

        return countries.ToArray();







    }

//    [System.Web.Services.WebMethod(EnableSession = true)]
//    public string ProcessgoalData(List<DikshitDTO> dataDyna, List<EducationDTO> datadina)
//     {
//        DateTime dateTime_Indian = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, India_Standard_Time);
//        SqlConnection con1 = new SqlConnection();
//        string dat = dateTime_Indian.ToString().Split('-')[0];
//        DATABASE DB = new DATABASE();

//        // Connection string to your database
//        // string connectionString = ConfigurationManager.ConnectionStrings["satsangdataConnectionString"].ConnectionString;
//        foreach (var prdtl in dataDyna)
//        {

//            DataTable hy = DB.returnDt("select * from UniqueCodes where Code ='" + prdtl.Code + "'");
//            DateTime fgc = DateTime.Parse(prdtl.Istavrity);
//            string sql  = "INSERT INTO [satsangdata].[satsangadmin].[Dikshitt] " +
//    "([code], [fname], [lname], [rname], [dobm], [PreAdd], [PermAdd], [Mobile], [Caste], [Ocupati], [jaajak], " +
//    "[details], [Aninco], [Totalmem], [Dikhitmem], [Adimem], [Refguru], [Refnum], [Kendra], [Incharge], [Istavritydatem]) " +
//    "VALUES ('" + prdtl.Code + "', '" + prdtl.Fname + "', '" + prdtl.Lname + "', '" + prdtl.rname + "', '" + prdtl.Dob + "', '" + prdtl.PreAdd + "', '" + prdtl.PermAdd + "', '" + prdtl.mobile + "', '" + prdtl.Caste + "', " +
//    "'" + prdtl.Occupation + "', '" + prdtl.jaajak + "', '" + prdtl.Details + "', '" + prdtl.aninco + "', '" + prdtl.fnumber + "', '" + prdtl.dnumber + "', '" + prdtl.bnumber + "', '" + prdtl.Refguru + "', '" + prdtl.Refnum + "', " +
//    "'" + prdtl.Kendra + "', '" + prdtl.Incharge + "', '" + fgc.ToString("MM/dd/yyyy HH:mm:ss") + "')";
//            con1 = DB.getCon();

//            SqlCommand cmmds = new SqlCommand(sql, con1);
//            DB.ExecQry(cmmds);


//            DataTable hy1 = DB.returnDt("select * from famnum where famcode ='" + prdtl.Code + "'");
//            DataTable hy12 = DB.returnDt("select * from Dikshitt where Code ='" + prdtl.Code + "'");
//            if (hy1.Rows.Count == 0)
//            {
//                string sql33 = "insert into [satsangdata].[satsangadmin].[famnum] (famcode,totmem,dikmem,adikmem) values ('" + prdtl.Code + "','" + prdtl.fnumber + "', '" + prdtl.dnumber + "', '" + prdtl.bnumber + "') ";
//                con1 = DB.getCon();
//                SqlCommand cmmds33 = new SqlCommand(sql33, con1);
//                DB.ExecQry(cmmds33);
//            }
//            else
//            {
//                string sql33 = "update [satsangdata].[satsangadmin].[famnum] set adikmem='" +(Convert.ToDecimal(hy1.Rows[0]["totmem"].ToString())- Convert.ToDecimal(hy12.Rows.Count)).ToString()+ "',dikmem='" + hy12.Rows.Count + "'";
//                con1 = DB.getCon();
//                SqlCommand cmmds33 = new SqlCommand(sql33, con1);
//                DB.ExecQry(cmmds33);
//            }

//            if (hy.Rows.Count == 0)
//            {
//                string sqlx = "INSERT INTO [satsangdata].[satsangadmin].[UniqueCodes]   ( [Code], [CreatedAt])" +
//"VALUES ( '" + prdtl.Code + "', '" + dateTime_Indian.ToString() + "') ";
//                // con1 = DB.getCon();
//                SqlCommand cmmdsz = new SqlCommand(sqlx, con1);
//                DB.ExecQry(cmmdsz);
//            }


          
//        }

//        DataTable fg = DB.returnDt("select max(memberid) as memid from Dikshitt");

//        foreach (var prdtl1 in datadina)
//        {

//            string sql = "INSERT INTO [satsangdata].[satsangadmin].[education]   ( [memberid], [qualification], [Board], [yearpassing], [Percentage])" +
//"VALUES ( '" + fg.Rows[0]["memid"].ToString() + "', '" + prdtl1.Qualification + "', '" + prdtl1.Board + "', '" + prdtl1.YearOfPassing + "', '" + prdtl1.Percentage + "' ) ";
//            con1 = DB.getCon();
//            SqlCommand cmmds = new SqlCommand(sql, con1);
//            DB.ExecQry(cmmds);


           
//        }


//        return "ok";
//    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GenerateTransactionIDx(int userId)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;
        string generatedTransactionID = "";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            SqlCommand command = new SqlCommand("GenerateTransactionID", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add(new SqlParameter("@UserId", userId));
            SqlParameter outputParam = new SqlParameter("@TransactionID", SqlDbType.NVarChar, 10)
            {
                Direction = ParameterDirection.Output
            };
            command.Parameters.Add(outputParam);
            connection.Open();
            command.ExecuteNonQuery();
            generatedTransactionID = outputParam.Value.ToString();
            connection.Close();
        }

        return generatedTransactionID;
    }




    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    
    public string GenerateTransactionIDxyz(int userId)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;
        string generatedTransactionID = "";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            SqlCommand command = new SqlCommand("GenerateTransactionIDYAB", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add(new SqlParameter("@UserId", userId));
            SqlParameter outputParam = new SqlParameter("@TransactionID", SqlDbType.NVarChar, 10)
            {
                Direction = ParameterDirection.Output
            };
            command.Parameters.Add(outputParam);
            connection.Open();
            command.ExecuteNonQuery();
            generatedTransactionID = outputParam.Value.ToString();
            connection.Close();
        }

        return generatedTransactionID;
    }










    [WebMethod]
    public List<Transaction> GetData()
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;
        List<Transaction> transactions = new List<Transaction>();

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand(@"
                SELECT 
                    COALESCE(tx.[TransactionDate], t.[TransactionDate]) AS [TransactionDate],
                    COALESCE(tx.[KendraName], t.[KendraName]) AS [KendraName],
                    COALESCE(t.[TransactionID], tx.[TransactionID]) AS [TransactionID],
                    COALESCE(t.[AmountDeposited], 0) AS [AmountDeposited],
                    COALESCE(t.[StaffName], '') AS [StaffName]
                FROM 
                    [satsangdata].[satsangadmin].[Transactionsx] AS tx
                FULL OUTER JOIN 
                    [satsangdata].[satsangadmin].[Transactions] AS t
                ON 
                    tx.[TransactionID] = t.[TransactionID]", conn);

            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                transactions.Add(new Transaction
                {
                    TransactionDate = reader["TransactionDate"].ToString(),

                    KendraName = reader["KendraName"].ToString(),
                    TransactionID = reader["TransactionID"].ToString(),
                    AmountDeposited = reader["AmountDeposited"].ToString(),
                    StaffName = reader["StaffName"].ToString()
                });
            }
        }

        return transactions;
    }

    public class Transaction
    {
        public string TransactionDate { get; set; }
        public string KendraName { get; set; }
        public string TransactionID { get; set; }
        public string AmountDeposited { get; set; }
        public string StaffName { get; set; }
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string[] Getkenxz(string kendra)
    {
        List<string> members = new List<string>();
        string connectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT [fname] + ' ' + [lname] AS FullName FROM [satsangdata].[satsangadmin].[Dikshitt] WHERE [Kendra] = @Kendra";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Kendra", kendra);
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        members.Add(sdr["FullName"].ToString());
                    }
                }
                conn.Close();
            }
        }
        return members.ToArray();
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string[] Getkenx()
    {
        List<string> kendras = new List<string>();
        string connectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;

        try
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT [fname] + ' ' + [lname] AS FullName FROM [satsangdata].[satsangadmin].[Dikshitt]";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            kendras.Add(sdr["FullName"].ToString());
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
           
           
            kendras.Add("Error: " + ex.Message);
        }

        return kendras.ToArray();
    }



    [WebMethod]
    public  string GetActivityData()
    {
        int u = 1;
        string connectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;
        List<ActivityData> activityList = new List<ActivityData>();

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT TOP 1000  [KendraName], [MemberName], [Datex], 
                                [MorningGetUpTime], [DoneMeditation], [IstabrutiGiven], 
                                [KaachhaSanyam], [DoneExercise], [GajaMugaButa], 
                                [ThalkudiEaten], [ThakurBookReading], [DoneEveningPrayer], 
                                [WeeklySatsangAttended], [MatrujatiDistance], 
                                [DoneJaajan], [KnowingLiedToday], [HelpOthers], 
                                [SleepingTime] ,TotalMarks
                FROM [satsangdata].[satsangadmin].[FormResponses]", con))
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    ActivityData data = new ActivityData
                    {
                        Slno = u.ToString(),
                        KendraName = reader["KendraName"] != DBNull.Value ? reader["KendraName"].ToString() : string.Empty,
                        MemberName = reader["MemberName"] != DBNull.Value ? reader["MemberName"].ToString() : string.Empty,
                        Datex = reader["Datex"] != DBNull.Value ? Convert.ToDateTime(reader["Datex"]).ToString("yyyy-MM-dd") : string.Empty,
                        MorningGetUpTime = reader["MorningGetUpTime"] != DBNull.Value ? reader["MorningGetUpTime"].ToString() : string.Empty,
                        DoneMeditation = reader["DoneMeditation"] != DBNull.Value ? reader["DoneMeditation"].ToString() : string.Empty,
                        IstabrutiGiven = reader["IstabrutiGiven"] != DBNull.Value ? reader["IstabrutiGiven"].ToString() : string.Empty,
                        KaachhaSanyam = reader["KaachhaSanyam"] != DBNull.Value ? reader["KaachhaSanyam"].ToString() : string.Empty,
                        DoneExercise = reader["DoneExercise"] != DBNull.Value ? reader["DoneExercise"].ToString() : string.Empty,
                        GajaMugaButa = reader["GajaMugaButa"] != DBNull.Value ? reader["GajaMugaButa"].ToString() : string.Empty,
                        ThalkudiEaten = reader["ThalkudiEaten"] != DBNull.Value ? reader["ThalkudiEaten"].ToString() : string.Empty,
                        ThakurBookReading = reader["ThakurBookReading"] != DBNull.Value ? reader["ThakurBookReading"].ToString() : string.Empty,
                        DoneEveningPrayer = reader["DoneEveningPrayer"] != DBNull.Value ? reader["DoneEveningPrayer"].ToString() : string.Empty,
                        WeeklySatsangAttended = reader["WeeklySatsangAttended"] != DBNull.Value ? reader["WeeklySatsangAttended"].ToString() : string.Empty,
                        MatrujatiDistance = reader["MatrujatiDistance"] != DBNull.Value ? reader["MatrujatiDistance"].ToString() : string.Empty,
                        DoneJaajan = reader["DoneJaajan"] != DBNull.Value ? reader["DoneJaajan"].ToString() : string.Empty,
                        KnowingLiedToday = reader["KnowingLiedToday"] != DBNull.Value ? reader["KnowingLiedToday"].ToString() : string.Empty,
                        HelpOthers = reader["HelpOthers"] != DBNull.Value ? reader["HelpOthers"].ToString() : string.Empty,
                        SleepingTime = reader["SleepingTime"] != DBNull.Value ? reader["SleepingTime"].ToString() : string.Empty,
                        TotalMarks = reader["TotalMarks"] != DBNull.Value ? reader["TotalMarks"].ToString() : string.Empty
                    };

                    activityList.Add(data);
                    u++;
                }
                }
            }

        // Serialize the list to JSON
        return JsonConvert.SerializeObject(activityList);
    }

    public class ActivityData
    {
        public string Slno { get; set; }
        public int Id { get; set; }
        public string KendraName { get; set; }
        public string MemberName { get; set; }
        public string Datex { get; set; }
        public string MorningGetUpTime { get; set; }
        public string DoneMeditation { get; set; }
        public string IstabrutiGiven { get; set; }
        public string KaachhaSanyam { get; set; }
        public string DoneExercise { get; set; }
        public string GajaMugaButa { get; set; }
        public string ThalkudiEaten { get; set; }
        public string ThakurBookReading { get; set; }
        public string DoneEveningPrayer { get; set; }
        public string WeeklySatsangAttended { get; set; }
        public string MatrujatiDistance { get; set; }
        public string DoneJaajan { get; set; }
        public string KnowingLiedToday { get; set; }
        public string HelpOthers { get; set; }
        public string SleepingTime { get; set; }
         public string TotalMarks { get; set; }
    }







    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public MemberDetails GetMemberDetails(string memberName)
    {
        MemberDetails details = null;

        // Use ConfigurationManager to get the connection string
        string connectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();

            // Query to get the details of the member based on full name
            string query = @"
        SELECT [code], [Kendra], [Mobile]
        FROM [satsangdata].[satsangadmin].[Dikshitt]
        WHERE [memberid] = (
            SELECT [memberid]
            FROM [satsangdata].[satsangadmin].[Dikshitt]
            WHERE CONCAT([fname], ' ', [lname]) = @MemberName
        );";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@MemberName", memberName);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        details = new MemberDetails
                        {
                            code = reader["code"].ToString(),
                            Kendra = reader["Kendra"].ToString(),
                            Mobile = reader["Mobile"].ToString()
                        };
                    }
                }
            }
        }

        return details;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string[] kendra()
    {
        List<string> kendras = new List<string>();

        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM[satsangdata].[satsangadmin].[kendra_tbl]", conn))
            {
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        kendras.Add(sdr["Kendra"].ToString());
                    }
                }
            }
        }

        return kendras.ToArray();
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string SaveDataxz(TransactionDataxz postData)
    {
        try
        {
            string connectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = @"
                    INSERT INTO Transactionsxyz (TransactionId, TransactionDate, AmountDeposited, KendraName, MemberName, Mobile )
                    VALUES (@TransactionId, @TransactionDate, @AmountDeposited, @KendraName, @MemberName, @Mobile )";

                    cmd.Parameters.AddWithValue("@TransactionId", postData.TransactionId);
                    cmd.Parameters.AddWithValue("@TransactionDate", postData.TransactionDate);
                    cmd.Parameters.AddWithValue("@AmountDeposited", postData.AmountDeposited);
                    cmd.Parameters.AddWithValue("@KendraName", postData.KendraName);
                    cmd.Parameters.AddWithValue("@MemberName", postData.MemberName);
                    cmd.Parameters.AddWithValue("@Mobile", postData.Mobile);
              

                    cmd.ExecuteNonQuery();
                }
            }

            return "Data saved successfully!";
        }
        catch (Exception ex)
        {
            // Log the exception (not shown here for brevity)
            return "Error: " + ex.Message;
        }
    }


public class TransactionDataxz
{
    public string TransactionId { get; set; }
    public string TransactionDate { get; set; }
    public string AmountDeposited { get; set; }
    public string KendraName { get; set; }
    public string MemberName { get; set; }
    public string Mobile { get; set; }
    
}

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string SaveDataxzz(TransactionDataxz postDataz)
    {
        try
        {
            string connectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = @"
                    INSERT INTO Transactionsxyzz (TransactionId, TransactionDate, AmountDeposited, KendraName, MemberName, Mobile )
                    VALUES (@TransactionId, @TransactionDate, @AmountDeposited, @KendraName, @MemberName, @Mobile )";

                    cmd.Parameters.AddWithValue("@TransactionId", postDataz.TransactionId);
                    cmd.Parameters.AddWithValue("@TransactionDate", postDataz.TransactionDate);
                    cmd.Parameters.AddWithValue("@AmountDeposited", postDataz.AmountDeposited);
                    cmd.Parameters.AddWithValue("@KendraName", postDataz.KendraName);
                    cmd.Parameters.AddWithValue("@MemberName", postDataz.MemberName);
                    cmd.Parameters.AddWithValue("@Mobile", postDataz.Mobile);


                    cmd.ExecuteNonQuery();
                }
            }

            return "Data saved successfully!";
        }
        catch (Exception ex)
        {
            // Log the exception (not shown here for brevity)
            return "Error: " + ex.Message;
        }
    }


    public class TransactionDataxzz
    {
        public string TransactionId { get; set; }
        public string TransactionDate { get; set; }
        public string AmountDeposited { get; set; }
        public string KendraName { get; set; }
        public string MemberName { get; set; }
        public string Mobile { get; set; }

    }




    public class MemberDetails
    {
        public string code { get; set; }
        public string Kendra { get; set; }
        public string Mobile { get; set; }
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<staffDatax> Getstf(string kendracod)
    {
        List<staffDatax> staffList = new List<staffDatax>();

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand())
            {
                // Use the received 'kendracod' value to filter the staff members
                cmd.CommandText = " SELECT id, staff AS name FROM [satsangdata].[satsangadmin].[staff_tbl] WHERE [kendracod] = @kendracod ";
                cmd.Parameters.AddWithValue("@kendracod", kendracod);
                cmd.Connection = conn;

                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        staffList.Add(new staffDatax
                        {
                            Id = sdr["id"].ToString(),
                            Name = sdr["name"].ToString()
                        });
                    }
                }
            }
        }

        return staffList;
    }


[WebMethod]
    public string SaveTransactionDataz(TransactionDataz transactionDataz)
    {
        // Retrieve the connection string from the web.config file
        string connectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;

        // Database connection and insertion logic here
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "INSERT INTO Transactionszx (TransactionID, TransactionDate,Monthd,Yeard, KendraName, StaffName,  MemberName, AmountDeposited, NextRecurringMonth) " +
                           "VALUES (@TransactionID, @TransactionDate,@Monthd,@Yeard, @KendraName, @StaffName, @MemberName, @AmountDeposited, @NextRecurringMonth)";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@TransactionID", transactionDataz.TransactionID);
                cmd.Parameters.AddWithValue("@TransactionDate", transactionDataz.TransactionDate);
                cmd.Parameters.AddWithValue("@KendraName", transactionDataz.KendraName);
                cmd.Parameters.AddWithValue("@StaffName", transactionDataz.StaffName);
                cmd.Parameters.AddWithValue("@Monthd", transactionDataz.Month);
                cmd.Parameters.AddWithValue("@Yeard", transactionDataz.Year);

                cmd.Parameters.AddWithValue("@MemberName", transactionDataz.MemberName);
                cmd.Parameters.AddWithValue("@AmountDeposited", transactionDataz.AmountDeposited);

                cmd.Parameters.AddWithValue("@NextRecurringMonth", transactionDataz.NextRecurringMonth);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        return "Data saved successfully!";
    }

    public class TransactionDataz
    {
        public string TransactionID { get; set; }
        public string TransactionDate { get; set; }
        public string KendraName { get; set; }
        public string Month { get; set; }
        public string Year { get; set; }
        public string StaffName { get; set; }

        public string MemberName { get; set; }
        public string AmountDeposited { get; set; }

        public string NextRecurringMonth { get; set; }
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public  string[] Getkendra()
    {
        List<string> kendras = new List<string>();
        string connectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT DISTINCT [Kendra] FROM [satsangdata].[satsangadmin].[Dikshitt]";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        kendras.Add(sdr["Kendra"].ToString());
                    }
                }
                conn.Close();
            }
        }
        return kendras.ToArray();
    }






    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string SaveData(Dataz Dataz)
    {
        // Retrieve the connection string from the web.config file
        string connectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;

        // Database connection and insertion logic here
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "INSERT INTO signup ([staffid], [type],[username],[email], [password], [confirm_password]) " +
                           "VALUES (@staffid, @type,@username,@email, @password, @confirm_password)";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@staffid", Dataz.staffID);
                cmd.Parameters.AddWithValue("@type", Dataz.type);
                cmd.Parameters.AddWithValue("@username", Dataz.username);
                cmd.Parameters.AddWithValue("@email", Dataz.email);
                cmd.Parameters.AddWithValue("@password", Dataz.password);
                cmd.Parameters.AddWithValue("@confirm_password", Dataz.confirm);
                

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        return "Data saved successfully!";
    }

    public class Dataz
    {
        public string staffID { get; set; }
        public string type { get; set; }
        public string username { get; set; }
        public string email { get; set; }
        public string password { get; set; }
        public string confirm { get; set; }
        
    }




    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string register(ServiceDatax collection)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["satsangdata"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            using (SqlTransaction transaction = conn.BeginTransaction())
            {
                try
                {
                    using (SqlCommand cmd = new SqlCommand("INSERT INTO Collections (Collection1, Date1, Collection2, Date2, Collection3, Date3) VALUES (@Collection1, @Date1, @Collection2, @Date2, @Collection3, @Date3)", conn, transaction))
                    {
                        cmd.Parameters.AddWithValue("@Collection1", collection.Collection1);
                        cmd.Parameters.AddWithValue("@Date1", collection.Date1);
                        cmd.Parameters.AddWithValue("@Collection2", collection.Collection2);
                        cmd.Parameters.AddWithValue("@Date2", collection.Date2);
                        cmd.Parameters.AddWithValue("@Collection3", collection.Collection3);
                        cmd.Parameters.AddWithValue("@Date3", collection.Date3);

                        cmd.ExecuteNonQuery();
                    }

                    transaction.Commit();
                    return "success";
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    throw new Exception("Error saving service data: " + ex.Message);
                }
            }
        }
    }

    public class ServiceDatax
    {
        public string Collection1 { get; set; }
        public string Date1 { get; set; }
        public string Collection2 { get; set; }
        public string Date2 { get; set; }
        public string Collection3 { get; set; }
        public string Date3 { get; set; }
    }


    public class BookedSeat
    {
        public string SeatNumber { get; set; }
    }
    public class CaseData
    {
        public string Id { get; set; }
        public string Code { get; set; }
        public string UserId { get; set; }
        public string CreatedAt { get; set; }

    }
    public class kendraData
    {
        public string Id { get; set; }
        public string Code { get; set; }


    }
    public class staffData
    {
        public string Id { get; set; }
        public string Name { get; set; }

    }
    public class staffDatax
    {
        public string Id { get; set; }
        public string Name { get; set; }


    }

    public class DikshitDTO
    {
        public string Code { get; set; }
        public string Fname { get; set; }
       
        public string Lname { get; set; }
        public string rname { get; set; }
        public string Dob { get; set; }
        public string PreAdd { get; set; }
        public string PermAdd { get; set; }
        public string mobile { get; set; }
        public string Caste { get; set; }
        public string Occupation { get; set; }
        public string Details { get; set; }
        public string aninco { get; set; }
        public string fnumber { get; set; }
        public string dnumber { get; set; }
        public string bnumber { get; set; }
        public string Refguru { get; set; }
        public string Refnum { get; set; }
        public string Kendra { get; set; }
        public string Incharge { get; set; }
        public string Istavrity { get; set; }
        public string jaajak { get; set; }
    }

    public class EducationDTO
    {
        public string Qualification { get; set; }
        public string Board { get; set; }
        public int YearOfPassing { get; set; }
        public string Percentage { get; set; }
    }

    public class RootObject
    {
        public List<DikshitDTO> DataDyna { get; set; }
        public List<EducationDTO> Datadina { get; set; }

    }

}

