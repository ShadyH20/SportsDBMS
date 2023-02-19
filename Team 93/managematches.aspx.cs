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
    public partial class managematches : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddMatch_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["connection1"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String clubH = TextBox1.Text;
            String clubG = TextBox2.Text;
            String Start = TextBox3.Text;
            String End = TextBox4.Text;

            SqlCommand checkClubs = new SqlCommand("AllClubNames", conn);
            checkClubs.CommandType = CommandType.StoredProcedure;
            checkClubs.Parameters.Add(new SqlParameter("@clubname1", clubH));
            checkClubs.Parameters.Add(new SqlParameter("@clubname2", clubG));

            SqlParameter res = checkClubs.Parameters.Add(new SqlParameter("@bool", SqlDbType.Bit));
            res.Direction = ParameterDirection.Output;


            conn.Open();
            checkClubs.ExecuteNonQuery();
            if (res.Value.ToString() == "True")
            {
                SqlCommand addmatch = new SqlCommand("addNewMatch", conn);
                addmatch.CommandType = CommandType.StoredProcedure;

                addmatch.Parameters.Add(new SqlParameter("@hostClubName", clubH));
                addmatch.Parameters.Add(new SqlParameter("@guestClubName", clubG));
                addmatch.Parameters.Add(new SqlParameter("@startTime", Start));
                addmatch.Parameters.Add(new SqlParameter("@endTime", End));

                addmatch.ExecuteNonQuery();
                conn.Close();
                MessageBox.Show("Match added successfully!");

            }
            else
            {
                MessageBox.Show("Enter Existing Clubs");
            }

        }

        protected void deletematchbutton(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["connection1"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String clubH = TextBox5.Text;
            String clubG = TextBox6.Text;

            SqlCommand checkClubs = new SqlCommand("AllClubNames", conn);
            checkClubs.CommandType = CommandType.StoredProcedure;
            checkClubs.Parameters.Add(new SqlParameter("@clubname1", clubH));
            checkClubs.Parameters.Add(new SqlParameter("@clubname2", clubG));

            SqlParameter res = checkClubs.Parameters.Add(new SqlParameter("@bool", SqlDbType.Bit));
            res.Direction = ParameterDirection.Output;


            conn.Open();
            checkClubs.ExecuteNonQuery();
            //check if match exists, if it doesnt inform the user//
            if (res.Value.ToString() == "True")
            {
                SqlCommand addmatch = new SqlCommand("deleteMatch", conn);
                addmatch.CommandType = CommandType.StoredProcedure;
                addmatch.Parameters.Add(new SqlParameter("@hostclub", clubH));
                addmatch.Parameters.Add(new SqlParameter("@guestclub", clubG));
                addmatch.ExecuteNonQuery();
                conn.Close();
                MessageBox.Show("Match deleted successfully!");

            }
            else
            {
                MessageBox.Show("Enter Existing Clubs");
            }

        }

        protected void viewsB_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewWhat.aspx");
        }
    }
}