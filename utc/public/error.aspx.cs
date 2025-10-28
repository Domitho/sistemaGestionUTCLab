using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class publico_error : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       if( Request.Params["err"].ToString()!= null)
        {
            switch (Request.Params["err"].ToString())
            {

                case "0":
                    lblMsg.Text = "no tiene privilegios para este proceso";
                    break;
                case "1":
                    lblMsg.Text = "el alumno no está vinculado a una carrera.. debe inscribirse.";
                    break;
                case "2":
                    lblMsg.Text = "alumno no encontrado..";
                    break;
                case "3":
                    lblMsg.Text = "usuario bloqueado, debe haber sobrepasado el número de intentos para ingresar al sistema..";
                    break;
                case "4":
                    lblMsg.Text = "No existe mail para este usuario..póngase en contacto con el administrador del ssitema";
                    break;
                case "5":
                    lblMsg.Text = "La carrera o centro de idioma seleccionado, solo permite realizar la matrícula por ventanilla en la secretaría de carrera correspondiente!";
                    break;
                case "6":
                    lblMsg.Text = "El paraleo de la carrera o centro de idioma seleccionado, solo permite realizar la matrícula por ventanilla en la secretaría de carrera correspondiente!";
                    break;
                case "7":
                    lblMsg.Text = "Fechas de evaluación docente fuera de rango. Intente en otras fechas de acuerdo al calendario académico";
                    break;
                default:
                    lblMsg.Text = "error inesperado póngase en contacto con el admin del sistema..";
                    break;
            }
        }
    }

    protected void lnkbLogin_Click(object sender, EventArgs e)
    {
       // FormsAuthentication.SignOut();
        Response.Redirect("/sigutc/academic/private/Default.aspx");
    }
}