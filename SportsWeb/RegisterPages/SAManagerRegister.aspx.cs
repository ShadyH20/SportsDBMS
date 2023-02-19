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
    public partial class SAManagerRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register(object sender, EventArgs e)
        {
            string name = nameText.Text;
            string username = usernameText.Text;
            string password = Request.Form["passwordText"];

            if(name == "" || username == "" | password == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please enter all fields.');", true);
            }
            else
            {
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
                    SqlCommand addSAM = new SqlCommand("addAssociationManager", Login.conn);
                    addSAM.CommandType = System.Data.CommandType.StoredProcedure;
                    addSAM.Parameters.Add(new SqlParameter("@name", name));
                    addSAM.Parameters.Add(new SqlParameter("@UserName", username));
                    addSAM.Parameters.Add(new SqlParameter("@password", password));
                    Login.conn.Open();
                    addSAM.ExecuteNonQuery();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Account created successfully!');", true);
                    Response.Redirect("../Login.aspx");
                }
            }



        }
    }
}