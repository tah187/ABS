<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="True" CodeBehind="Manage_Rooms.aspx.cs" 
    Inherits="ABS.Admin.Manage_Rooms" Theme="Admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Manage Confrence Rooms</h2>
        <p>This page allows you to manage the existing Confrence Rooms in the Appointment Booking System. Click the "New Confrence Room" link to create a a new Confrence Room or click the "Edit" Button to edit an existing Confrence Room. </p>
        <br /><asp:Label ID="Error" runat="server" Text="Click the Select Link to Edit a Room"></asp:Label>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
            DataKeyNames="Id" DataSourceID="BookingObjects" Width="423px">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" 
                    ReadOnly="True" SortExpression="Id" />
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                <asp:CommandField ShowSelectButton="True" />
            </Columns>
        </asp:GridView>

    </p>
    <p>

        <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="421px" 
            DataSourceID="BookingObjectsDetailed" onItemUpdating="DetailsView1_ItemUpdating"
            OnItemCreated="DetailsView1_ItemCreated" onItemUpdated="DetailsView1_ItemUpdated"
            AutoGenerateRows="False" DefaultMode="Edit" DataKeyNames="Id">

            <Fields>
                <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" 
                    InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                <asp:TemplateField HeaderText="StartTime" SortExpression="StartTime">
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlStart" runat="server" 
                            SelectedValue='<%# Bind("StartTime", "{0}") %>'>                      
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("StartTime") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="EndTime" SortExpression="EndTime">
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlEnd" runat="server" 
                            SelectedValue='<%# Bind("EndTime", "{0}") %>'>                      
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("EndTime") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    
                    <EditItemTemplate>
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                            OnItemCreated="GridView2_ItemCreated" onrowdatabound="GridView2_RowDataBound"
                            DataKeyNames="Id" DataSourceID="AvailableDays" style="margin-right: 43px" 
                            Width="299px">
                            
                            <Columns>
                                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="Id" Visible="False" />
                                <asp:BoundField DataField="Description" HeaderText="Description" 
                                    SortExpression="Description" />

                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="AvailabilityCheck" runat="server" />
                                    </ItemTemplate>

                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>

                        <asp:SqlDataSource ID="AvailableDays" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ABSConnectionString %>" 
                            SelectCommand="SELECT * FROM [WorkingDay]" >
                            </asp:SqlDataSource>
                    </EditItemTemplate>
                    
                </asp:TemplateField>

                <asp:CommandField ShowEditButton="True" />
            </Fields>
        </asp:DetailsView>
    </p>
    

    <asp:SqlDataSource ID="BookingObjects" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ABSConnectionString %>" 
        SelectCommand="SELECT * FROM [BookingObject]" >
    </asp:SqlDataSource>

    <asp:SqlDataSource 
        ConnectionString= "<%$ ConnectionStrings:ABSConnectionString %>"
        ID="BookingObjectsDetailed" runat="server"  
        SelectCommand="SELECT Id, Title, CAST(StartTime AS Time) AS StartTime, CAST(EndTime AS Time) AS EndTime
            FROM [BookingObject] WHERE [BookingObject].Id = @Id"
        UpdateCommand="UPDATE [BookingObject] SET [Title] = @Title, [StartTime] = @StartTime, 
            [EndTime] = @EndTime WHERE [Id] = @Id" >

        <SelectParameters>
            <asp:ControlParameter Name="Id" ControlId="GridView1" Type="Int32"
                PropertyName="SelectedValue" />
        </SelectParameters>

        <UpdateParameters>
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="StartTime" Type="DateTime" />
            <asp:Parameter Name="EndTime" Type="DateTime" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>

    </asp:SqlDataSource>
 



</asp:Content>
