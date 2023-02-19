<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewWhat.aspx.cs" Inherits="SportsWeb.ViewWhat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <style> body {
                background-image: url("img/4.png");
                background-blend-mode:soft-light;
                background-repeat:repeat;
                background-size: cover;
                text-align: left;
                
            }
        .auto-style1 {
            width: 288px;
            margin-left: 800px;
        }
    </style>
    <form id="form1" runat="server">
        <div style="margin-left:150px">
            <asp:Button ID="ManageMatches" runat="server" Font-Size="Large" Height="107px" style="color:red; background-color:transparent; " Text="Manage Matches" Width="294px" OnClick="ManageMatches_Click" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="viewsB" runat="server" Font-Size="Large" Height="107px" style="margin-top: 0px;color:red;background-color:transparent" Text="View Matches" Width="294px" />
        </div>
        <p class="auto-style1">
            &nbsp;</p>
        <p class="auto-style1">
            &nbsp;<asp:Button ID="Button1" runat="server" Height="144px" Text="View Upcoming Matches" Width="279px" style="background-color:gold" OnClick="Button1_Click"/>
        <br />
        <br />
        <br />
        <br />
        <br />
        <asp:Button ID="Button2" runat="server" Height="144px" Text="View Played Matches" Width="279px" style="background-color:gold" OnClick="Button2_Click"/>
        <br />
        <br />
        <br />
        <br />
        <br />
        <asp:Button ID="Button3" runat="server" Height="144px" Text="View None Clashing Clubs" Width="279px" style="background-color:gold" OnClick="Button3_Click"/>
        <br />
        
        <br />
            </p>
        <br />
        <br />
        <br />
    </form>
</body>
</html>
