using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for INS
/// </summary>
public class INS
{
    INS_DAL DL = new INS_DAL();
	public INS()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public bool REGISTRATION(object[] VAL)
    {
        return DL.REGISTRATION(VAL);
    }

    public bool DEPT(object[] VAL)
    {
        return DL.DEPT(VAL);
    }
    public bool DESG(object[] VAL)
    {
        return DL.DESG(VAL);
    }
    public bool REPO(object[] VAL)
    {
        return DL.REPO(VAL);
    }
    public bool ULIST(object[] VAL)
    {
        return DL.ULIST(VAL);
    }
    public bool LOGIN(object[] VAL)
    {
        return DL.LOGIN(VAL);
    }
    public bool FUNDCHK(object[] VAL)
    {
        return DL.FUNDCHK(VAL);
    }

    public bool JNGCHK(object[] VAL)
    {
        return DL.JNGCHK(VAL);
    }

    public bool FRAP(object[] VAL)
    {
        return DL.FRAP(VAL);
    }

    public bool ADDUSER(object[] VAL)
    {
        return DL.ADDUSER(VAL);
    }

    public bool FRAPUSERS(object[] VAL)
    {
        return DL.FRAPUSERS(VAL);
    }

    public bool PRODUCT(object[] VAL)
    {
        return DL.PRODUCT(VAL);
    }

    public bool CART(object[] VAL)
    {
        return DL.CART(VAL);
    }

    public bool UNIFROM(object[] VAL)
    {
        return DL.UNIFROM(VAL);
    }
    public bool RECURSIVE(object[] VAL)
    {
        return DL.RECURSIVE(VAL);
    }
    public bool UNPRECEDENTED(object[] VAL)
    {
        return DL.UNPRECEDENTED(VAL);
    }

    public bool POSTING(string[] VAL)
    {
        return DL.POSTING(VAL);
    }

    public bool POSTING_SPN(string[] VAL)
    {
        return DL.POSTING_SPN(VAL);
    }
    public bool MANAGE(string[] VAL)
    {
        return DL.MANAGE(VAL);
    }
    public bool REG_STATUS(string[] VAL)
    {
        return DL.REG_STATUS(VAL);
    }
    public bool DEL_STATUS(string[] VAL)
    {
        return DL.REG_STATUS(VAL);
    }
}