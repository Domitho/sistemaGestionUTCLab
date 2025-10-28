using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Account_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void LoginButton_Click2(object sender, EventArgs e)
    {
        //// Obtén el nombre de usuario y contraseña ingresados
        //string username = UserName.Text.Trim();
        //string password = Password.Text;

        //// Intenta autenticar al usuario
        //if (Membership.ValidateUser(username, password))
        //{
        //    // Redirige al usuario autenticado a la página deseada
        //    FormsAuthentication.RedirectFromLoginPage(username, false);
        //    Response.Redirect("/academic/pruebas/prueba1.aspx");
        //}
        //else
        //{
        //    // Muestra un mensaje de error si la autenticación falla
        //    lblMsg.Text = "Usuario o contraseña incorrectos.";
        //}
    }
}
