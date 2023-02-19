<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewNoClash.aspx.cs" Inherits="SportsWeb.ViewNoClash" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <style> body {
                background-image: url("img/3.png");
                background-blend-mode:soft-light;
                background-repeat:repeat;
                background-size: cover;
                text-align: left;
                
            }
        #form1 {
            margin-left: 680px;
        }
    </style>
    <form id="form2" runat="server">
        <div style="margin-left:150px">
            <asp:Button ID="ManageMatches" runat="server" Font-Size="Large" Height="107px" style="color:red; background-color:transparent; " Text="Manage Matches" Width="294px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="viewsB" runat="server" Font-Size="Large" Height="107px" style="margin-top: 0px;color:red;background-color:transparent" Text="View Matches" Width="294px" />
        </div>
        
    
        
        <p style="margin-left: 680px">
        
    
        
        Clubs That Never Matched:<br />
        </p>
        <table style="width: 397px; margin-left: 680px;">
            <asp:PlaceHolder ID="NevermatchesPH" runat="server"></asp:PlaceHolder>
            <tr>
                <td>
                    <br />
                </td>
            </tr>
        </table>
        
    </form>
    <asp:Table ID="Table1" runat="server" Height="166px" Width="305px">
    </asp:Table>
</body>
</html>
