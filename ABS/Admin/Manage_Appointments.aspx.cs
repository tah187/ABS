using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace ABS.Admin
{
			public partial class Manage_Appointments : System.Web.UI.Page
			{

						void Page_PreInit(object sender, System.EventArgs e)
						{
									Page.Theme = "Admin";
						}

						protected void Page_Load(object sender, EventArgs e)
						{

						}

						protected void Calendar_Change(Object sender, EventArgs e)
						{
									DateSelected.Text = "You selected: " +
												Calendar1.SelectedDate.ToShortDateString();

									//Bind Data to ListView
									ListView1.DataSource = Appointments;
									ListView1.DataBind();

						}

						protected void Appointments_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
						{
									if (Calendar1.SelectedDate.Date.Year != 1)
									{
												DateTime StartTime = Calendar1.SelectedDate.Date.Add(new TimeSpan(0, 0, 0));
												DateTime EndTime = Calendar1.SelectedDate.Date.Add(new TimeSpan(23, 59, 59));

												e.Command.Parameters["@StartDate"].Value = StartTime.ToString("yyyy-MM-dd HH:mm:ss");
												e.Command.Parameters["@EndDate"].Value = EndTime.ToString("yyyy-MM-dd HH:mm:ss");
									}
									

						}

						protected void Appointments_ItemEditing(object sender, ListViewEditEventArgs e)
						{
									ListView1.EditIndex = e.NewEditIndex;
									ListView1.DataSource = Appointments;
									ListView1.DataBind();
						}

						protected void Appointments_ItemUpdating(object sender, ListViewUpdateEventArgs e)
						{
									ListViewItem item = ListView1.Items[ListView1.EditIndex];

									Appointment editing = new Appointment();
									Label IdLbl = (Label)item.FindControl("IdLabel1");
									String Id = IdLbl.Text;

									TextBox UserNameLbl = (TextBox)item.FindControl("UserNameTextBox");
									String UserName = UserNameLbl.Text;

									TextBox UserEmailAddressLbl = (TextBox)item.FindControl("UserEmailAddressTextBox");
									String UserEmailAddress = UserEmailAddressLbl.Text;

									TextBox StartDateLbl = (TextBox)item.FindControl("StartDateTextBox");
									DateTime StartDate = DateTime.Parse(StartDateLbl.Text);

									TextBox EndDateLbl = (TextBox)item.FindControl("EndDateTextBox");
									DateTime EndDate = DateTime.Parse(EndDateLbl.Text);

									TextBox CommentsLbl = ListView1.Items[ListView1.EditIndex].FindControl("CommentsTextBox") as TextBox;
									String Comments = CommentsLbl.Text;

									TextBox BookingObjectIdLbl = (TextBox)item.FindControl("BookingObjectIdTextBox");
									String BookingObjectId = BookingObjectIdLbl.Text;

									SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ABSConnectionString"].ToString());
									SqlCommand cmd = new SqlCommand("dbo.UpdateAppointment", conn);

									cmd.CommandType = CommandType.StoredProcedure;
									cmd.Parameters.AddWithValue("@Id", Id);
									cmd.Parameters.AddWithValue("@UserName", UserName);
									cmd.Parameters.AddWithValue("@UserEmailAddress", UserEmailAddress);
									cmd.Parameters.AddWithValue("@StartDate", StartDate.ToString("yyyy-MM-dd HH:mm:ss"));
									cmd.Parameters.AddWithValue("@EndDate", EndDate.ToString("yyyy-MM-dd HH:mm:ss"));
									cmd.Parameters.AddWithValue("@Comments", Comments);
									cmd.Parameters.AddWithValue("@BookingObjectId", BookingObjectId);

									conn.Open();
									Int32 rowsAffected;
									rowsAffected = cmd.ExecuteNonQuery();
									conn.Close();

									ListView1.EditIndex = -1;
									ListView1.DataSource = Appointments;
									ListView1.DataBind();

						}

						protected void Appointments_ItemCanceling(object sender, ListViewCancelEventArgs e)
						{
									ListView1.EditIndex = -1;
									ListView1.DataSource = Appointments;
									ListView1.DataBind();
						}
			}
}