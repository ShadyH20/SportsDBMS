using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace SportsWeb
{
    public partial class Fan : System.Web.UI.Page
    {
        public string username;
        public string nationalID;
        static string startTime;
        protected void Page_Load(object sender, EventArgs e)
        {

            username = Request.QueryString["username"];

            SqlCommand getNationalID = new SqlCommand("getNationalID", Login.conn);
            getNationalID.Parameters.Add(new SqlParameter("@username", username));
            getNationalID.CommandType = CommandType.StoredProcedure;

            Login.conn.Open();
            nationalID = getNationalID.ExecuteScalar().ToString();
            Login.conn.Close();

            if (Request.QueryString["time"] != null)
            {
                loadMatches(Request.QueryString["time"]);
            }


        }

        private DataTable loadMatches(string time)
        {
            startTime = time;
            SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT * FROM dbo.viewAvailableMatchesOn('" + time + "')", Login.conn);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            gvAvailMatches.DataSource = dtbl;
            gvAvailMatches.DataBind();

            return dtbl;
        }

        protected void availMatchesBtn_Click(object sender, EventArgs e)
        {
            if (Request.Form["dateText"] == "")
            {
                MessageBox.Show("Please enter a valid date.", "Warning");
                return;
            }
            startTime = Convert.ToDateTime(Request.Form["dateText"]).ToString();

            //Response.Write(startTime); 2023-03-18 20:00:00.000

            DataTable dtbl = loadMatches(startTime);



            if (dtbl.Rows.Count == 0)
            {
                MessageBox.Show("There are no available matches at this time.", "Whoops!");
            }
        }

        protected void purchaseBtn_Click(object sender, EventArgs e)
        {
            string[] arg = new string[3];
            arg = (sender as Button).CommandArgument.ToString().Split(';');

            SqlCommand purchase = new SqlCommand("purchaseTicket", Login.conn);
            purchase.Parameters.Add(new SqlParameter("@nationalId", nationalID));
            purchase.Parameters.Add(new SqlParameter("@hostClub", arg[0]));
            purchase.Parameters.Add(new SqlParameter("@guestClub", arg[1]));
            purchase.Parameters.Add(new SqlParameter("@start_time", arg[2]));
            purchase.CommandType = CommandType.StoredProcedure;

            Login.conn.Open();
            purchase.ExecuteNonQuery();
            Login.conn.Close();

            MessageBox.Show("Purchase Successful!", "Yay!");

            SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT * FROM dbo.viewAvailableMatchesOn('" + startTime + "')", Login.conn);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            gvAvailMatches.DataSource = dtbl;
            gvAvailMatches.DataBind();

            //Request.Form["dateText"];

            Response.Redirect("Fan.aspx?username=" + username + "&time=" + startTime);
            //arg[0];

        }
    }
}