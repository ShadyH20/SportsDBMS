using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace SportsWeb
{
    public partial class Register : System.Web.UI.Page
    {
        public static SqlConnection conn = Login.conn;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void registerBtn_Click(object sender, EventArgs e)
        {
            string userType = userDropDown.SelectedValue;
            if(userType.Equals("Choose a User Type"))
            {
                MessageBox.Show("Please choose a user type.");
            }
            else
            {
                switch (userType)
                {
                    case "Sports Association Manager":
                        Response.Redirect("RegisterPages/SAManagerRegister.aspx");
                        break;
                    case "Club Representative":
                        Response.Redirect("RegisterPages/ClubRepRegister.aspx");
                        break;
                    case "Stadium Manager":
                        Response.Redirect("RegisterPages/StadManagerRegister.aspx");
                        break;
                    case "Fan":
                        Response.Redirect("RegisterPages/FanRegister.aspx");
                        break;
                }

                ///// GO TO USER PAGE
            }
        }
    }
}