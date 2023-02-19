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
    public partial class SystemAdmin : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            string username = Request.QueryString["username"];
        }

        protected void addnewclub(object sender, EventArgs e)
        {

            String clubname = clubnameB.Text;
            String clubLocation = clublocationB.Text;

            SqlCommand addClubProc = new SqlCommand("addClub", Login.conn);
            addClubProc.CommandType = CommandType.StoredProcedure;
            addClubProc.Parameters.Add(new SqlParameter("@clubname", clubname));
            addClubProc.Parameters.Add(new SqlParameter("@clubLocation", clubLocation));
            if (clubnameB.Text == "" || clublocationB.Text == "")
            {
                MessageBox.Show("Fill Both Boxes With The Required Information");
            }
            else
            {
                Login.conn.Open();
                addClubProc.ExecuteNonQuery();
                MessageBox.Show("Updated!");
                Login.conn.Close();
            }
        }

        protected void deleteclubbox(object sender, EventArgs e)
        {
            
            if (deleteclubB.Text == "")
            {
                MessageBox.Show("Fill The Boxes With The Required Information");
            }
            else
            {
                String deleteclub1 = deleteclubB.Text;

                SqlCommand deleteClubProc = new SqlCommand("deleteClub", Login.conn);
                deleteClubProc.CommandType = CommandType.StoredProcedure;
                deleteClubProc.Parameters.Add(new SqlParameter("@clubName", deleteclub1));

                Login.conn.Open();
                deleteClubProc.ExecuteNonQuery();
                MessageBox.Show("Updated!");
                Login.conn.Close();
            }
        }
        protected void stadadd(object sender, EventArgs e)
        {

            if (stadname.Text == "" || stadloc.Text == "" || stadcap.Text == "")
            {
                MessageBox.Show("Fill The Boxes With The Required Information");
            }
            else
            {
                String addStad = stadname.Text;
                String addStadloc = stadloc.Text;
                int cap = Int16.Parse(stadcap.Text);

                SqlCommand addStadProc = new SqlCommand("addStadium", Login.conn);
                addStadProc.CommandType = CommandType.StoredProcedure;
                addStadProc.Parameters.Add(new SqlParameter("@stadiumname", addStad));
                addStadProc.Parameters.Add(new SqlParameter("@stadiumlocation", addStadloc));
                addStadProc.Parameters.Add(new SqlParameter("@stadiumcapacity", cap));


                Login.conn.Open();
                addStadProc.ExecuteNonQuery();
                MessageBox.Show("Updated!");
                Login.conn.Close();
            }
        }

        protected void staddelete(object sender, EventArgs e)
        {

            String addStad1 = stadname1.Text;

            SqlCommand deleteStadProc = new SqlCommand("deleteStadium", Login.conn);
            deleteStadProc.CommandType = CommandType.StoredProcedure;
            deleteStadProc.Parameters.Add(new SqlParameter("@stadiumname", addStad1));
            if (stadname1.Text == "")
            {
                MessageBox.Show("Fill The Boxes With The Required Information");
            }
            else
            {
                Login.conn.Open();
                deleteStadProc.ExecuteNonQuery();
                MessageBox.Show("Updated!");
                Login.conn.Close();
            }
        }

        protected void fanblock(object sender, EventArgs e)
        {

            String fanid1 = fanid.Text;

            SqlCommand deleteStadProc = new SqlCommand("blockFan", Login.conn);
            deleteStadProc.CommandType = CommandType.StoredProcedure;
            deleteStadProc.Parameters.Add(new SqlParameter("@national_id", fanid1));

            if (fanid.Text == "")
            {
                MessageBox.Show("Fill The Boxes With The Required Information");
            }
            else
            {
                Login.conn.Open();
                deleteStadProc.ExecuteNonQuery();
                MessageBox.Show("Updated!");
                Login.conn.Close();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}