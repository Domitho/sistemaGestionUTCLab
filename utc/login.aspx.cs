using System;
using System.Data.SqlClient;
using System.Web.Security;

namespace utc
{
    public partial class login : System.Web.UI.Page
    {
        private object roleName;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Verifica si hay un parámetro de error en la URL
                if (!string.IsNullOrEmpty(Request.QueryString["error"]) && Request.QueryString["error"] == "authentication")
                {
                    LblMsg.Text = "Usuario o contraseña incorrectos.";
                }
            }
        }

        protected void LoginButton_Click2(object sender, EventArgs e)
        {
            string connectionString = "Data Source=DESKTOP-A925LIU\\SQLEXPRESS2019;database=INVESTIGACION;INTEGRATED SECURITY=true";
            string username = UserName.Text.Trim();
            string password = Password.Text;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT COUNT(*) FROM Users WHERE Username = @Username AND Password = @Password";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    command.Parameters.AddWithValue("@Password", password);

                    int count = Convert.ToInt32(command.ExecuteScalar());

                    if (count > 0)
                    {
                        // Autenticación exitosa

                        // Aquí obtienes los roles del usuario
                        //string[] roles = Roles.GetRolesForUser(username);

                        // Asignar roles al usuario (esto es un ejemplo, debes ajustar esto según tu modelo de roles)
                   

                        // Almacena la información del usuario en la sesión
                        Session["Username"] = username;
                        //Session["Roles"] = roles;

                        // Redirige al usuario a la página deseada
                        Response.Redirect("dashboard.aspx");
                    }
                    else
                    {
                        // Autenticación fallida
                        LblMsg.Text = "Usuario o contraseña incorrectos.";
                        // Limpia la sesión
                        Session.Clear();
                        // Redirige al usuario a la página de inicio de sesión con el mensaje de error
                        Response.Redirect("login.aspx?error=authentication");
                    }
                }
            }
        }

    }

}
