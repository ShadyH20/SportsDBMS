using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace SportsWeb.RegisterPages
{
    public partial class StadManagerRegister : System.Web.UI.Page
    {
        bool noStads;
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlCommand getClubs = new SqlCommand("noManStadiums", Login.conn);
            getClubs.CommandType = System.Data.CommandType.StoredProcedure;
            Login.conn.Open();
            SqlDataReader reader = getClubs.ExecuteReader(CommandBehavior.CloseConnection);
            if (!reader.HasRows)
            {
                Label lbl = new Label();
                lbl.Text = "<option>No Available Stadiums</option>";
                stadsList.Controls.Add(lbl);

                noStads = true;
            }
            else noStads = false;
            while (reader.Read())
            {
                string stadName = reader.GetString(0);

                Label lbl = new Label();
                lbl.Text = "<option>" + stadName + "</option>";
                stadsList.Controls.Add(lbl);
            }
            Login.conn.Close();
            reader.Close();
        }

        protected void Register(object sender, EventArgs e)
        {
            string name = nameText.Text;
            string username = usernameText.Text;
            string password = Request.Form["passwordText"];
            string stad = Request.Form["stadSelect"];

            if (name == "" || username == "" || password == "")
            {
                MessageBox.Show("Please enter all fields.", "Warning");
            }
            else if (noStads)
            {
                MessageBox.Show("There are no available Stadiums to manage.", "Warning");
            }
            else
            {
                ////// CHECK IF USERNAME ALREADY EXISTS

                SqlCommand addStadMan = new SqlCommand("addStadiumManager", Login.conn);
                addStadMan.CommandType = System.Data.CommandType.StoredProcedure;
                addStadMan.Parameters.Add(new SqlParameter("@name", name));
                addStadMan.Parameters.Add(new SqlParameter("@stadium_name", stad));
                addStadMan.Parameters.Add(new SqlParameter("@username", username));
                addStadMan.Parameters.Add(new SqlParameter("@password", password));
                Login.conn.Open();
                addStadMan.ExecuteNonQuery();
                Login.conn.Close();
                MessageBox.Show("Account created successfully!");

                Response.Redirect("StadManagerRegister.aspx");

            }
        }
    }
}