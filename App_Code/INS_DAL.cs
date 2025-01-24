using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
/// <summary>
/// Summary description for INS_DAL
/// </summary>
public class INS_DAL
{
    DATABASE DB = new DATABASE();
   
	public INS_DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public bool REGISTRATION(object[] VAL)
    {
        string[] param = { "Ename","Dname", "DesigName", "PhoneNo", "Password", "Conpassword", "Roles" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_REG"));

    }

    public bool DEPT(object[] VAL)
    {
        string[] param = { "DepartmentName" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_DEPT"));

    }

    public bool DESG(object[] VAL)
    {
        string[] param = { "Did", "DesignationName", "Username" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_DESG"));

    }
    public bool REPO(object[] VAL)
    {
        string[] param = { "Catagoryfile", "Description", "Dateofupload", "Uploadfile" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_REPO"));

    }
    public bool ULIST(object[] VAL)
    {
        string[] param = { "StaffId", "Sname", "Dname", "DesigName", "ContactNo", "Email", "Username", "Password" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_ULIST"));

    }
    public bool LOGIN(object[] VAL)
    {
        string[] param = { "Name","Email","Password" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_LOGIN"));

    }

    public bool FUNDCHK(object[] VAL)
    {
        string[] param = { "numjngs","action","memid"};
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_FUNDS"));

    }
    public bool JNGCHK(object[] VAL)
    {
        string[] param = { "rfid","jnchrgs"};
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_JNGS"));

    }

    public bool FRAP(object[] VAL)
    {
        string[] param = { "MemberId" , "state", "city" , "profilename" , "email" ,
            "jndt" , "phno" , "gstin"  , "addr" , "bank" ,"accno", "ifsc"  ,"typ"  ,"status" ,"pan","msme","area","mtrfid"};
        return DB.ExecQry(DB.getCmd(param, VAL, "FRAP"));

    }

    public bool ADDUSER(object[] VAL)
    {
        string[] param = { "Username","Password", "UserId","MemId" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_USERADDS"));

    }

    public bool FRAPUSERS(object[] VAL)
    {
        string[] param = { "Username", "Password", "UserId", "FrapId" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_FRAPUSERS"));

    }

    public bool PRODUCT(object[] VAL)
    {
        string[] param = { "PrdName", "Category", "PurPrice", "SalePrice", "MRP", "StockIn", "Cgstrt", "Sgstrt", "Cgstval", "Sgstval", "path", "Discount", "Promcode", "status", "BV" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_product"));

    }


    public bool CART(object[] VAL)
    {
        string[] param = {"MemberId", "ProductId", "Quantity" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_cart"));

    }

    public bool UNIFROM(object[] VAL)
    {
        string[] param = { "MemberId", "Name", "ParentId", "RefId", "status", "jnchrgs", "typ", "path" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_REGISTRATION"));

    }

    public bool RECURSIVE(object[] VAL)
    {
        string[] param = { "MemberId", "Name", "ParentId", "RefId", "status", "jnchrgs", "typ", "path" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_REGISTRATION"));

    }

    public bool UNPRECEDENTED(object[] VAL)
    {
        string[] param = { "MemberId", "Name", "ParentId", "RefId", "status", "jnchrgs", "typ", "path" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_REGISTRATION"));

    }

    public bool POSTING(string[] VAL)
    {
        string[] param = { "MemberId","PostrefId","Postval", "podate" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_POSTING"));

    }

    public bool POSTING_SPN(string[] VAL)
    {
        string[] param = { "MemberId", "PostrefId", "Postval", "podate" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_POSTINGSPONSO"));

    }

    public bool MANAGE(string[] VAL)
    {
        string[] param = { "memid", "prid", "RefId" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_MANAGE"));

    }

    public bool REG_STATUS(string[] VAL)
    {
        string[] param = { "MemberId", "status" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_STATUS_MASTER"));

    }


    public bool DEL_STATUS(string[] VAL)
    {
        string[] param = { "MemberId", "status" };
        return DB.ExecQry(DB.getCmd(param, VAL, "SP_DEL_STATUS"));

    }
}