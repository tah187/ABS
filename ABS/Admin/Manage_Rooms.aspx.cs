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
			public partial class Manage_Rooms : System.Web.UI.Page
			{

						void Page_PreInit(object sender, System.EventArgs e)
						{
										Page.Theme = "Admin";
						}
						
						protected void Page_Load(object sender, EventArgs e)
						{
	
						}

						protected void DetailsView1_ItemCreated(object sender, EventArgs e)
						{
									TimeSpan startTime = new TimeSpan(7,0,0);
									TimeSpan increment = new TimeSpan(1,0,0);
 								TimeSpan[] timeList = new TimeSpan[14];
								
									//populate array with times incremented by an hour
									for (int i = 0; i <= 13; i++)
									{
												timeList[i] = startTime;
												startTime = startTime.Add(increment);
									}

									DropDownList ddl = DetailsView1.FindControl("ddlStart") as DropDownList;
									if (ddl != null) 
									{
												ddl.DataSource = timeList;
									}

									DropDownList ddl2 = DetailsView1.FindControl("ddlEnd") as DropDownList;
									if (ddl2 != null)
									{
												ddl2.DataSource = timeList;
									}

						}

						protected void DetailsView1_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
						{
									//Cancel Update if EndTime is earlier than StartTime
									DropDownList ddlStart = DetailsView1.FindControl("ddlStart") as DropDownList;
									DropDownList ddlEnd = DetailsView1.FindControl("ddlEnd") as DropDownList;

									TimeSpan StartTime = TimeSpan.Parse(ddlStart.SelectedValue);
									TimeSpan EndTime = TimeSpan.Parse(ddlEnd.SelectedValue);
									
									if (TimeSpan.Compare(EndTime, StartTime) < 0)
									{
												e.Cancel = true;
												Error.Text = "Update Cancelled. End Time is before Start Time";
									}


						}

						protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
						{
									//Update Available days for the Booking Object
									//Get parameters

									int BookingObjectId = Convert.ToInt32(DetailsView1.DataKey.Value);

									//Delete current information
									SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ABSConnectionString"].ToString());
									SqlCommand cmd = new SqlCommand("DELETE FROM BookingObjectWorkingDay WHERE BookingObjectId = @BookingObjectId", conn);
									cmd.Parameters.AddWithValue("@BookingObjectId", BookingObjectId);
								
									conn.Open();
									cmd.ExecuteNonQuery();

									GridView AvailableDays = DetailsView1.FindControl("GridView2") as GridView;

									//Check Availability for each of the days and add to database
									foreach (GridViewRow row in AvailableDays.Rows)
									{
												if (row.RowType == DataControlRowType.DataRow) 
												{
															int WorkingDayId = row.RowIndex + 1; //Set Day
															if (((CheckBox)row.FindControl("AvailabilityCheck")).Checked == true)
															{
																		SqlCommand insertCmd = new SqlCommand("INSERT INTO BookingObjectWorkingDay  (BookingObjectId, WorkingDayId) VALUES (@BookingObjectId, @WorkingDayId)", conn);
																		insertCmd.Parameters.AddWithValue("@BookingObjectId", BookingObjectId);
																		insertCmd.Parameters.AddWithValue("@WorkingDayId", WorkingDayId);
																		insertCmd.ExecuteNonQuery();
															}
												}
									}

									conn.Close();
									Server.Transfer("Manage_Rooms.aspx");
						}

						protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
						{
									//Get parameters for SQL query
									int BookingObjectId = Convert.ToInt32(DetailsView1.DataKey.Value);
									int WorkingDayId = 0;
									DataRowView rowView = (DataRowView)e.Row.DataItem;
									if(e.Row.RowType == DataControlRowType.DataRow)
									{
												WorkingDayId = Convert.ToInt32(rowView["Id"]);
									}

									//Connect to database and run query
									SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ABSConnectionString"].ToString());
									SqlCommand cmd = new SqlCommand("SELECT WorkingDayId FROM BookingObjectWorkingDay WHERE BookingObjectId = @BookingObjectId AND WorkingDayId = @WorkingDayId", conn);
									cmd.Parameters.AddWithValue("@BookingObjectId", BookingObjectId);
									cmd.Parameters.AddWithValue("@WorkingDayId", WorkingDayId);
									conn.Open();
									var reader = cmd.ExecuteReader();
									
									CheckBox c = e.Row.Cells[2].FindControl("AvailabilityCheck") as CheckBox;
									
									//Check to see if SQL query returned a result, and set checkbox state
									if(c != null && reader.Read())
									{
												c.Checked = true;
									}

									conn.Close();
						}

						


			}
}