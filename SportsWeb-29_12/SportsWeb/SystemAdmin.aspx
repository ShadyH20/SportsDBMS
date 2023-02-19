<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemAdmin.aspx.cs" Inherits="SportsWeb.SystemAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="color:black"> <style>body {
                background-image: url("messi captain.jfif");
                background-blend-mode:soft-light;
                background-repeat:repeat;
                background-size: cover;
                text-align: left;
                
            }</style>
    <form id="form1" runat="server">
        <div class="1">
            Fill The Boxes With The Required Information!<br /></div>
            <br />
        <div class="2">
            Add A Club:<br />
            <br />
            Club Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="clubnameB" runat="server"  BorderColor="white"></asp:TextBox>
            <br />
            <br />
        
        Club Location:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="clublocationB" runat="server" BorderColor="White"></asp:TextBox>
        <br />
        <asp:Button ID="addclub" runat="server" Height="50px" Text="Add Club" OnClick="addnewclub" Width="150px" BackColor="Gold" />
            </div>
        <br />
        <br />
    Delete A Club:
        <br /> 
        Club Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="deleteclubB" runat="server" OnTextChanged="deleteclubbox" BorderColor="White"></asp:TextBox>
&nbsp;<p>
            <asp:Button ID="Button1" runat="server" Text="Delete Club" Height ="50px" Width="150px" BackColor ="Gold" OnClick="Button1_Click"/>
        </p>
        <p>
            &nbsp;</p>
        <p>
            Add A Stadium:</p>
        <p>
            Stadium Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="stadname" runat="server" BorderColor="White"></asp:TextBox>
        </p>
        <p>
            Stadium Location:
            <asp:TextBox ID="stadloc" runat="server" BorderColor="White"></asp:TextBox>
        </p>
        <p>
            Stadium Capacity:
            <asp:TextBox ID="stadcap" runat="server" BorderColor="White"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button2" runat="server" Text="Add Stadium" Height ="50px" Width="150px" BackColor="Gold" OnClick="stadadd" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            Delete A Stadium:</p>
        <p>
            Stadium Name:&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="stadname1" runat="server" BorderColor="White"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="deletestad" runat="server" Text="Delete Stadium" Height ="50px" Width="150px" BackColor="Gold" OnClick="staddelete" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            Block OM EL FAN:</p>
        <p>
            Insert Fan ID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="fanid" runat="server" BorderColor="White"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="blockfan" runat="server" Text="Block Fan" Height ="50px" Width="150px" BackColor="Gold" OnClick="fanblock" />
        </p>
    </form>
    </body>
</html>
