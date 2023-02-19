using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace SportsWeb.RegisterPages
{
    public partial class FanRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register(object sender, EventArgs e)
        {
            string name = nameText.Text;
            string username = usernameText.Text;
            string password = Request.Form["passwordText"];
            string nationalID = nationalIDText.Text;
            string phone = Request.Form["phoneText"];
            string bDate = Request.Form["bdateText"];
            string address = addressText.Text;

            if (name == "" || username == "" || password == "" || nationalID == ""
                || phone == "" || bDate == "" || address == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please fill in all fields.');", true);
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

                    SqlCommand addFan = new SqlCommand("addFan", Login.conn);
                    addFan.CommandType = System.Data.CommandType.StoredProcedure;
                    addFan.Parameters.Add(new SqlParameter("@name", name));
                    addFan.Parameters.Add(new SqlParameter("@username", username));
                    addFan.Parameters.Add(new SqlParameter("@password", password));
                    addFan.Parameters.Add(new SqlParameter("@nationalId", nationalID));
                    addFan.Parameters.Add(new SqlParameter("@birthDate", bDate));
                    addFan.Parameters.Add(new SqlParameter("@address", address));
                    addFan.Parameters.Add(new SqlParameter("@phone", phone));
                    Login.conn.Open();
                    addFan.ExecuteNonQuery();
                    Login.conn.Close();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Account created successfully!');", true);

                    Response.Redirect("../Login.aspx");
                }

            }
        }
    }
}