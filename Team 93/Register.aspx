<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="SportsWeb.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
    <style>
    table, th, td {
        /*        border: 1px solid black;*/
        text-align: center;
    }
    #bg {
        background-image: url('img/bg.png');
        position: fixed;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-size: cover;
        filter: blur(5px);
        border: 1px solid red;

        z-index:-100;
    }

    body {
        font: verdana;
        font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        justify-content: center;
        align-items: center;
        text-align: center;
        display: flex;
        color: white;
    }

    .myGridStyle {
        border-collapse: collapse;
    }
    .myGridStyle tr th {
        padding: 8px;
        color: white;
        border: 1px solid black;
        background-color: #1C5E55;
    }

    .myGridStyle tr:nth-child(even) {
            background-color: #E3EAEB;
            color: black;
        }

        .myGridStyle tr:nth-child(odd) {
            background-color: #f8fafa;
            color: black;
        }

    .myGridStyle td {
        border: 1px solid black;
        padding: 8px;
    }
    .myGridStyle tr:last-child td {
    }

</style>
<body>
    <div id="bg"></div>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:DropDownList ID="userDropDown" runat="server" style="margin-top:100px">
            <asp:ListItem>Choose a User Type</asp:ListItem>
            <asp:ListItem>Sports Association Manager</asp:ListItem>
            <asp:ListItem>Club Representative</asp:ListItem>
            <asp:ListItem>Stadium Manager</asp:ListItem>
            <asp:ListItem>Fan</asp:ListItem>
        </asp:DropDownList>
        <p>
            <asp:Button ID="registerBtn" runat="server" Text="Register" OnClick="registerBtn_Click" />
        </p>
    </form>
</body>
</html>
