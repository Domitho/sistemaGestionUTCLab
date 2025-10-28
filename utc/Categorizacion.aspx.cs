using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using utc.Models;
using utc.Settigns;
using System.Data.SqlClient;

namespace utc
{
    public partial class Categorizacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                mostrarRegistrosGrilla();
                mostrarDocentes();
                mostrarDocentesEdit();
                obtenerFecha();
                ddlDocente.SelectedIndex = 0;
                if (Session["Username"] == null)
                {

                    Response.Redirect("login.aspx");

                }
            }

        }
        private void obtenerFecha()
        {
            

            // Obtener la fecha actual
            DateTime fechaActual = DateTime.Now;

            // Asignar la fecha actual al control correspondiente
            txtFechaCat.Text = fechaActual.ToString("yyyy-MM-ddTHH:mm");

        }

    

        private void mostrarDocentes()
        {
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccDocente>("SELECT * FROM[INVESTIGACION].[dbo].[INVGCCDOCENTE]");

            foreach (var docente in result1)
            {
                // Concatenar nombre y apellido
                docente.strApellidos_doc = $"{docente.strNombres_doc} {docente.strApellidos_doc}";
            }

            ddlDocente.DataSource = result1;
            ddlDocente.DataTextField = "strApellidos_doc";
            ddlDocente.DataValueField = "strId_doc";
            ddlDocente.DataBind();
        }

        private void mostrarDocentesEdit()
        {
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccDocente>("SELECT * FROM[INVESTIGACION].[dbo].[INVGCCDOCENTE]");

            foreach (var docente in result1)
            {
                // Concatenar nombre y apellido
                docente.strApellidos_doc = $"{docente.strNombres_doc} {docente.strApellidos_doc}";
            }

            ddlEditDocente.DataSource = result1;
            ddlEditDocente.DataTextField = "strApellidos_doc";
            ddlEditDocente.DataValueField = "strId_doc";
            ddlEditDocente.DataBind();
        }

        private void mostrarRegistrosGrilla()
        {
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccDocente>("SELECT d.[strId_doc], d.[strCedula_doc], d.[strApellidos_doc], d.[strNombres_doc], d.[strFacultad_doc], d.[strCarrera_doc], d.[strFuncion_doc], c.[strId_cat], c.[dtFecha_cat], c.[strCategorizacion] FROM[INVESTIGACION].[dbo].[INVGCCDOCENTE] d INNER JOIN[INVESTIGACION].[dbo].[INVGCCCATEGORIA] c ON d.[strId_doc] = c.[fkId_doc] where c.[strEstado_cat]='activo'");

            gvwListadoCat.DataSource = result1;
            gvwListadoCat.DataBind();

            obtenerFecha();
        }

        //private void mostrarRegistrosGrillaDelete()
        //{
        //    var server2 = ConnectionSqlServer.Instance;
        //    var result1 = server2.SelectSql<InvgccDocente>("SELECT d.[strId_doc], d.[strCedula_doc], d.[strApellidos_doc], d.[strNombres_doc], d.[strFacultad_doc], d.[strCarrera_doc], d.[strFuncion_doc], c.[strId_cat], c.[dtFecha_cat], c.[strFechaBorrar_cat] , c.[strCategorizacion] FROM[INVESTIGACION].[dbo].[INVGCCDOCENTE] d INNER JOIN[INVESTIGACION].[dbo].[INVGCCCATEGORIA] c ON d.[strId_doc] = c.[fkId_doc] where c.[strEstado_cat]='inactivo'");

        //    gvwGrillaDelete.DataSource = result1;
        //    gvwGrillaDelete.DataBind();

        //    obtenerFecha();
        //}


        protected void btnRegresarCat_Click(object sender, EventArgs e)
        {
            pnlGrilla.Visible = true;
            pnlAgregrarCat.Visible = false;
            btnRegresarCat.Visible = false;
            pnlEditarCat.Visible = false;
            //lbtPapelera.Visible = true;
            lbtNuevoCat.Visible = true;
        }

        protected void lbtNuevoCat_Click(object sender, EventArgs e)
        {
            pnlGrilla.Visible = false;
            pnlAgregrarCat.Visible = true;
            btnRegresarCat.Visible=true;
            lbtNuevoCat.Visible = false;
            //lbtPapelera.Visible = false;
        }

        protected void btnEditarCat_Click(object sender, EventArgs e)
        {
            pnlEditarCat.Visible = true;
            //lbtPapelera.Visible = true;
            pnlGrilla.Visible = false;
            pnlAgregrarCat.Visible = false;
            lbtNuevoCat.Visible = false;
            //lbtPapelera.Visible = false;

            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;

            codigo.Text = row.Cells[0].Text;

            var server2 = ConnectionSqlServer.Instance;
            var result4 = server2.SelectSql<InvgccCategoria>($"SELECT * FROM INVGCCCATEGORIA WHERE strId_cat = '{codigo.Text}'");

            if (result4.Count > 0)
            {
                InvgccCategoria Categoria = result4[0]; // Suponiendo que el resultado es una lista y solo deseas el primer elemento

                ddlEditCat.ClearSelection(); // Limpia cualquier selección previa
                string valorSeleccionado = Categoria.strCategorizacion; // Valor que deseas asignar

                // Verifica si el valor seleccionado está presente en la lista de opciones del DropDownList
                ListItem itemSeleccionado = ddlEditCat.Items.FindByValue(valorSeleccionado);
                if (itemSeleccionado != null)
                {
                    itemSeleccionado.Selected = true; // Selecciona el valor encontrado
                }
                else
                {
                    // El valor no está presente en la lista, puedes manejar este caso según tus necesidades
                    // Por ejemplo, mostrar un mensaje de error o asignar un valor por defecto
                }

                ddlEditDocente.ClearSelection(); // Limpia cualquier selección previa
                string valorSeleccionado2 = Categoria.fkId_doc; // Valor que deseas asignar

                // Verifica si el valor seleccionado está presente en la lista de opciones del DropDownListChosen
                if (ddlEditDocente.Items.FindByValue(valorSeleccionado2) != null)
                {
                    ddlEditDocente.SelectedValue = valorSeleccionado2; // Selecciona el valor encontrado
                }
                else
                {
                    // El valor no está presente en la lista, puedes manejar este caso según tus necesidades
                    // Por ejemplo, mostrar un mensaje de error o asignar un valor por defecto
                }

                txtEditFechaCat.Text = Categoria.dtFecha_cat.ToString("yyyy-MM-ddTHH:mm");

            }
        }

        protected void btnBorrarCat_Click(object sender, EventArgs e)
        {
            try
            {
                var server3 = ConnectionSqlServer.Instance;

                codigo.Visible = false;
                GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;
                codigo.Text = row.Cells[0].Text;
                string foraneo = row.Cells[1].Text;

                // Utilizar el método server3.Delete para eliminar el registro de la tabla
                if (server3.Delete("INVGCCCATEGORIA", $"strId_cat = '{codigo.Text}'"))
                {
                    Msg("Registro eliminado con éxito", "SS", "SISTEMA INTEGRADO DE GESTIÓN");
                    codigo.Text = "Registro eliminado con éxito";
                    pnlGrilla.Visible = true;
                    mostrarRegistrosGrilla();
                    pnlEditarCat.Visible = false;
                    btnRegresarCat.Visible = false;
                    lbtNuevoCat.Visible = true;
                }
                else
                {
                    codigo.Text = "Error al eliminar, posible registro asociado a otra entidad...";
                    Msg("Registro tiene relación con otros registros..", "ww", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                }
            }
            catch (Exception ex)
            {
                codigo.Text = "Error al eliminar, posible registro asociado a otra entidad...";
                Msg("Registro tiene relación con otros registros..", "ww", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }
        }


        protected void lbtADDCat_Click(object sender, EventArgs e)
        {
            try
            {
                var server1 = ConnectionSqlServer.Instance;

                string connectionString = @"server=DESKTOP-A925LIU\SQLEXPRESS2019;database=INVESTIGACION;INTEGRATED SECURITY=true";
                string query = $"SELECT COUNT(*) FROM [INVESTIGACION].[dbo].INVGCCCATEGORIA WHERE fkId_doc = '{ddlDocente.SelectedValue}'";
                int count = 0;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand(query, connection);
                    connection.Open();
                    count = (int)command.ExecuteScalar();
                }

               

                // Si el resultado tiene algún elemento, significa que el docente ya tiene una categorización
                if (count > 0)
                {
                    Msg("Docente ya tiene asociada una categoría...", "ii", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    return;
                }
                else
                {

                //    // Obtener el resultado del conteo
                //    int count = result.Count();

                //// Si el conteo es mayor a cero, significa que el docente ya tiene una categorización
                //if (count > 0)
                //{
                //    Msg("Docente ya tiene asociada una categoria...", "ii", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                //    return;
                //}
                //else
                //{

              

                //var server1 = ConnectionSqlServer.Instance;

                // Consultar el último valor utilizado en strId_cen
                var query1 = "SELECT TOP 1 strId_cat FROM [INVESTIGACION].[dbo].INVGCCCATEGORIA ORDER BY CAST(SUBSTRING(strId_cat, 4, LEN(strId_cat)) AS INT) DESC";
                var ultimoCentro = server1.SelectSql<InvgccCategoria>(query1).FirstOrDefault();
                string ultimoId = ultimoCentro?.strId_cat;

                // Extraer el número del último valor utilizado
                int ultimoNumero = 0;
                if (!string.IsNullOrEmpty(ultimoId) && ultimoId.Length > 3)
                {
                    int.TryParse(ultimoId.Substring(3), out ultimoNumero);
                }

                // Incrementar el número en 1
                int nuevoNumero = ultimoNumero + 1;

                // Generar el nuevo valor de strId_cen
                string nuevoId = "CAT" + nuevoNumero;

                InvgccCategoria categoria = new InvgccCategoria
                {
                    strId_cat = nuevoId,
                    strCategorizacion = ddlCat.SelectedValue.ToString(),
                    dtFecha_cat = Convert.ToDateTime(txtFechaCat.Text.ToString()),
                    fkId_doc = ddlDocente.SelectedValue.ToString()
                };

                
                server1.Insert("INVGCCCATEGORIA", categoria);
                Msg("Registro Exitoso", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                pnlAgregrarCat.Visible = false;
                mostrarRegistrosGrilla();
                pnlGrilla.Visible = true;
                    btnRegresarCat.Visible = false;
                    lbtNuevoCat.Visible = true;
                    //lbtPapelera.Visible = true;

                    limpiarCat();
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.ToString();
            }
        }




        //public bool VerificarDocenteCategoria(string docenteId)
        //{
        //    var server1 = ConnectionSqlServer.Instance;

        //    // Verificar si el docente ya tiene una categorización asociada
        //    string query = $"SELECT COUNT(*) FROM [INVESTIGACION].[dbo].INVGCCCATEGORIA WHERE fkId_doc = '{codigo.Text}'";
        //    var result = server1.SelectSql<InvgccDocente>(query);

        //    // Obtener el resultado del conteo
        //    int count = result.Count();

        //    // Si el conteo es mayor a cero, significa que el docente ya tiene una categorización
        //    return count > 0;
        //}






        private void Msg(string msg, string tipo, string titulo)
        {
            titulo = titulo.ToUpper();
            switch (tipo.ToUpper())
            {
                case "II":
                    ScriptManager.RegisterStartupScript(this, GetType(), "toastr_message", "toastr.info('" + msg + "', '" + titulo + "');", true);
                    break;
                case "WW":
                    ScriptManager.RegisterStartupScript(this, GetType(), "toastr_message", "toastr.warning('" + msg + "', '" + titulo + "');", true);
                    break;
                case "EE":
                    ScriptManager.RegisterStartupScript(this, GetType(), "toastr_message", "toastr.error('" + msg + "', '" + titulo + "');", true);
                    break;
                case "SS":
                    ScriptManager.RegisterStartupScript(this, GetType(), "toastr_message", "toastr.success('" + msg + "', '" + titulo + "');", true);
                    break;
                default:
                    ScriptManager.RegisterStartupScript(this, GetType(), "toastr_message", "toastr.error('" + msg + " ** error de invocación a la función **" + "', '" + titulo + "');", true);
                    break;
            }

        }
        void limpiarCat()
        {
            txtFechaCat.Text = "";
            ddlCat.ClearSelection();
            ddlDocente.ClearSelection();
        }

        protected void lbtCancelarCat_Click(object sender, EventArgs e)
        {
            pnlGrilla.Visible = true;
            pnlAgregrarCat.Visible = false;
            btnRegresarCat.Visible = false;
            lbtNuevoCat.Visible = true;
            //lbtPapelera.Visible = true;
        }

        protected void lbtnEditCat_Click(object sender, EventArgs e)
        {
            if (ddlEditDocente.SelectedValue != "" || txtEditFechaCat.Text != "" || ddlEditCat.SelectedValue != "")
            {//esta lleno
             /////update
                var server3 = ConnectionSqlServer.Instance;

                InvgccCategoria gru1 = new InvgccCategoria
                {
                    strCategorizacion = ddlEditCat.SelectedValue,
                    dtFecha_cat = Convert.ToDateTime(txtEditFechaCat.Text),
                    fkId_doc = ddlEditDocente.SelectedValue

                };

                if (server3.Update("INVGCCCATEGORIA", gru1, $"strId_cat = '{codigo.Text}'"))
                {
                    Msg("Registro Actualizado con éxito", "SS", "SISTEMA INTEGRADO DE GESTIÓN");
                    codigo.Text = "Registro Actualizado con éxito";
                    pnlGrilla.Visible = true;
                    mostrarRegistrosGrilla();
                    pnlEditarCat.Visible = false;
                    btnRegresarCat.Visible = false;
                    lbtNuevoCat.Visible = true;
                    //lbtPapelera.Visible = true;

                    // Limpiar los campos de edición

                }
            }
            else
            {//esta vacio
                Msg("Error llene todos los campos", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }
            }

        protected void lbtnCancellEditCat_Click(object sender, EventArgs e)
        {
            btnRegresarCat.Visible = false;
            pnlGrilla.Visible = true;
            pnlEditarCat.Visible = false;
            pnlAgregrarCat.Visible = false;
            lbtNuevoCat.Visible = true;
            mostrarRegistrosGrilla();
            //lbtPapelera.Visible = true;
        }

        protected void lbtPapelera_Click(object sender, EventArgs e)
        {
            btnRegresarCat.Visible = false;
            pnlGrilla.Visible = false;
            pnlEditarCat.Visible = false;
            pnlAgregrarCat.Visible = false;
            lbtNuevoCat.Visible = false;
            pnlGrillaDelete.Visible = true;
            //mostrarRegistrosGrillaDelete();
        }

        protected void btnBorrarCatDef_Click(object sender, EventArgs e)
        {

        }
    }
}