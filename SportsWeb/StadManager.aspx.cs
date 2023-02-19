using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace SportsWeb
{
    public partial class StadManager : System.Web.UI.Page
    {
        protected string username;
        protected void Page_Load(object sender, EventArgs e)
        {
            username = Request.QueryString["username"];


            //SqlCommand ViewStad = new SqlCommand("ViewStadManagerStadium", Login.conn);
            //ViewStad.CommandType = CommandType.StoredProcedure;
            //Login.conn.Open();
            //ViewStad.Parameters.Add(new SqlParameter("username", username));
            //SqlDataReader reader = ViewStad.ExecuteReader(CommandBehavior.CloseConnection);


            //while (reader.Read())
            //{
            //    String StadName = reader.GetString(reader.GetOrdinal("StadName"));
            //    Boolean Available = reader.GetBoolean(reader.GetOrdinal("Available"));
            //    Int32 Capacity = reader.GetInt32(reader.GetOrdinal("Capacity"));
            //    String Location = reader.GetString(reader.GetOrdinal("Location"));
            //    Label lbl = new Label();
            //    lbl.Text = "<tr> <td> Stadium Name: <br/>" + StadName + " </td>" +
            //        "<br/> <td> Availablity: <br/>" + Available + " </td>" +
            //        "<br/><td> Capacity: <br/>" + Capacity + " </td>" +
            //        "<br/><td> Location: <br/>" + Location + " </td ></tr> <br/>";
            //    Stadinfo.Controls.Add(lbl);

            //}
            //Login.conn.Close();
            //reader.Close();


            SqlDataAdapter sqlDa = new SqlDataAdapter("EXEC stadiumInfo " + username, Login.conn);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            gvStadInfo.DataSource = dtbl;
            gvStadInfo.DataBind();

            string stadName = gvStadInfo.Rows[0].Cells[0].Text;

            SqlDataAdapter sqlDa2 = new SqlDataAdapter("EXEC allManagerRequests " + username, Login.conn);
            DataTable dtbl2 = new DataTable();
            sqlDa2.Fill(dtbl2);
            gvRequests.DataSource = dtbl2;
            gvRequests.DataBind();
        }

        protected void acceptBtn_Click(object sender, EventArgs e)
        {
            string[] arg = new string[3];
            arg = (sender as Button).CommandArgument.ToString().Split(';');

            SqlCommand acceptReq = new SqlCommand("acceptRequest", Login.conn);
            acceptReq.Parameters.Add(new SqlParameter("@username", username));
            acceptReq.Parameters.Add(new SqlParameter("@host_club", arg[0]));
            acceptReq.Parameters.Add(new SqlParameter("@guest_club", arg[1]));
            acceptReq.Parameters.Add(new SqlParameter("@start_time", arg[2]));
            acceptReq.CommandType = CommandType.StoredProcedure;

            Login.conn.Open();
            acceptReq.ExecuteNonQuery();
            Login.conn.Close();

            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Request has been accepted!');", true);


            Response.Redirect("StadManager.aspx?username=" + username);
        }

        protected void rejectBtn_Click(object sender, EventArgs e)
        {
            string[] arg = new string[3];
            arg = (sender as Button).CommandArgument.ToString().Split(';');

            SqlCommand rejectReq = new SqlCommand("rejectRequest", Login.conn);
            rejectReq.Parameters.Add(new SqlParameter("@username", username));
            rejectReq.Parameters.Add(new SqlParameter("@host_club", arg[0]));
            rejectReq.Parameters.Add(new SqlParameter("@guest_club", arg[1]));
            rejectReq.Parameters.Add(new SqlParameter("@start_time", arg[2]));
            rejectReq.CommandType = CommandType.StoredProcedure;

            Login.conn.Open();
            rejectReq.ExecuteNonQuery();
            Login.conn.Close();

            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Request has been rejected!');", true);

            Response.Redirect("StadManager.aspx?username=" + username);

        }
    }
}