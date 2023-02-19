using System;
using System.Collections.Generic;
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
                MessageBox.Show("Please enter all fields.");
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
                MessageBox.Show("Account created successfully!");

            }



        }
    }
}