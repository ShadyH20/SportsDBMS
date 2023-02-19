using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportsWeb
{
    public partial class SportsASSManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ManageMatches_Click(object sender, EventArgs e)
        {
            Response.Redirect("managematches.aspx");
        }

        protected void ViewsShow(object sender, EventArgs e)
        {
            Response.Redirect("ViewWhat.aspx");
        }
    }
}