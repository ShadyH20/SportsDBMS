using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportsWeb
{
    public partial class ViewPlayed : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["connection1"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand upcoming = new SqlCommand("ViewPlayed", conn);
            upcoming.CommandType = CommandType.StoredProcedure;
            conn.Open();
            SqlDataReader reader = upcoming.ExecuteReader(CommandBehavior.CloseConnection);

            while (reader.Read())
            {
                String HostName = reader.GetString(reader.GetOrdinal("HostClub"));
                String GuestName = reader.GetString(reader.GetOrdinal("competing_club"));
                DateTime startt = reader.GetDateTime(reader.GetOrdinal("start_time"));
                DateTime endt = reader.GetDateTime(reader.GetOrdinal("end_time"));
                Label lbl = new Label();
                lbl.Text = "<tr> <td> Host Club: <br/>" + HostName + " </td>" +
                    "<br/> <td> Guest Club:<br/>" + GuestName + " </td>" +
                    "<br/><td> Start Time: <br/>" + startt + " </td>" +
                    "<br/><td> End Time:<br/>" + endt + " </td ></tr> <br/>";
                PlayedmatchesPH.Controls.Add(lbl);
            }
            conn.Close();
            reader.Close();
        }
    }
}