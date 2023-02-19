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
                MessageBox.Show("Please fill in all fields.", "Warning");
            }
            else
            {
                ////// CHECK IF USERNAME ALREADY EXISTS

                SqlCommand addFan = new SqlCommand("addFan", Login.conn);
                addFan.CommandType = System.Data.CommandType.StoredProcedure;
                addFan.Parameters.Add(new SqlParameter("@name", name));
                addFan.Parameters.Add(new SqlParameter("@username", username));
                addFan.Parameters.Add(new SqlParameter("@password", password));
                addFan.Parameters.Add(new SqlParameter("@nationalId",nationalID));
                addFan.Parameters.Add(new SqlParameter("@birthDate", bDate));
                addFan.Parameters.Add(new SqlParameter("@address", address));
                addFan.Parameters.Add(new SqlParameter("@phone", phone));
                Login.conn.Open();
                addFan.ExecuteNonQuery();
                Login.conn.Close();
                MessageBox.Show("Account created successfully!");

                Response.Redirect("FanRegister.aspx");

            }
        }
    }
}