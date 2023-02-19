<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SportsASSManager.aspx.cs" Inherits="SportsWeb.SportsASSManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <style> body {
                background-image: url("img/1.png");
                background-blend-mode:soft-light;
                background-repeat:repeat;
                background-size: cover;
                text-align: left;
                
            }</style>
    <form id="form1" runat="server">
        <div style="margin-left: 150px" >
           

            <asp:Button ID="ManageMatches" runat="server" Height="107px" Text="Manage Matches" Width="294px" style="color:red; background-color:transparent; " Font-Size="Large" OnClick="ManageMatches_Click" />
           

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           

            <asp:Button ID="viewsB" runat="server" style="margin-top: 0px;color:red;background-color:transparent" Text="View Matches" Width="294px" Height="107px" Font-Size="Large" OnClick="ViewsShow"/>
           

        </div>
    </form>
</body>
</html>
