using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;
using System.Data;

namespace SportsWeb.RegisterPages
{
    public partial class ClubRepRegister : System.Web.UI.Page
    {
        private bool noClubs;
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlCommand getClubs = new SqlCommand("noRepClubs", Login.conn);
            getClubs.CommandType = System.Data.CommandType.StoredProcedure;
            Login.conn.Open();
            SqlDataReader reader = getClubs.ExecuteReader(CommandBehavior.CloseConnection);
            if (!reader.HasRows)
            {
                Label lbl = new Label();
                lbl.Text = "<option>No Available Clubs</option>";
                clubsList.Controls.Add(lbl);

                noClubs = true;
            }
            else noClubs = false;
            while (reader.Read())
            {
                string clubName = reader.GetString(0);

                Label lbl = new Label();
                lbl.Text = "<option>" + clubName + "</option>";
                clubsList.Controls.Add(lbl);
            }
            Login.conn.Close();
            reader.Close();
        }

        protected void Register(object sender, EventArgs e)
        {
            string name = nameText.Text;
            string username = usernameText.Text;
            string password = Request.Form["passwordText"];
            string club = Request.Form["clubSelect"];

            if (name == "" || username == "" || password == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please enter all fields.');", true);
            }
            else if (noClubs)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('There are no available Clubs to represent.');", true);
            }
            else
            {
                ////// CHECK IF USERNAME ALREADY EXISTS
                SqlCommand checkUser = new SqlCommand("SELECT dbo.checksExistsUser(@username)", Login.conn);
                checkUser.CommandType = CommandType.Text;
                checkUser.Parameters.Add(new SqlParameter("@username", username));
                Login.conn.Open();
                Boolean res = (Boolean)checkUser.ExecuteScalar();
                Login.conn.Close();
                if (res)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('This username already exists.');", true);

                }
                else
                {
                    SqlCommand addClubRep = new SqlCommand("addRepresentative", Login.conn);
                    addClubRep.CommandType = System.Data.CommandType.StoredProcedure;
                    addClubRep.Parameters.Add(new SqlParameter("@name", name));
                    addClubRep.Parameters.Add(new SqlParameter("@club_name", club));
                    addClubRep.Parameters.Add(new SqlParameter("@username", username));
                    addClubRep.Parameters.Add(new SqlParameter("@password", password));
                    Login.conn.Open();
                    addClubRep.ExecuteNonQuery();
                    Login.conn.Close();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Account created successfully!');", true);

                    Response.Redirect("../Login.aspx");
                }

            }
        }
    }
}