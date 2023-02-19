<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StadManager.aspx.cs" Inherits="SportsWeb.StadManager" %>

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
        <h2 id="title">Stadium Manager | <%=username%></h2>
        <table>
            <tr>
                <td style="padding-top: 40px">
                    <h3>Stadium Info</h3>
                </td>
            </tr>
            <tr>
                <td style="justify-content: center; display: flex">
                    <asp:GridView class="myGridStyle" ID="gvStadInfo" runat="server" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="stadium_name" HeaderText="Stadium Name" />
                            <asp:BoundField DataField="location" HeaderText="Location" />
                            <asp:BoundField DataField="capacity" HeaderText="Capacity" />
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td style="padding-top: 40px">
                    <h3>All Received Requests</h3>
                </td>
            </tr>
            <tr>
                <td style="justify-content: center; display: flex">
                    <asp:GridView class="myGridStyle" ID="gvRequests" runat="server" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="Representative" HeaderText="Club Representative" />
                            <asp:BoundField DataField="Host" HeaderText="Host Club" />
                            <asp:BoundField DataField="Guest" HeaderText="Guest Club" />
                            <asp:BoundField DataField="start_time" HeaderText="Start Time" />
                            <asp:BoundField DataField="end_time" HeaderText="End Time" />
                            <%--<asp:BoundField DataField="approved" HeaderText="Status" />--%>
                            <asp:TemplateField HeaderText="Status" SortExpression="Active">
                                <ItemTemplate><%# Eval("approved").ToString()==""? "Pending" : (Boolean.Parse(Eval("approved").ToString())) ? "Accepted" : "Rejected" %></ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="acceptBtn" runat="server" Text="Accept"
                                        Visible='<%# Eval("approved").ToString()==""%>'
                                        OnClick="acceptBtn_Click" CommandArgument='<%# Eval("start_time")%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="rejectBtn" runat="server" Text="Reject"
                                        Visible='<%# Eval("approved").ToString()==""%>'
                                        OnClick="rejectBtn_Click" CommandArgument='<%# Eval("start_time")%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <SelectedRowStyle BackColor="#818281" ForeColor="White" />
                    </asp:GridView>
                </td>
            </tr>

        </table>
        <br />
    </form>
</body>
</html>
