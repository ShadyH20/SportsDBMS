using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace SportsWeb
{
    public partial class Login : System.Web.UI.Page
    {
        public static string connString = WebConfigurationManager.ConnectionStrings["connection1"].ToString();
        public static SqlConnection conn = new SqlConnection(connString);
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginUser(object sender, EventArgs e)
        {
            string username = usernameInput.Text;
            string password = Request.Form["passwordInput"];

            if (username == "" | password == "")
            {
                MessageBox.Show("Please fill all fields.");
            }
            else
            {
                SqlCommand checkUser = new SqlCommand("checkUser", conn);
                checkUser.CommandType = CommandType.StoredProcedure;

                checkUser.Parameters.Add(new SqlParameter("@username", username));
                checkUser.Parameters.Add(new SqlParameter("@password", password));
                SqlParameter res = checkUser.Parameters.Add(new SqlParameter("@res", SqlDbType.Bit));
                res.Direction = ParameterDirection.Output;

                conn.Open();
                checkUser.ExecuteNonQuery();
                conn.Close();

                if(res.Value.ToString() == "False")
                {
                    MessageBox.Show("This user does not exist.");
                }
                else
                {
                    SqlCommand userType = new SqlCommand("userType", conn);
                    userType.CommandType = CommandType.StoredProcedure;
                    
                    userType.Parameters.Add(new SqlParameter("@username", username));
                    SqlParameter type = userType.Parameters.Add(new SqlParameter("@type", SqlDbType.VarChar,20));
                    type.Direction = ParameterDirection.Output;
                    conn.Open();
                    userType.ExecuteNonQuery();
                    conn.Close();

                    
                    
                    switch (type.Value.ToString())
                    {
                        case "ADMIN":
                            Response.Redirect("SystemAdmin.aspx?username="+username);
                            break;
                        case "SAM":
                            Response.Redirect("SportsASSManager.aspx?username=" + username);
                            break;
                        case "STM":
                            Response.Redirect("StadManager.aspx?username=" + username);
                            break;
                        case "CR":
                            Response.Redirect("ClubRep.aspx?username=" + username);
                            break;
                        case "FAN":
                            SqlCommand checkBlocked = new SqlCommand("SELECT dbo.checkFanBlocked(@username)", Login.conn);
                            checkBlocked.CommandType = CommandType.Text;
                            checkBlocked.Parameters.Add(new SqlParameter("@username", username));
                            Login.conn.Open();
                            Boolean blocked = (Boolean)checkBlocked.ExecuteScalar();
                            Login.conn.Close();
                            if (blocked)
                            {
                                MessageBox.Show("Sorry! Your account is blocked!", "Warning!");

                            }
                            else
                            {
                                MessageBox.Show("Not blocked :)");
                                Response.Redirect("Fan.aspx?username=" + username);
                            }
                            break;
                    }

                }

                

            }






        }
    }
}