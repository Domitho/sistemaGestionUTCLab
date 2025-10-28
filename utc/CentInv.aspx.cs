using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using utc.Models;
using System.IO;
using utc.Settigns;
using System.Globalization;

namespace utc
{
    public partial class CentInv : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                mostrarRegistrosGrilla();
                cargarFechas();
                buscarGrupos();
                if (Session["Username"] == null)
                {

                    Response.Redirect("login.aspx");

                }

            }
        }
        void cargarFechas()
        {
            DateTime fecha = DateTime.Now;

            // Asignar los valores de fecha formateados a las cajas de texto (TextBox)
            txtFechaIniAdd.Text = fecha.ToString("yyyy-MM-ddTHH:mm");
            txtFechaFinAdd.Text = fecha.AddDays(15).ToString("yyyy-MM-ddTHH:mm");
        }
        void mostrarMiembrosAsociados(string aux)
        {
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccMiembros>($"SELECT M.[strId_mie], M.[strFuncion_mie], M.[dtFechaini_mie], M.[dtFechafin], G.[strId_gru], G.[strNombre_gru], G.[strCoordinador_gru], G.[dtFechacrea_gru], C.[strId_cen], C.[strNombre_cen], C.[strDescripcion_cen], C.[strObservacion_cen] FROM[INVESTIGACION].[dbo].[INVGCCMIEMBROS] AS M INNER JOIN[INVESTIGACION].[dbo].[INVGCCGRUPO_INVESTIGACION] AS G ON M.[fkIdGru] = G.[strId_gru] INNER JOIN[INVESTIGACION].[dbo].[INVGCCCENTRO_INESTIGACION] AS C ON M.[fkId_cen] = C.[strId_cen] where m.fkId_cen='{aux}' "); /// filtra todo

            gvwMiembros.DataSource = result1;
            gvwMiembros.DataBind();
        }
        public void mostrarRegistrosGrilla()
        {

            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.Select<InvccCentInv>("INVGCCCENTRO_INESTIGACION"); /// filtra todo

            gvwListadoCentInv.DataSource = result1;
            gvwListadoCentInv.DataBind();

        }

        private string GetSavePathForCentro(string fileExtension)
        {
            string dia = DateTime.Now.Day.ToString("00");
            string hora = DateTime.Now.Hour.ToString("00");
            string minuto = DateTime.Now.Minute.ToString("00");
            string segundo = DateTime.Now.Second.ToString("00");
            string savePath = "INSCRIPCION" + "-";
            string path1 = @"c://FILESUTC/0/UTC/CENTRO INVESTIGACION/"; // RUTA FISICA
            string fileName = $"Centro-Investigacion-{dia}-{hora}-{minuto}-{segundo}{fileExtension}";
            return System.IO.Path.Combine(path1, fileName);
        }
        public void guardarCenInv()
        {
            try
            {
                if (txtCentInvFileAdd.HasFile)
                {
                    string fileName = Server.HtmlEncode(txtCentInvFileAdd.FileName);
                    string extension = System.IO.Path.GetExtension(fileName);
                    if (extension == ".pdf" || extension == ".xlsx" || extension == ".xls")
                    {
                        string savePath = GetSavePathForCentro(extension);

                        txtCentInvFileAdd.SaveAs(savePath);
                        // es pdf
                        codigo.Text = fileName + " guardado exitosamente...";
                        codigo.Visible = false;


                        var server1 = ConnectionSqlServer.Instance;

                        // Consultar el último valor utilizado en strId_cen
                        var query = "SELECT TOP 1 strId_cen FROM INVGCCCENTRO_INESTIGACION ORDER BY CAST(SUBSTRING(strId_cen, 4, LEN(strId_cen)) AS INT) DESC";
                        var ultimoCentro = server1.SelectSql<InvccCentInv>(query).FirstOrDefault();
                        string ultimoId = ultimoCentro?.strId_cen;

                        // Extraer el número del último valor utilizado
                        int nuevoNumero = 1; // Por defecto, si no hay registros previos, se comenzará con CEN1

                        if (!string.IsNullOrEmpty(ultimoId) && ultimoId.Length > 3)
                        {
                            int ultimoNumero = 0;
                            if (int.TryParse(ultimoId.Substring(3), out ultimoNumero))
                            {
                                nuevoNumero = ultimoNumero + 1;
                            }
                        }

                        // Generar el nuevo valor de strId_cen
                        string nuevoId = "CEN" + nuevoNumero;

                        // Aquí puedes continuar con el proceso de inserción utilizando nuevoId


                        InvccCentInv cent = new InvccCentInv
                        {
                            strId_cen = nuevoId,
                            strNombre_cen = txtNombreCen.Text,
                            strDescripcion_cen = txtDescripcionCen.Text,
                            strObservacion_cen = txtObservacionCen.Text,
                            strArchivo_cen = savePath,
                        };

                        server1.Insert("INVGCCCENTRO_INESTIGACION", cent);
                        limpiarCentInv();
                    }
                }
                else
                {
                    Msg("SELECCIONE ARCHIVO", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    return;
                }
            }
            catch (Exception ex)
            {
                Msg("ERROR AL INSERTAR", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }



        }
        private void limpiarCentInv()
        {
            txtNombreCen.Text = "";
            txtDescripcionCen.Text = "";
            txtObservacionCen.Text = "";
        }
        protected void btnRegresarCentInv_Click(object sender, EventArgs e)
        {
            lbtNuevoCentInv.Visible = true;
            btnRegresarCentInv.Visible = false;
            pnlAgregarCentInv.Visible = false;
            pnlGrilla.Visible = true;
            pnlMiembros.Visible = false;
            pnlEditarMiembro.Visible = false;
            pnlADDmiembro.Visible = false;

        }

        protected void lbtNuevoCentInv_Click(object sender, EventArgs e)
        {

            lbtNuevoCentInv.Visible = false;
            btnRegresarCentInv.Visible = true;
            pnlAgregarCentInv.Visible = true;
            pnlGrilla.Visible = false;

        }

        protected void lbtADDCentInv_Click(object sender, EventArgs e)
        {
            try
            {


                if (txtNombreCen.Text != "" || txtDescripcionCen.Text != "" || txtObservacionCen.Text != "")

                {

                    guardarCenInv();
                    mostrarRegistrosGrilla();
                    pnlAgregarCentInv.Visible = false;
                    lbtNuevoCentInv.Visible = true;
                    btnRegresarCentInv.Visible = false;
                    pnlGrilla.Visible = true;
                    codigo.Text = "EXITO AL GUARDAR";
                    limpiarCentInv();
                    Msg("registro exitoso", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");

                }
                else
                {
                    codigo.Text = "ERROR, PARAMETROS VACIOS";
                    Msg("ERROR, PARAMETROS VACIOS", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                }

            }
            catch (Exception)
            {
                codigo.Text = "ERROR AL INSERTAR";
                Msg("ERROR AL INGRESAR ESTE REGISTRO...", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }

        }

        protected void lbtCancelarCentInv_Click(object sender, EventArgs e)
        {
            pnlAgregarCentInv.Visible = false;
            lbtNuevoCentInv.Visible = true;
            btnRegresarCentInv.Visible = false;
            pnlGrilla.Visible = true;


        }

        protected void btnEditarCentInv_Click(object sender, EventArgs e)
        {

            pnlEditarCentnv.Visible = true;
            pnlGrilla.Visible = false;

            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;

            codigo.Text = row.Cells[0].Text;
            fullpath1.Text = row.Cells[1].Text;
            codigo.Visible = true;

            var server2 = ConnectionSqlServer.Instance;
            var result4 = server2.SelectSql<InvccCentInv>($"SELECT * FROM INVGCCCENTRO_INESTIGACION WHERE strId_cen = '{codigo.Text}'");

            if (result4.Count > 0)
            {
                InvccCentInv centroInvestigacion = result4[0]; // Suponiendo que el resultado es una lista y solo deseas el primer elemento

                // Asignar los valores a los campos de edición
                txtEditNombreCentro.Text = centroInvestigacion.strNombre_cen;
                txtEditDescripcionCentro.Text = centroInvestigacion.strDescripcion_cen;
                txtEditObservacionCentro.Text = centroInvestigacion.strObservacion_cen;
            }




        }

        protected void btnBorrarCentInv_Click(object sender, EventArgs e)
        {
            try
            {

                codigo.Visible = true;
                /////delete
                GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;

                codigo.Text = row.Cells[0].Text;
                fullpath1.Text = row.Cells[1].Text;
                if (System.IO.File.Exists(fullpath1.Text))
                {
                    System.IO.FileInfo info = new System.IO.FileInfo(fullpath1.Text);
                    info.Attributes = System.IO.FileAttributes.Normal;
                    System.IO.File.Delete(fullpath1.Text);
                }
                var server4 = ConnectionSqlServer.Instance;
                if (server4.Delete("INVGCCCENTRO_INESTIGACION", $"strId_cen = '{codigo.Text}'"))
                {
                    codigo.Text = "Eliminación correcta";
                    Msg("Eliminación correcta", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    pnlGrilla.Visible = true;
                    mostrarRegistrosGrilla();
                    pnlEditarCentnv.Visible = false;

                }
                else
                {
                    codigo.Text = "Error al eliminar";
                    Msg("Error al eliminar", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                }

            }
            catch (Exception ex)
            {

                codigo.Text = "Error al eliminar, posible registro asociado a otra entidad...";
                Msg("Existen relaciones asociadas", "ww", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }
        }
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

        protected void lbtnEditarCentro_Click(object sender, EventArgs e)
        {
            try
            {
                if (!flpArchivoEdit.HasFile)//no edita archivo
                {



                    /////update
                    var server3 = ConnectionSqlServer.Instance;

                    InvccCentInv conv1 = new InvccCentInv
                    {
                        strNombre_cen = txtEditNombreCentro.Text,
                        strDescripcion_cen = txtEditDescripcionCentro.Text,
                        strObservacion_cen = txtEditObservacionCentro.Text

                    };
                    if (server3.Update("INVGCCCENTRO_INESTIGACION", conv1, $"strId_cen = '{codigo.Text}'"))
                    {
                        Msg("Registro Actualizado con éxito", "SS", "SISTEMA INTEGRADO DE GESTIÓN");
                        codigo.Text = "Registro Actualizado con éxito";
                        pnlGrilla.Visible = true;
                        mostrarRegistrosGrilla();
                        pnlEditarCentnv.Visible = false;

                        // Limpiar los campos de edición
                        txtEditNombreCentro.Text = string.Empty;
                        txtEditDescripcionCentro.Text = string.Empty;
                        txtEditObservacionCentro.Text = string.Empty;
                    }
                }
                else
                {
                    if (System.IO.File.Exists(fullpath1.Text))
                    {
                        System.IO.FileInfo info = new System.IO.FileInfo(fullpath1.Text);
                        info.Attributes = System.IO.FileAttributes.Normal;
                        System.IO.File.Delete(fullpath1.Text);
                    }

                    string fileName = Server.HtmlEncode(flpArchivoEdit.FileName);
                    string extension = System.IO.Path.GetExtension(fileName).ToLower();

                    if (extension == ".xls" || extension == ".xlsx" || extension == ".pdf")
                    {
                        // Procesar el archivo adjunto
                        string savePath = GetSavePathForCentro(extension);
                        flpArchivoEdit.SaveAs(savePath);
                        var server3 = ConnectionSqlServer.Instance;

                        InvccCentInv conv1 = new InvccCentInv
                        {
                            strNombre_cen = txtEditNombreCentro.Text,
                            strArchivo_cen = savePath,
                            strDescripcion_cen = txtEditDescripcionCentro.Text,
                            strObservacion_cen = txtEditObservacionCentro.Text

                        };
                        if (server3.Update("INVGCCCENTRO_INESTIGACION", conv1, $"strId_cen = '{codigo.Text}'"))
                        {
                            Msg("Registro Actualizado con éxito", "SS", "SISTEMA INTEGRADO DE GESTIÓN");
                            codigo.Text = "Registro Actualizado con éxito";
                            pnlGrilla.Visible = true;
                            mostrarRegistrosGrilla();
                            pnlEditarCentnv.Visible = false;

                            // Limpiar los campos de edición
                            txtEditNombreCentro.Text = string.Empty;
                            txtEditDescripcionCentro.Text = string.Empty;
                            txtEditObservacionCentro.Text = string.Empty;
                        }
                    }
                    else
                    {
                        Msg("Solo se admiten archivos pdf o excel", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                    }
                }
            }
            catch (Exception)
            {

                Msg("Error al actualizar", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                codigo.Text = "Error al actualizar";
            }

        }

        protected void lbtnCancellEditCentro_Click(object sender, EventArgs e)
        {
            pnlEditarCentnv.Visible = false;
            pnlGrilla.Visible = true;
        }

        protected void btnVisualizarCentInv_Click(object sender, EventArgs e)
        {
            try
            {
                codigo.Text = "";

                GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;
                codigo.Visible = true;

                string filePath = row.Cells[1].Text; // Obtiene el path por posición de la grilla

                if (File.Exists(filePath))
                {
                    string fileName = "archivo_adjunto" + Path.GetExtension(filePath).ToLower(); // Nombre del archivo en la respuesta

                    Response.Clear();

                    // Verificar la extensión para establecer el tipo de contenido
                    if (Path.GetExtension(filePath).ToLower() == ".pdf")
                    {
                        Response.ContentType = "application/pdf";
                    }
                    else if (Path.GetExtension(filePath).ToLower() == ".xls" || Path.GetExtension(filePath).ToLower() == ".xlsx")
                    {
                        Response.ContentType = "application/vnd.ms-excel";
                    }
                    else
                    {
                        // Tipo de archivo no admitido, manejar el caso como desees (mostrar mensaje de error, redirigir, etc.)
                        codigo.Text = "Tipo de archivo no admitido.";
                        codigo.Visible = true;
                        return;
                    }

                    Response.AddHeader("Content-Disposition", "inline; filename=" + fileName); // Indicar que se debe abrir en línea
                    Response.WriteFile(filePath);
                    Response.Flush();

                    // Agregar el atributo target="_blank" al enlace para abrir en una nueva pestaña
                    Response.Write("<script>window.open('about:blank','_blank');</script>");

                    Response.End();

                    codigo.Text = ""; // Limpiando mensaje
                }
                else
                {
                    // El archivo no existe, manejar el caso como desees (mostrar mensaje de error, redirigir, etc.)
                    codigo.Text = "NO SE PUDO LOCALIZAR ESTE ADJUNTO";
                    codigo.Visible = true;
                    Msg("NO SE PUDO LOCALIZAR ESTE ADJUNTO", "WW", "SISTEMA GENERAL DE INVESTIGACIÓN");
                }
            }
            catch (Exception ex)
            {
                // Manejar excepciones, mostrar mensaje de error, etc.
                codigo.Text = "ERROR AL VISUALIZAR EL ADJUNTO";
                Msg("NO SE PUDO LOCALIZAR ESTE ADJUNTO", "WW", "SISTEMA GENERAL DE INVESTIGACIÓN");
                codigo.Visible = true;
            }
        }

        protected void btnMiembrosCentInv_Click(object sender, EventArgs e)
        {
            pnlGrilla.Visible = false;
            pnlEditarCentnv.Visible = false;
            pnlAgregarCentInv.Visible = false;
            lbtNuevoCentInv.Visible = false;
            lbtNuevoMiembroCentInv.Visible = true;
            pnlMiembros.Visible = true;
            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;
            aux.Text = row.Cells[0].Text;
            mostrarMiembrosAsociados(aux.Text);
        }

        protected void lbtNuevoMiembroCentInv_Click(object sender, EventArgs e)
        {
            pnlMiembros.Visible = false;
            btnRegresarCentInv.Visible = true;
            lbtNuevoMiembroCentInv.Visible = false;
            buscarGrupos();
            pnlADDmiembro.Visible = true;
        }
        void buscarGrupos()
        {
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.Select<InvgccGrupoInvestigacion>("INVGCCGRUPO_INVESTIGACION"); /// filtra todo

            ddlGrupoMiembros.DataSource = result1;
            ddlGrupoMiembros.DataTextField = "strNombre_gru";
            ddlGrupoMiembros.DataValueField = "strId_gru";

            ddlGrupoMiembros.DataBind();
            ddlGrupoEdit.DataSource = result1;
            ddlGrupoEdit.DataTextField = "strNombre_gru";
            ddlGrupoEdit.DataValueField = "strId_gru";

            ddlGrupoEdit.DataBind();

        }

        protected void lbtADDMiembros_Click(object sender, EventArgs e)
        {
            var server1 = ConnectionSqlServer.Instance;

            // Obtener el último ID de miembro utilizado
            var query = "SELECT TOP 1 strId_mie FROM INVGCCMIEMBROS ORDER BY CAST(SUBSTRING(strId_mie, 2, LEN(strId_mie)) AS INT) DESC";
            var ultimoMiembro = server1.SelectSql<InvgccMiembros>(query).FirstOrDefault();
            string ultimoId = ultimoMiembro?.StrIdMie1 ?? "M1";

            // Obtener el número del último ID
            int ultimoNumero = 0;
            if (!string.IsNullOrEmpty(ultimoId) && ultimoId.Length > 1)
            {
                int.TryParse(ultimoId.Substring(1), out ultimoNumero);
            }

            // Incrementar el número para generar el nuevo ID
            int nuevoNumero = ultimoNumero + 1;
            string nuevoId = "M" + nuevoNumero.ToString();

        
            Convert.ToDateTime(txtFechaIniAdd.Text);
            Convert.ToDateTime(txtFechaFinAdd.Text);
            // Verificar que la fecha de fin no sea menor que la fecha de inicio
            if (Convert.ToDateTime(txtFechaFinAdd.Text) < Convert.ToDateTime(txtFechaIniAdd.Text))
            {
                Msg("La fecha de fin no puede ser menor que la fecha de inicio.", "ee", "Error");
                return;
            }

            // Crear un nuevo miembro
            InvgccMiembros miembros = new InvgccMiembros
            {
                StrIdMie1 = nuevoId,
                StrFuncionMie = txtFuncionAdd.Text,
                DtFechaIniMie = Convert.ToDateTime(txtFechaIniAdd.Text),
                DtFechaFin = Convert.ToDateTime(txtFechaFinAdd.Text),
                fkId_cen = aux.Text,
                fkIdGru = ddlGrupoMiembros.SelectedValue,
            };

            // Insertar el nuevo miembro en la base de datos
            server1.Insert("INVGCCMIEMBROS", miembros);

            // Mostrar mensajes y realizar cambios visuales
            Msg("Registro exitoso...", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            pnlADDmiembro.Visible = false;
            pnlMiembros.Visible = true;
            lbtNuevoCentInv.Visible = true;
            mostrarMiembrosAsociados(aux.Text);

            // Limpiar campos
            txtFuncionAdd.Text = string.Empty;
            txtFechaIniAdd.Text = string.Empty;
            txtFechaFinAdd.Text = string.Empty;
            ddlGrupoMiembros.SelectedIndex = 0;
        }

    







        protected void lbtCancellAddMiembros_Click(object sender, EventArgs e)
        {
            pnlMiembros.Visible = true;
            pnlADDmiembro.Visible = false;
            lbtNuevoCentInv.Visible = true;
            mostrarMiembrosAsociados(aux.Text);
            
        }

        protected void btnEditarMiembrosInv_Click(object sender, EventArgs e)
        {
            pnlMiembros.Visible = false;
            lbtNuevoMiembroCentInv.Visible = false;
            lbtNuevoCentInv.Visible = false;
            pnlEditarMiembro.Visible = true;
            btnRegresarCentInv.Visible = true;

            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;

            codigo.Text = row.Cells[0].Text;

            var server2 = ConnectionSqlServer.Instance;
            var result4 = server2.SelectSql<InvgccMiembros>($"SELECT * FROM INVGCCMIEMBROS WHERE strId_mie = '{codigo.Text}'");

            if (result4.Count > 0)
            {
                InvgccMiembros miembros = result4[0]; // Suponiendo que el resultado es una lista y solo deseas el primer elemento

                // Suponiendo que miembros.StrNombreGru es una cadena que contiene el valor a asignar
                string valorAAsignar = miembros.fkIdGru;

                // Validar que el valor no esté vacío antes de asignarlo al control de lista desplegable
                if (!string.IsNullOrEmpty(valorAAsignar))
                {
                    // Si el valor no está vacío, procede a limpiar la selección y asignar el nuevo valor
                    ddlGrupoEdit.ClearSelection();
                    ddlGrupoEdit.SelectedValue = valorAAsignar;
                }
                else
                {
                    // Si el valor está vacío, podrías mostrar un mensaje de error o realizar alguna otra acción.
                    // Por ejemplo, aquí se muestra un mensaje en la consola:
                    Console.WriteLine("El valor de miembros.StrNombreGru es inválido o está vacío.");
                }

                txtFuncionEdit.Text = miembros.StrFuncionMie;
                txtFechaIniEdit.Text = miembros.DtFechaIniMie.ToString("yyyy-MM-ddTHH:mm");
                txtFechaFinEdit.Text = miembros.DtFechaFin.ToString("yyyy-MM-ddTHH:mm");
            }

            }

        protected void btnBorrarMiembrosCentInv_Click(object sender, EventArgs e)
        {
            try {
                GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;
                aux.Text = row.Cells[0].Text;
                var server4 = ConnectionSqlServer.Instance;
            if (server4.Delete("INVGCCMIEMBROS", $"strId_mie = '{aux.Text}'"))
            {
                    pnlMiembros.Visible = true;
                    pnlADDmiembro.Visible = false;
                    lbtNuevoCentInv.Visible = false;
                    mostrarMiembrosAsociados(aux.Text);
                    gvwMiembros.Visible = true;
                    //mostrarActividadesAsociadas(lblIdProyecto.Text);
                    codigo.Text = "Eliminación correcta";
                Msg("Eliminación Exitosa", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                   
                codigo.Visible = false;

            }
            else
            {
                codigo.Text = "Error al eliminar";
                Msg("Error al eliminar", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                codigo.Visible = false;
                    mostrarMiembrosAsociados(aux.Text);
                }


        }
            catch (Exception ee)
            {
                Msg("Registro asociado a relaciones....", "ww", "GESTIÓN GENERAL DE INVESTIGACIÓN");
        codigo.Text = "Registro asociado a relaciones....";
                codigo.Visible = false;
               

            }
}

        protected void lbtnCancellEditMiembros_Click(object sender, EventArgs e)
        {
            pnlEditarMiembro.Visible = false;
            btnRegresarCentInv.Visible = true;
            pnlMiembros.Visible = true;
            mostrarMiembrosAsociados(aux.Text);
            lbtNuevoMiembroCentInv.Visible = true;
        }

        protected void lbtnEditMiembros_Click(object sender, EventArgs e)
        {
            var server1 = ConnectionSqlServer.Instance;

            DateTime fechaIni;
            DateTime fechaFin;

            if (DateTime.TryParse(txtFechaIniEdit.Text, out fechaIni) && DateTime.TryParse(txtFechaFinEdit.Text, out fechaFin))
            {
                if (fechaFin < fechaIni)
                {
                    // Mostrar mensaje de error
                    Msg("La fecha de fin no puede ser menor que la fecha de inicio.", "error", "Error");
                    return;
                }

                // Continuar con el proceso de edición si las fechas son válidas
                InvgccMiembros edit = new InvgccMiembros
                {
                    StrFuncionMie = txtFuncionEdit.Text,
                    DtFechaIniMie = fechaIni,
                    DtFechaFin = fechaFin,
                    fkIdGru = ddlGrupoEdit.SelectedValue,
                };

          
                server1.Update("INVGCCMIEMBROS", edit, $"strId_mie = '{codigo.Text}'");         // Aquí puedes mostrar un mensaje de éxito o redireccionar a otra página, dependiendo de tus necesidades.
                Msg("Edición exitosa...", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                pnlEditarMiembro.Visible = false;
                pnlMiembros.Visible = true;
                lbtNuevoCentInv.Visible = true;
                mostrarMiembrosAsociados(aux.Text);
            }
            else
            {
                // Mostrar mensaje de error si las fechas no son válidas
                Msg("Ingrese fechas válidas en los campos correspondientes.", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }
        }
    }
    
}