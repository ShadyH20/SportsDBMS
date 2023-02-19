using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportsWeb
{
    public partial class ViewNoClash : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["connection1"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand clashed = new SqlCommand("ViewClashed", conn);
            clashed.CommandType = CommandType.StoredProcedure;
            conn.Open();
            SqlDataReader reader = clashed.ExecuteReader(CommandBehavior.CloseConnection);
            while (reader.Read())
            {
                String Club1 = reader.GetString(reader.GetOrdinal("club1"));
                String Club2 = reader.GetString(reader.GetOrdinal("club2"));
                Label lbl = new Label();
                lbl.Text = "<tr> <td> Host Club: <br/>" + Club1 + " </td>" +
                    "<br/> <td> Guest Club:<br/>" + Club2 + " </td> </tr> <br/>";
                NevermatchesPH.Controls.Add(lbl);

            }
            conn.Close();
            reader.Close();
        }
    }
}