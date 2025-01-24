using System;
using System.Web.Script.Services;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;
using System.Configuration;

/// <summary>
/// Summary description for GetData
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
 [System.Web.Script.Services.ScriptService]
public class GetData : System.Web.Services.WebService
{

    public GetData()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }




    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetDatabaseData()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        string query = "SELECT [ofcreptno] as Offence_ReportNo ,[dated] as Dated,[plceocrnce] as Place_of_occurrence,[date] as Datec," +
     "[timee] as Timed,[ofnm] as Named,[ofprtge] as Parentage,[ofresd] as Residence,[prprtyszd] as Property_seized,[cstdyszpr] as Custody_of_seized_property," +
     "[factcse] as facts_of_the_case,[rferofrpt] as Reference_Offence_ReportNo,[division] as Division,[raneofc] as Range_Office ," +
     "[timex] as Timed,[datex] as Dated,[section] as Section,[underact] as Under_Act,[gpsextplce] as Gps_Exact_Place,[lndmrk] as Land_Mark," +
     "[informdtl] as Informant_Details,[mode] as Mode,[cntrcvr] as Contact_details_of_Receiver_Patrolling_Party,[rangedno] as Range_Diary_No," +
     "[datec] as Dated,[tme] as Timed,[sadlt] as Adults,[sminor] as Minors,[snm] as Named,[sidfcn] as BodyMark_for_identification,[smble] as Mobile," +
     "[idother] as Id_other,[nmprprty] as Nameof_the_property,[idfctnmrk] as Identification_mark,[nmcstdn] as Name_of_the_Custodian," +
     "[cstadrs] as Addressof_the_Custodian,[ctdncnt] as Contact_detail,[rsninwtns] as Reasonsif_independent_witness_not_found," +
     "[ofclwtnsdtl] as Official_Witness_Detail,[nmdesigidno] as Name_with_Designation_ID_No,[nmdesgcnt] as Contact_No FROM [forestdata].[dbo].[tbl_coplntform]";


        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return ConvertDataTableToJson(dataTable);
            }
        }
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetSeizureData()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        string query = "select[dtszre]as Date_Of_Seizure,[plceszre]as Place_Of_Seizure,[timeszre]as Time_Of_Seizure,[nmacsed]as Name_And_Address_Of_The_Accused_Person," +
"[prtclrpszed]as Perticulars_Of_The_Property_Seized,[nmofwtns]as Name_And_Address_Of_The_Witness,[szremrk]as Seizure_Mark,[division]as Division,"+
"[lndmrkszre]as Landmark_Place_of_seizure,[rangeofc]as Range_Office,[gpscodint]as GPS_co_ordinates,[dtx]as Date,[timex]as Time,[rsonszre]as Reasons_for_seizure," +
"[bfresprtcl]as Before_Search_Protocol_No,[dte]as Date,[tme]as Time,[aftresprtcl]as After_Search_Protocol_No,[dtex]as Date,[tmex]as Time,[frmino]as Form_I_No," +
"[datexx]as Date,[timesxx]as Time,[prtpszed]as Particulars_of_the_property_seized,[cstdnpszed]as Custodian_of_the_Seized_Property,[pssrnm]as  Name," +
"[pssrbdyiden]as Body_Mark_for_identification,[pssrmob]as Mobile_No,[pssridno]as ID_Card_No,[nmw]as Name,[bdyidenw]as Body_Mark_for_identification,[mobw]as Mobile_No," +
"[idno]as ID_Card_No,[ofwnm]as Name,[ofwbdyiden]as Body_Mark_for_identification,[ofwmob]as Mobile_No,[ofwidno]as ID_Card_No,[name]as Name,[desig]as Designation," +
"[idnoo]as Id_No,[mob]as Mobile from [forestdata].[dbo].[tbl_seizure_list]";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return ConvertDataTableToJson(dataTable);
            }
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetSeizureinfo()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        string query = "select[sdt]as Date,[nmfo]as Name_Of_The_Forest_Officer,[prprtyof]as Property_Of,[section]as Section,[act]as Act,[rangerof]as Ranger_Of,[frstrof]as Forester_Of," +
"[repono]as  report_no,[date]as Date,[szrelistn]as Seizure_list_Number,[formno]as Form_1_No from [forestdata].[dbo].[tbl_seizure_info]";



        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return ConvertDataTableToJson(dataTable);
            }
        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetPetitionPdf()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        string query = "select[division]as Division,[rfo]as Through_the_range_Officer_Range,[sof]as son_of,[resid]as resident_of,[po]as Post,[dist]as Dist,[acsnm]as Name_of_the_accused," +
"[fnm]as Father_Name,[padrs]as Permanent_address,[tadrs]as Temporary_address,[prtclrofns]as Particulars_of_offence,[prprty]as Situation_of_the_immovable_property_and_list_of_such_property," +
"[adrs]as Address,[date]as Date,[adrsi]as Address,[dateii]as Date,[ofcrnm]as Name,[ofcrdesig]as Designation from [forestdata].[dbo].[tbl_compondingptn]";



        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return ConvertDataTableToJson(dataTable);
            }
        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string Getoffence()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        string query = "select[no]as No,[fdepatmnt]as Forest_Department,[division]as Division,[depot]as Depot,[rcvfrm]as Received_from ,[rupees]as Sum_of_Rupees,[prtclepszd]as Particulars_of_the_property_seized,[szrplce]as Place_of_seizure," +
"[date]as Date,[time]as Time,[ara]as The,[year]as Yeard,[numb]as No,[fdept]as Forest_Department,[divsn]as Division,[rferfi]as Form_I,[rferfii]as Form_II,[recvfm]as Depot_Received_from,[smrupwrd]as Sum_of_Rupees," +
"[thrgh]as Through,[ondd]as Ondy,[twrd],[vlnof]as violation_of,[byff]as Byd,[rsncamnt]as Reasons_for_determination_of_compounding_amount,[prpszed]as Particulars_of_the_property_seized,[plceszre]as Place_of_Seizure," +
"[dted]as Date,[tmed]as Time,[thfo]as The,[yeard]Yeard from [forestdata].[dbo].[tbl_compouding_rcpt]";



        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return ConvertDataTableToJson(dataTable);
            }
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetCompoundodr()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        string query = "select[fileno]as Forest_Offence_File_No,[acsednm]as In_view_of_the_compounding_petition_filed_by_the_accused_Shri,[amnt]as sum_of_Rs,[amntw]as In_words_and_figures," +
"[section]as Under_Section,[szuredtl]as Seizure_Detail,[athrzefo]as Authorized_Forest_Officer,[desig]as Designation,[place]as Place,[dt]as Date,[rfo]as  Shri," +
"[officernge]as Copy_to_the_range_Officer_Range,[formino]as Form_I_No,[forestdept]as Forest_department,[division]as Division,[rferfi]as Form_I,[rferfii]as Form_II," +
"[ofncunder]as In_view_of_the_violation_of_offences_under,[acsed]as Accused,[ttlamnt]asSum_of_Rs,[ttlamntwods] as In_words_and_figures," +
"[reason]as Reasons_for_determination_of_such_compensation_amount,[formiino]as Ref_Form_II_No,[plce]as Place,[dte]as Date,[tme]as Time,[ofcr]as TO_mr," +
"[rofcerof]as Copy_to_the_Range_Officer_of from [forestdata].[dbo].[tbl_compouding_order]";



        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return ConvertDataTableToJson(dataTable);
            }
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetFinalpr()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        string query = "select[division]as Division,[dated]as Dated,[ofncrno]as Offence_Report_No,[range]as Range,[dodt]as Date_Of_Detection,[plceoccr]as Place_Of_Occurrence,[timedt]as Time_Of_Detection,"+
"[bywhmdtct]as By_Whom_Detected,[acsdnm]as Name,[fnm]as Father_Name,[vlge]as Village,[thana]as Thana,[dist]as District,[dvsn]as Division,[ofnrepon]as Offence_Report_No,"+ 
"[date]as Date,[rvnestrng]as Revenue_Station_Range,[memono]as Memo_No,[dte]as Date,[dfoinc]as Divisional_Forest_Officer_in_charge,[divsn]as Division,[memonumb]as Memo_No,"+
"[dtde]Date,[dfoch]as Divisional_Forest_Officer_in_charge,[divisn]as Division from [forestdata].[dbo].[tbl_finalrepo]";



        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return ConvertDataTableToJson(dataTable);
            }
        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string Arrestmrmo()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        string query = "select[arrestmno] as Arrest_Memo_No,[date]as Dtae,[time]as Time,[arstplce]as Date_time_specific_place_of_arrest,[groundarest]as Grounds_of_Arrest," +
"[parentagenm]as Name_parentage_and_address_of_the_arrestee,[idno]as Name_designation_of_officer_effecting_arrest_with_ID_No," +
"[wtnscdtl]as Name_address_of_witnesses,[ysno]as Yes_No_in,[rltnwacs]as Name_and_particulars_of_the_persons," +
"[acvsblesigns]as Whether_injury_present_on_the_body_of_the_arrestee,[acsedbmrk]as Any_identification_mark_of_accused," +
"[acseyn]as Whether_personal_search_of_the_accused_carried_out_Yes_No,[referno]as Reference_No,[amemono]as Arrest_Memo_No,[datex]as Date,[timex]as Time," +
"[arstplcex]as specific_place_of_arrest,[grndarest]as Grounds_of_Arrest,[acsedtl]as Name_parentage_and_address_of_the_arrestee," +
"[dsgidno]as Name_designation_of_officer_effecting_arrest_with_ID_No,[nmadrsw]as Name_address_of_witnesses,[yn]as Yes_No,[rltnwacsnm]as Relation_With_Accused," +
"[acvsblesignsx]as Whether_any_visible_signs_of_trauma_injury_Arrestee,[acsedbmrkx]as Any_identification_mark_of_accused,[acseynx]as Yes_No," +
"[refernox]as Reference_No,[pmemono]as Personal_Search_Memo_No,[division]as Division,[rangeofc]as Range_Office,[datec]as Date,[timec]as Time,[referarmemo]as Reference_Arrest_Memo_No," +
"[nm]as Name,[adrs]as Address,[mob]as Mobile_No,[bdymrkiden]as Body_Mark_for_identification,[idothrno]as ID_Card_No_Aadhar_Other," +
"[plce]as Place_where_personal_search_on_the_arrestee_detainee_been_conducted,[ofcrsrch]as Officer_by_whom_personal_search_has_been_conducted,[ofcrdtl]as Name_Designation_and_ID_No," +
"[bfresrchno]as Before_Search_Protocol_No,[dated]as Date,[timed]as Time,[aftrsrchno]as After_Search_Protocol_No,[datek]as Date ,[timek]as Time," +
"[itmrecover]as The_items_recovered,[yesno]as Yes_No,[ifymntn]as If_Yes_please_mention," +
"[ysnoo]as Aarrestee_detainee_resisted_or_tried_to_evade  from [forestdata].[dbo].[tbl_arrestmemo]";



        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return ConvertDataTableToJson(dataTable);
            }
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string Beforesearch()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        string query = "select[no]as No,[division]as Division,[rangeofc]as Range_Office,[date]as Date,[time]as Time,[formiino]as Form_II_No,[datex]as Date,[timex]as Time," +
"[prsnfldtl]as Places_with_GPS_co_ordinates,[spinvldtl]as Search_Party_involved,[Posesnfnd]as Possession_found,[remark]as Remarks from [forestdata].[dbo].[tbl_beforesrch]";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return ConvertDataTableToJson(dataTable);
            }
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string Aftersearch()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        string query = "select[no]as No,[division]as Division,[rangeofc]as Range_Office,[date]as Date,[time]as Time,[formiino] as Form_II_No,[datex]as Date,[timex]as Time," +
"[prsnfldtl]as Place_with_GPS_co_ordinates_landmark,[spinvldtl]as Search_Party_involved,[Posesnfnd]as Possession_found_from_the_search_party," +
"[remark]as Remark from [forestdata].[dbo].[tbl_aftersrch]";



        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return ConvertDataTableToJson(dataTable);
            }
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string Casediary()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        string query = "select[bookno]as Book_No,[slno]as Serial_No,[caseno]as Case_No,[date]as Date,[reformi]as Reference_Form_I from [forestdata].[dbo].[tbl_casediary]";



        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return ConvertDataTableToJson(dataTable);
            }
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string Witness()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        string query = "select[slno]as Serial_No,[divsn]as Division,[rangeofc]as Range_Office,[dt]as Date,[atdto]as Tos,[contact]as Contact_No,[eml]as Email_ID,[caseno]as case_number," +
"[cdt] as Date,[vlnof]as under_violation,[unk]as Registered_at,[regat]as Range_Office,[apprtme]as appear_before_us_at,[apprdt]as Date,[aprday]as Dayc," +
"[aprplce]as At,[rqstonm]as Requesting_officer_name,[rqstdesig]as Designation,[ntceno]as Notice_no,[ntcedt]as Date,[wtaprdt]as witness_has_appeared_on_date," +
"[wtaprdy]as Dayc,[wtapfrm]as From_date,[wtapto]as To_date,[szrlist]as Seizure_list,[paidwith]as Paid_with_Rs,[spctdtl]as name_description_and_address," +
"[offnceof]as Offence_of,[attndcedtl]as Name_description_address_of_the_witness,[wtnsnm]as Name_of_witness,[wrntnm]as warrant_name,[apprplc]Appear_place," +
"[court]as Before_the_Court,[crtdt]as Date,[crtday]as Day_of,[crtme]as Time,[tching]as Examined_touching," +
"[comppdt]as Date,[compday]as Day_of,[compyr]as Yearc  from [forestdata].[dbo].[tbl_attndncewtness]";



        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return ConvertDataTableToJson(dataTable);
            }
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string Accused()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        string query = "select[slno]as Serial_No," +
            "[dto]as Toc," +
            "[acsdnm]as Name_of_the_Accused_Notice," +
            "[lastknadrs]as Last_known_Address," +
            "[phoreml]as Phone_No_Email_ID,[plcest]as Police_Station," +
"[caseno]as Case_No," +
"[date]as Date,[dus]as us," +
"[regplstn] as Registered_at_Police_Station," +
"[aprtme]as Appear_before_me_at," +
"[aprplce]as Place,[fslno]as Sl_No," +
"[fdvson]as Division," +
"[frangeofc]as Range_Office,[fdate]as Date,[ftime]as Time,[fto]as Toc,[fcnct]as Contact_No,[feml]as Email_ID,[enqcaseno]as Case_number," +
"[casedt]as Date,[violation]as Violation_of,[atplc]as Registered_against_you_at,[aprtime]as Appear_before_us_at,[aprdt]as Date,[aprday]as Dayc,[plceat]At," +
"[ofcrnm]as Requesting_Officer_Name,[ofcrdesig]as Designation,[notice]as Notice,[noticedt]as Date,[apdt]as Appeared_date,[apday]as Dayc," +
"[frdt]as From_Date,[todt]as To_date  from [forestdata].[dbo].[tbl_attndnceacused]";



        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return ConvertDataTableToJson(dataTable);
            }
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string Additionalinfo()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        string query = "select[incourt]as In_the_Courtof,[reformi]as Reference_Form_I_No,[division]as Division,[year]as Yearc,[rangeofc]as Range_office,[caseno]as Case_No,[date]as Date," +
"[fprcectno]as Final_Prosecution_Report_No,[datex]as Dated,[sec]as Sections,[act]as Act,[typrfrepo]as Type_of_final_Report,[Mistakeoflaw]as Mistakeoflaw," +
"[invofcrnm]as Name_of_the_Investigating_Officer,[modeoffense]as Mode_of_Detection_of_Offence,[rank]as Ranks,[complainant]as Complainant_Informant,[szlistno]as Reference_Form_II_No," +
"[resultofany]as Resultofany_forensic_Analysis,[name]as Name,[fhnm]as Father_Husband_Name,[whetherverified]as Whetherverified,[dob]as Date_Yearof_Birth," +
"[gndr]as Gender,[adhr]as Aadhar_No,[nationality]as Nationality,[dateofissue]as Dateofissue,[placeofissue]as PlaceofIssue,[whscst]as Whether_SC_ST," +
"[relegion]as Religion,[ocptn]as Occupation,[adrs]as Address,[bdymrks]as Body_Identification_Marks,[whetherverifiedx]as Whetherverified,[valididtls]as Valid_ID_Card_Details," +
"[acsedsts]as Status_of_The_Accused,[arstmemoref]as Arrest_Memo_Ref,[dateofarst]as Date_Of_Arrest,[dateofbail]as Date_Of_Release_On_Bail,[datewfcrt]as Date_On_Which_Forwarded_To_Court," +
"[nmadrsrtes]as Name_and_Address_of_Sureties,[bkvlnact]as Booked_Underviolation_Of_Sections_In_Acts,[pvsref]as Previous_Convictions_with_Case_References," +
"[namex]as Name,[fhnmx]as Father_Husband_Name,[whetherverifiedy]as Whetherverified,[dobx]as Date_Yearof_Birth,[gndry]as Gender,[adhry]as Aadhar_No,[nationalityy]as Nationality," +
"[dateofissuey]as Dateofissue,[placeofissuey]as Placeof_Issue,[whscstx]as Whether_SC_ST,[relegiony]as Religion,[ocptny]as Occupation,[adrsy]as Address,[bdymrksy]as Body_Identification_Marks," +
"[whetherverifiedxx]as Whetherverified,[valididtlsy]as Valid_ID_Card_Details,[acsedstsy]as Status_of_The_Accused,[bkvlnacty]as Booked_Under_Violation_Of_Sections_In_Acts," +
"[notchofnc]as Any_Special_Remarks,[pwtnsdtl]as articulars_Of_Witnesses,[bfactcase]as Brief_Facts_Of_The_Case,[cdryrno]as Case_Diary_reference_number,[amemorefn]as Arrest_Memo_Reference_Number," +
"[formiiirefn]as Form_III_Reference_Number,[formviirefn]as Form_VII_Reference_Number,[rofname]as Name,[rofranks]as Ranks,[roidno]as Id_No,[invoname]as Name," +
"[invofranks]as Ranks,[invoidno] as Id_No from [forestdata].[dbo].[tbl_additional_info]";



        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return ConvertDataTableToJson(dataTable);
            }
        }
    }
    private string ConvertDataTableToJson(DataTable dataTable)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, string>> data = new List<Dictionary<string, string>>();

        foreach (DataRow dr in dataTable.Rows)
        {
            Dictionary<string, string> row = new Dictionary<string, string>();
            foreach (DataColumn col in dataTable.Columns)
            {
                row.Add(col.ColumnName, dr[col].ToString()); // Add column name and value to dictionary 
            }
            data.Add(row);
        }

        string json = serializer.Serialize(data);
        return json;
    }
}
