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
            conn.Open();
            conn.Close();
        }

        protected void loginUser(object sender, EventArgs e)
        {
            string username = usernameInput.Text;
            string password = Request.Form["passwordInput"];

            if (username == "" | password == "")
            {
                //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please fill all fields.");
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please fill all fields.');", true);
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
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('This user does not exist.');", true);
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
                            SqlCommand checkBlocked = new SqlCommand("SELECT dbo.checkFanBlocked(@username)", conn);
                            checkBlocked.CommandType = CommandType.Text;
                            checkBlocked.Parameters.Add(new SqlParameter("@username", username));
                            conn.Open();
                            Boolean blocked = (Boolean)checkBlocked.ExecuteScalar();
                            conn.Close();
                            if (blocked)
                            {
                                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Sorry! Your account is blocked!');", true);

                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Not blocked :)');", true);
                                Response.Redirect("Fan.aspx?username=" + username);
                            }
                            break;
                    }

                }

                

            }






        }
    }
}