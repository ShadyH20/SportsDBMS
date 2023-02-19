<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClubRep.aspx.cs" Inherits="SportsWeb.ClubRep" EnableEventValidation="false" %>

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

    body {
        font: verdana;
        font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        justify-content: center;
        align-items: center;
        text-align: center;
        display: flex
    }

    .myBtn {
        margin-top: 30px;
        padding: 10px;
        font-size: 15px;
        font-weight: 600;
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
        }

        .myGridStyle tr:nth-child(odd) {
            background-color: #f8fafa;
        }

        .myGridStyle td {
            border: 1px solid black;
            padding: 8px;
        }

        .myGridStyle tr:last-child td {
        }
</style>
<body>
    <form id="form1" runat="server">
        <h2 id="title">Club Representative <%=username%></h2>
        <table>
            <tr>
                <td style="padding-top: 40px">
                    <h3>Club Info</h3>
                </td>
            </tr>
            <tr>
                <td style="justify-content: center; display: flex">
                    <asp:GridView class="myGridStyle" ID="gvClubInfo" runat="server" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="club_name" HeaderText="Club Name" />
                            <asp:BoundField DataField="location" HeaderText="Location" />
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td style="padding-top: 40px">
                    <h3>Upcoming Matches</h3>
                </td>
            </tr>
            <tr>
                <td style="justify-content: center; display: flex">
                    <asp:GridView class="myGridStyle" ID="gvUpcomingMatches" runat="server" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="host_club" HeaderText="Host Club" />
                            <asp:BoundField DataField="guest_club" HeaderText="Guest Club" />
                            <asp:BoundField DataField="start_time" HeaderText="Start Time" />
                            <asp:BoundField DataField="end_time" HeaderText="End Time" />
                            <asp:BoundField DataField="stadium_name" HeaderText="Stadium" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="hostBtn" runat="server" Text="Request Hosting"
                                        Visible='<%# Eval("host_club").ToString() == clubName%>'
                                        Enabled='<%# Eval("stadium_name").ToString() == ""%>'
                                        OnClick="hostBtn_Click" CommandArgument='<%# Eval("start_time")%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <SelectedRowStyle BackColor="#818281" ForeColor="White" />
                    </asp:GridView>
                </td>
            </tr>

            <tr>
                <td style="padding-top: 40px">
                    <h3>Available Stadiums</h3>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="datetime-local" id="dateText" name="dateText" />
                    <asp:Button ID="availMatchesBtn" runat="server" Text="View" OnClick="viewAvailableStadiums" />
                </td>
            </tr>
            <tr>
                <td style="justify-content: center; display: flex">
                    <asp:GridView class="myGridStyle" ID="gvAvailStadiums" runat="server" AutoGenerateColumns="false" OnSelectedIndexChanged="gvAvailStadiums_SelectedIndexChanged">
                        <Columns>
                            <asp:BoundField DataField="stadium_name" HeaderText="Stadium" />
                            <asp:BoundField DataField="location" HeaderText="Location" />
                            <asp:BoundField DataField="capacity" HeaderText="Capacity" />
                        </Columns>
                        <SelectedRowStyle BackColor="#818281" ForeColor="White" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button class="myBtn" ID="confirmReqBtn" runat="server" Text="Confirm Host Request"
                        Visible="false" OnClick="confirmReqBtn_Click"/>
            </tr>
        </table>
        <br />
    </form>
</body>
</html>
