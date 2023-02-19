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
    public partial class ClubRep : System.Web.UI.Page
    {
        public String username;
        public string clubName;
        protected void Page_Load(object sender, EventArgs e)
        {
            username = Request.QueryString["username"];

            SqlDataAdapter sqlDa = new SqlDataAdapter("EXEC clubInfo " + username, Login.conn);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            gvClubInfo.DataSource = dtbl;
            gvClubInfo.DataBind();

            clubName = gvClubInfo.Rows[0].Cells[0].Text;

            //Login.conn.Open();

            SqlCommand upcomingMatchesOfClub = new SqlCommand("upcomingMatches", Login.conn);
            upcomingMatchesOfClub.CommandType = System.Data.CommandType.StoredProcedure;
            upcomingMatchesOfClub.Parameters.Add(new SqlParameter("@clubname", clubName));

            SqlDataAdapter sqlDa2 = new SqlDataAdapter("EXEC upcomingMatches " + clubName, Login.conn);
            DataTable dtbl2 = new DataTable();
            sqlDa2.Fill(dtbl2);
            gvUpcomingMatches.DataSource = dtbl2;
            gvUpcomingMatches.DataBind();

            //Login.conn.Close();
            
        }

        DataTable loadStadiums(DateTime date)
        {
            SqlCommand cmd = new SqlCommand("availableStadiums", Login.conn);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter startDateParam = new SqlParameter("@date", SqlDbType.DateTime);
            startDateParam.Value = date;
            cmd.Parameters.Add(startDateParam);

            SqlDataAdapter sqlDa = new SqlDataAdapter(cmd);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            gvAvailStadiums.DataSource = dtbl;
            gvAvailStadiums.DataBind();

            return dtbl;
        }

        protected void viewAvailableStadiums(object sender, EventArgs e)
        {
            gvAvailStadiums.AutoGenerateSelectButton = false;
            gvAvailStadiums.SelectedIndex = -1;

            confirmReqBtn.Visible = false;

            if (Request.Form["dateText"] == "")
            {
                MessageBox.Show("Please enter a valid date.","Warning");
                return;
            }

            DateTime startDate = Convert.ToDateTime(Request.Form["dateText"]);


            //// CHECK FUNCTIONALITY. DESCRIPTION SAYS "starting at a certain date" not "time"
            DataTable dtbl = loadStadiums(startDate);

            if (dtbl.Rows.Count == 0)
            {
                MessageBox.Show("There are no available stadiums on this day.", "Whoops!");
            }
        }

        protected void hostBtn_Click(object sender, EventArgs e)
        {
            string matchTime =  (sender as Button).CommandArgument.ToString();

            GridViewRow row = (GridViewRow)(sender as Button).NamingContainer;

            gvUpcomingMatches.SelectedIndex = row.RowIndex;

            gvAvailStadiums.SelectedIndex = -1;
            gvAvailStadiums.AutoGenerateSelectButton = true;

            confirmReqBtn.Visible = false;

            loadStadiums(Convert.ToDateTime(matchTime));
        }

        protected void gvAvailStadiums_SelectedIndexChanged(object sender, EventArgs e)
        {
            confirmReqBtn.Visible = true;
        }

        protected void confirmReqBtn_Click(object sender, EventArgs e)
        {
            SqlCommand addHostReq = new SqlCommand("addHostRequest", Login.conn);
            addHostReq.CommandType = CommandType.StoredProcedure;
            addHostReq.Parameters.Add(new SqlParameter("@club_name",gvUpcomingMatches.SelectedRow.Cells[0].Text));
            addHostReq.Parameters.Add(new SqlParameter("@stadium_name", gvAvailStadiums.SelectedRow.Cells[1].Text));
            addHostReq.Parameters.Add(new SqlParameter("@start_time", gvUpcomingMatches.SelectedRow.Cells[2].Text));

            Login.conn.Open();
            addHostReq.ExecuteNonQuery();
            Login.conn.Close();

            MessageBox.Show("Host Request Confirmed!", "Yay!");

            Response.Redirect("ClubRep.aspx?username=" + username);

        }
    }
}