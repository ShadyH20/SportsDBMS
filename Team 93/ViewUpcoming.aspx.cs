using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportsWeb
{
    public partial class ViewUpcoming : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            SqlCommand upcoming = new SqlCommand("ViewUpcoming", Login.conn);
            upcoming.CommandType = CommandType.StoredProcedure;
            Login.conn.Open();
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
                matchesPH.Controls.Add(lbl);

            }
            Login.conn.Close();
            reader.Close();
        }
    }
}