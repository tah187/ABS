<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage_Appointments.aspx.cs" 
Inherits="ABS.Admin.Manage_Appointments"  Theme="Admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Manage Appointments</h2>
    <p>This page allows you to view all the appointments that have been made for the selceted date. Click the calendar icon and then choose a date from the calendar.</p>
      
    <div id="Calendar">
        <asp:Calendar ID="Calendar1" runat="server" autopostback="true" 
            onSelectionChanged="Calendar_Change" style="text-align: center" Width="455px"></asp:Calendar>
        <p>
            <asp:Label ID="DateSelected" runat="server" Text=""></asp:Label>
        </p>
    </div>

    <div>
    
    
        <asp:ListView ID="ListView1" runat="server" onItemCanceling="Appointments_ItemCanceling"
            onItemEditing="Appointments_ItemEditing"  onItemUpdating="Appointments_ItemUpdating"
            DataKeyNames="Id">
            <AlternatingItemTemplate>
                <span style="">Id:
                <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                <br />
                UserName:
                <asp:Label ID="UserNameLabel" runat="server" Text='<%# Eval("UserName") %>' />
                <br />
                UserEmailAddress:
                <asp:Label ID="UserEmailAddressLabel" runat="server" 
                    Text='<%# Eval("UserEmailAddress") %>' />
                <br />
                StartDate:
                <asp:Label ID="StartDateLabel" runat="server" Text='<%# Eval("StartDate") %>' />
                <br />
                EndDate:
                <asp:Label ID="EndDateLabel" runat="server" Text='<%# Eval("EndDate") %>' />
                <br />
                Comments:
                <asp:Label ID="CommentsLabel" runat="server" Text='<%# Eval("Comments") %>' />
                <br />
                BookingObjectId:
                <asp:Label ID="BookingObjectIdLabel" runat="server" 
                    Text='<%# Eval("BookingObjectId") %>' />
                <br />
                <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                <br />
                <br />
                </span>
            </AlternatingItemTemplate>
            
            <EditItemTemplate>
                <span style="">Id:
                <asp:Label ID="IdLabel1" runat="server" Text='<%# Eval("Id") %>' />
                <br />
                UserName:
                <asp:TextBox ID="UserNameTextBox" runat="server" 
                    Text='<%# Eval("UserName") %>' />
                <br />
                UserEmailAddress:
                <asp:TextBox ID="UserEmailAddressTextBox" runat="server" 
                    Text='<%# Eval("UserEmailAddress") %>' />
                <br />
                StartDate:
                <asp:TextBox ID="StartDateTextBox" runat="server" 
                    Text='<%# Eval("StartDate") %>' />


                <br />
                EndDate:
                <asp:TextBox ID="EndDateTextBox" runat="server" Text='<%# Eval("EndDate") %>' />
                
                      


                <br />
                Comments:
                <asp:TextBox ID="CommentsTextBox" runat="server" 
                    Text='<%# Eval("Comments") %>' />
                <br />
                BookingObjectId:
                <asp:TextBox ID="BookingObjectIdTextBox" runat="server" 
                    Text='<%# Eval("BookingObjectId") %>' />
                <br />
                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                    Text="Update" />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                    Text="Cancel" />
                <br />
                <br />
                </span>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <span>Select a Date.</span>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <span style="">UserName:
                <asp:TextBox ID="UserNameTextBox" runat="server" 
                    Text='<%# Bind("UserName") %>' />
                <br />
                UserEmailAddress:
                <asp:TextBox ID="UserEmailAddressTextBox" runat="server" 
                    Text='<%# Bind("UserEmailAddress") %>' />
                <br />
                StartDate:
                <asp:TextBox ID="StartDateTextBox" runat="server" 
                    Text='<%# Bind("StartDate") %>' />
                <br />
                EndDate:
                <asp:TextBox ID="EndDateTextBox" runat="server" Text='<%# Bind("EndDate") %>' />
                <br />
                Comments:
                <asp:TextBox ID="CommentsTextBox" runat="server" 
                    Text='<%# Bind("Comments") %>' />
                <br />
                BookingObjectId:
                <asp:TextBox ID="BookingObjectIdTextBox" runat="server" 
                    Text='<%# Bind("BookingObjectId") %>' />
                <br />
                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                    Text="Insert" />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                    Text="Clear" />
                <br />
                <br />
                </span>
            </InsertItemTemplate>
            <ItemTemplate>
                <span style="">Id:
                <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                <br />
                UserName:
                <asp:Label ID="UserNameLabel" runat="server" Text='<%# Eval("UserName") %>' />
                <br />
                UserEmailAddress:
                <asp:Label ID="UserEmailAddressLabel" runat="server" 
                    Text='<%# Eval("UserEmailAddress") %>' />
                <br />
                StartDate:
                <asp:Label ID="StartDateLabel" runat="server" Text='<%# Eval("StartDate") %>' />
                <br />
                EndDate:
                <asp:Label ID="EndDateLabel" runat="server" Text='<%# Eval("EndDate") %>' />
                <br />
                Comments:
                <asp:Label ID="CommentsLabel" runat="server" Text='<%# Eval("Comments") %>' />
                <br />
                BookingObjectId:
                <asp:Label ID="BookingObjectIdLabel" runat="server" 
                    Text='<%# Eval("BookingObjectId") %>' />
                <br />
                <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                <br />
                <br />
                </span>
            </ItemTemplate>
            <LayoutTemplate>
                <div ID="itemPlaceholderContainer" runat="server" style="">
                    <span runat="server" id="itemPlaceholder" />
                </div>
                <div style="">
                </div>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <span style="">Id:
                <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                <br />
                UserName:
                <asp:Label ID="UserNameLabel" runat="server" Text='<%# Eval("UserName") %>' />
                <br />
                UserEmailAddress:
                <asp:Label ID="UserEmailAddressLabel" runat="server" 
                    Text='<%# Eval("UserEmailAddress") %>' />
                <br />
                StartDate:
                <asp:Label ID="StartDateLabel" runat="server" Text='<%# Eval("StartDate") %>' />
                <br />
                EndDate:
                <asp:Label ID="EndDateLabel" runat="server" Text='<%# Eval("EndDate") %>' />
                <br />
                Comments:
                <asp:Label ID="CommentsLabel" runat="server" Text='<%# Eval("Comments") %>' />
                <br />
                BookingObjectId:
                <asp:Label ID="BookingObjectIdLabel" runat="server" 
                    Text='<%# Eval("BookingObjectId") %>' />
                <br />
                <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                <br />
                <br />
                </span>
            </SelectedItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource 
            ConnectionString= "<%$ ConnectionStrings:ABSConnectionString %>"
            ID="Appointments" runat="server" OnSelecting="Appointments_Selecting"
            SelectCommand="SELECT * FROM [Appointment] WHERE [StartDate] BETWEEN @StartDate AND @EndDate"
            DeleteCommand="DELETE FROM [Appointment] WHERE [Id] = @Id" 
            InsertCommand="INSERT INTO [Appointment] ([UserName], [UserEmailAddress], [StartDate], [EndDate], [Comments], [BookingObjectId]) VALUES (@UserName, @UserEmailAddress, @StartDate, @EndDate, @Comments, @BookingObjectId)" 
            UpdateCommand="UPDATE [Appointment] SET [UserName] = @UserName, [UserEmailAddress] = @UserEmailAddress, [StartDate] = @StartDate, [EndDate] = @EndDate, [Comments] = @Comments, [BookingObjectId] = @BookingObjectId WHERE [Id] = @Id">
            
            <SelectParameters>
                <asp:Parameter Name="StartDate" Type="DateTime" DefaultValue="01/01/2000"/>
                <asp:Parameter Name="EndDate" Type="DateTime" DefaultValue="01/01/2000"/>
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="UserName" Type="String" />
                <asp:Parameter Name="UserEmailAddress" Type="String" />
                <asp:Parameter Name="StartDate" Type="DateTime" />
                <asp:Parameter Name="EndDate" Type="DateTime" />
                <asp:Parameter Name="Comments" Type="String" />
                <asp:Parameter Name="BookingObjectId" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="UserName" Type="String" />
                <asp:Parameter Name="UserEmailAddress" Type="String" />
                <asp:Parameter Name="StartDate" Type="DateTime" />
                <asp:Parameter Name="EndDate" Type="DateTime" />
                <asp:Parameter Name="Comments" Type="String" />
                <asp:Parameter Name="BookingObjectId" Type="Int32" />
                <asp:Parameter Name="Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    
    </div>
    


</asp:Content>
