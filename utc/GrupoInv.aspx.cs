using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using utc.Settigns;
using utc.Models;
using System.IO;
using FluentEmail.Core;
using System.Data.SqlClient;
using System.Net;
using Newtonsoft.Json.Linq;
using System.Configuration;

namespace utc
{

    public partial class GrupoInv : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            txtCorreoNuevoInt.Attributes.Add("onblur", "validarCorreo(this.value);");
            if (!IsPostBack)
            {
                mostrarRegistrosGrilla();
                mostrarOpciones();
                fechaActual();
                if (Session["Username"] == null)
                {

                    Response.Redirect("login.aspx");

                }

            }
        }

        public string cadena = @"server=DESKTOP-A925LIU\SQLEXPRESS2019;database=INVESTIGACION;INTEGRATED SECURITY=true";
        public bool IsValidEmail(string email)
        {
            try
            {
                var parsedEmail = new System.Net.Mail.MailAddress(email);
                return true;
            }
            catch (FormatException)
            {
                return false;
            }
        }
        void fechaActual()
        {

            // Obtener la fecha actual
            DateTime fechaActual = DateTime.Now;

            // Asignar la fecha actual al control correspondiente
            dtFechaCreaGru.Text = fechaActual.ToString("yyyy-MM-ddTHH:mm");
            dtFechaInicioNuevoInt.Text = fechaActual.ToString("yyyy-MM-ddTHH:mm");
            DateTime fechaInicio = DateTime.Parse(dtFechaInicioNuevoInt.Text);
            DateTime fechaFin = fechaInicio.AddDays(15);
            dtFechaFinNuevoInt.Text = fechaFin.ToString("yyyy-MM-ddTHH:mm");



        }
        public void mostrarOpciones()
        {
            if (rblPreguntarNuevo.SelectedValue == "NO REGISTRADO")
            {
                integranteSinRegistro.Visible = true;
                ModalPopupExtender1.Show();
                Msg("Por favor registre al nuevo integrante", "ii", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                ResetFormFields();



            }
            else if (rblPreguntarNuevo.SelectedValue == "REGISTRADO")
            {

                ModalPopupExtender1.Show();
                integranteSinRegistro.Visible = true;
                Msg("Seleccione al integrante registrado", "ii", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                ResetFormFields();
            }
        }
        public void mostrarRegistrosGrilla()//metodo para listar convocatoria
        {

            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.Select<InvgccGrupoInvestigacion>("INVGCCGRUPO_INVESTIGACION"); /// filtra todo

            gvwListadoGruInv.DataSource = result1;
            gvwListadoGruInv.DataBind();
        }

        //public void guardarGrupoInv()
        //{
        //    try
        //    {
        //        var server1 = ConnectionSqlServer.Instance;
        //        InvgccGrupoInvestigacion inv = new InvgccGrupoInvestigacion
        //        {
        //            strId_gru = "G6",
        //            strNombre_gru = strNombreGru.Text,
        //            strCoordinador_gru = strNombreCoorGru.Text,
        //            dtFechacrea_gru = Convert.ToDateTime(dtFechaCreaGru.Text),
        //            strCategoria_gru = ddlCatGruInv.SelectedItem.Text,
        //            strLineasinv_gru = strLineaInvGru.Text,
        //            strSublineasinv_gru = strSLineaInvGru.Text,
        //        };
        //        server1.Insert("INVGCCGRUPO_INVESTIGACION", inv);
        //    }
        //    catch (Exception ex)
        //    {

        //        codigo.Text = "error" + ex;
        //        Msg("Error"+ex.ToString(), "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
        //        Visible = true;
        //    }
        //}

        public void guardarGrupoInv()
        {
            try
            {

            }
            catch (Exception ex)
            {
                codigo.Text = "error" + ex;
                Msg("Error" + ex.ToString(), "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                Visible = true;
            }
        }


        protected void btnRegresarGruInv_Click(object sender, EventArgs e)
        {
            lbtNuevoGruInv.Visible = true;
            btnRegresarGruInv.Visible = false;
            pnlAgregarGruInv.Visible = false;
            pnlGrilla.Visible = true;
            pnlVerMienbros.Visible = false;
            gvwMiembros.Visible = false;
            codigo.Text = "";
            lblcodigo.Text = "";
            pnlEditarGrupoInv.Visible = false;


        }

        protected void lbtNuevoGruInv_Click(object sender, EventArgs e)
        {
            lbtNuevoGruInv.Visible = false;
            btnRegresarGruInv.Visible = true;
            pnlAgregarGruInv.Visible = true;
            pnlGrilla.Visible = false;

        }

        protected void lbtADDGruInv_Click(object sender, EventArgs e)
        {
            if (flpArchivoAdd.HasFile)//selecciona archivo
            {
                string fileName = Server.HtmlEncode(flpArchivoAdd.FileName);
                string extension = System.IO.Path.GetExtension(fileName);
                if (extension == ".pdf" || extension == ".xlsx" || extension == ".xls")
                {
                    string savePath = GetSavePathForGroup(extension);



                    if (strNombreGru.Text != "" || strNombreCoorGru.Text != "" || strLineaInvGru1.SelectedValue != "" || strSLineaInvGru1.SelectedValue != "")
                    {
                        flpArchivoAdd.SaveAs(savePath);
                        // es pdf
                        codigo.Text = fileName + " guardado exitosamente...";
                        codigo.Visible = false;
                        pnlAgregarGruInv.Visible = false;
                        lbtNuevoGruInv.Visible = true;
                        btnRegresarGruInv.Visible = false;
                        pnlGrilla.Visible = true;
                        //guardarGrupoInv();

             
                        var server1 = ConnectionSqlServer.Instance;

                        using (SqlConnection connection = new SqlConnection(cadena))
                        {
                            connection.Open();

                            var query = "SELECT TOP 1 strId_gru FROM [INVESTIGACION].[dbo].[INVGCCGRUPO_INVESTIGACION] ORDER BY CAST(SUBSTRING(strId_gru, 2, LEN(strId_gru)) AS INT) DESC";

                            using (SqlCommand command = new SqlCommand(query, connection))
                            {
                                var ultimoId = command.ExecuteScalar() as string;

                                int nuevoNumero = 1; // Por defecto, si no hay registros previos, se comenzará con G1

                                if (!string.IsNullOrEmpty(ultimoId))
                                {
                                    int ultimoNumero = 0;
                                    if (int.TryParse(ultimoId.Substring(1), out ultimoNumero))
                                    {
                                        nuevoNumero = ultimoNumero + 1;
                                    }
                                }

                                string nuevoId = "G" + nuevoNumero;

                                InvgccGrupoInvestigacion inv = new InvgccGrupoInvestigacion
                                {
                                    strId_gru = nuevoId,
                                    strNombre_gru = strNombreGru.Text,
                                    strCoordinador_gru = strNombreCoorGru.Text,
                                    dtFechacrea_gru = Convert.ToDateTime(dtFechaCreaGru.Text),
                                    strCategoria_gru = ddlCatGruInv.SelectedItem.Text,
                                    strLineasinv_gru = strLineaInvGru1.SelectedValue,
                                    strArchivo_gru = savePath,
                                    strSublineasinv_gru = strSLineaInvGru1.SelectedValue,
                                };

                                server1.Insert("INVGCCGRUPO_INVESTIGACION", inv);
                                limpiarGrupoING();
                                mostrarRegistrosGrilla();
                                codigo.Visible = true;
                                codigo.Text = "Registro Correcto";
                                Msg("Registro exitoso", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");

                                connection.Close();
                            }
                        }
                    }
                    else
                    {
                        codigo.Text = "error, datos vacios";
                        Msg("Error, datos vacios", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    }
                }
                else
                {
                    Msg("SOLO SE ADMITEN ARCHIVOS PDF O EXCEL", "WW", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    return;
                }
            }
            else
            {
                Msg("SELECCIONE UN ARCHIVO", "WW", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                return;
            }
        }
        private string GetSavePathForGroup(string fileExtension)
        {
            string dia = DateTime.Now.Day.ToString("00");
            string hora = DateTime.Now.Hour.ToString("00");
            string minuto = DateTime.Now.Minute.ToString("00");
            string segundo = DateTime.Now.Second.ToString("00");
            string savePath = "INSCRIPCION" + "-";
            string path1 = @"C:\UTC"; // RUTA FISICA
            string fileName = $"Grupo-Investigacion-{dia}-{hora}-{minuto}-{segundo}{fileExtension}";
            return System.IO.Path.Combine(path1, fileName);
        }
        protected void lbtCancelarGruInv_Click(object sender, EventArgs e)
        {
            pnlAgregarGruInv.Visible = false;
            lbtNuevoGruInv.Visible = true;
            btnRegresarGruInv.Visible = false;
            pnlGrilla.Visible = true;

        }

        protected void btnEditarGruInv_Click(object sender, EventArgs e)//aqui
        {
            pnlEditarGrupoInv.Visible = true;
            pnlGrilla.Visible = false;
            btnRegresarGruInv.Visible = true;
            lbtNuevoGruInv.Visible = false;

            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;

            codigo.Text = row.Cells[0].Text;
            fullpath1.Text = row.Cells[1].Text;
            codigo.Visible = false;

            var server2 = ConnectionSqlServer.Instance;
            var result4 = server2.SelectSql<InvgccGrupoInvestigacion>($"SELECT * FROM INVGCCGRUPO_INVESTIGACION WHERE strId_gru = '{codigo.Text}'");

            if (result4.Count > 0)
            {
                InvgccGrupoInvestigacion grupoInvestigacion = result4[0]; // Suponiendo que el resultado es una lista y solo deseas el primer elemento

                // Asignar los valores a los campos de edición
                txtGrupoInvEdit.Text = grupoInvestigacion.strNombre_gru;
                txtNombreCoorGruInvEdit.Text = grupoInvestigacion.strCoordinador_gru;
                dtEditFechaCreaEdit.Text = grupoInvestigacion.dtFechacrea_gru.ToString("yyyy-MM-ddTHH:mm");
                // Asegurarse de que grupoInvestigacion sea una instancia válida y no nula
                if (grupoInvestigacion != null)
                {
                    // Asegurarse de que ddlEditCategoria esté correctamente enlazado a su fuente de datos y contenga la opción deseada
                    // Verificar si el valor de strCategoria_gru está presente en ddlEditCategoria
                    if (ddlEditCategoria.Items.FindByValue(grupoInvestigacion.strCategoria_gru) != null)
                    {
                        // Asignar el valor de strCategoria_gru al DropDownList ddlEditCategoria
                        ddlEditCategoria.SelectedValue = grupoInvestigacion.strCategoria_gru;
                    }
                    else
                    {
                        // Si el valor de strCategoria_gru no coincide con ninguna opción en ddlEditCategoria, puedes establecer una opción predeterminada o manejar el caso según tu lógica.
                        // Por ejemplo, seleccionar el primer elemento del DropDownList.
                        ddlEditCategoria.SelectedIndex = 0;
                    }
                }
                else
                {
                    // Si grupoInvestigacion es nulo, puedes establecer una opción predeterminada o manejar el caso según tu lógica.
                    // Por ejemplo, seleccionar el primer elemento del DropDownList.
                    ddlEditCategoria.SelectedIndex = 0;
                }


                string lineaSeleccionada = grupoInvestigacion.strLineasinv_gru;
                string sublineaSeleccionada = grupoInvestigacion.strSublineasinv_gru;

                // Validar si la línea seleccionada está en la lista de opciones
                if (txtEditLineaIGru1.Items.FindByValue(lineaSeleccionada) != null)
                {
                    txtEditLineaIGru1.SelectedValue = lineaSeleccionada;
                }
                else
                {
                    // La línea seleccionada no está en la lista, se puede manejar un caso especial
                    // o establecer un valor predeterminado si lo deseas.
                    txtEditLineaIGru1.SelectedIndex = 0;
                }

                // Validar si la sublínea seleccionada está en la lista de opciones
                if (txtEditSLineaIGru1.Items.FindByValue(sublineaSeleccionada) != null)
                {
                    txtEditSLineaIGru1.SelectedValue = sublineaSeleccionada;
                }
                else
                {
                    // La sublínea seleccionada no está en la lista, se puede manejar un caso especial
                    // o establecer un valor predeterminado si lo deseas.
                    txtEditSLineaIGru1.SelectedIndex = 0 ;
                }


            }

        }

        protected void btnBorrarGruInv_Click(object sender, EventArgs e)
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
                if (server4.Delete("INVGCCGRUPO_INVESTIGACION", $"strId_gru = '{codigo.Text}'"))
                {
                    Msg("Eliminación correcta", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    codigo.Text = "Eliminaciòn correcta";
                    mostrarRegistrosGrilla();
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
                Msg("Registro relacionado a uno o mas registros..", "ww", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }

        }

        protected void btnVerMienbrosGruInv_Click(object sender, EventArgs e)
        {
            pnlGrilla.Visible = false;
            lbtNuevoGruInv.Visible = false;
            pnlVerMienbros.Visible = true;
            btnRegresarGruInv.Visible = true;
            gvwMiembros.Visible = true;
            codigo.Text = "";

            codigo.Visible = false;
            /////delete
            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;

            string id = row.Cells[0].Text;
            lblcodigo.Visible = false;
            lblcodigo.Text = row.Cells[0].Text;
            mostrarMienbrosGrupo(id);

        }

        protected void btnADDMiembros_Click(object sender, EventArgs e)
        {
            pnlVerMienbros.Visible = false;
            pnlAgregarIntegrante.Visible = true;
            rblPreguntarNuevo.Visible = true;
            ModalPopupExtender1.Show();

        }

        // CAMBIO BDD ----- 
        private void mostrarMienbrosGrupo(string id)
        {

            ViewState["idGrupoActual"] = id;

            var server2 = ConnectionSqlServer.Instance;
            var query = $@"SELECT i.strId_int, i.bitPertenece_int, i.strCorreo_int, i.strCedula_int, 
                               i.strApellidos_int, i.strNombres_int, i.strCarrera_int, 
                               i.strFuncion_int, i.dtFechaini_int, i.dtFechafin_int, 
                               i.strObservacion_init, i.fkId_gru, i.fkId_doc, 
                               i.bitActivo_int,  -- ✅ nuevo campo
                               g.strNombre_gru
                        FROM INVESTIGACION.dbo.INVGCCINTEGRANTES i
                        INNER JOIN INVESTIGACION.dbo.INVGCCGRUPO_INVESTIGACION g 
                                ON i.fkId_gru = g.strId_gru
                        WHERE i.fkId_gru = '{id}';";

            var result1 = server2.SelectSql<InvgccIntegrantes>(query);

            gvwMiembros.DataSource = result1;
            gvwMiembros.DataBind();


        }

        // CODIGO AGREGADO
        protected void btnVerEstadoInt_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;
                string idIntegrante = ((HiddenField)row.FindControl("hfIdIntegrante")).Value.Trim();

                ViewState["idIntegranteSeleccionado"] = idIntegrante;

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connUTC"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(@"
            SELECT strNombres_int, strApellidos_int, dtFechaini_int, bitActivo_int 
            FROM INVESTIGACION.dbo.INVGCCINTEGRANTES WHERE strId_int = @Id", con))
                {
                    cmd.Parameters.AddWithValue("@Id", idIntegrante);
                    con.Open();

                    using (SqlDataReader rd = cmd.ExecuteReader())
                    {
                        if (rd.Read())
                        {
                            string nombres = rd["strNombres_int"].ToString();
                            string apellidos = rd["strApellidos_int"].ToString();
                            DateTime fechaIni = Convert.ToDateTime(rd["dtFechaini_int"]);
                            bool activo = Convert.ToBoolean(rd["bitActivo_int"]);

                            lblInfoIntegrante.Text = $"{nombres} {apellidos} — Miembro desde {fechaIni:dd/MM/yyyy}";
                            lblEstadoIntegrante.Text = activo ? "Estado actual: ACTIVO" : "Estado actual: INACTIVO";
                            lblEstadoIntegrante.ForeColor = activo ? System.Drawing.Color.Green : System.Drawing.Color.Red;

                            btnDarDeBaja.Visible = activo;
                            btnReactivar.Visible = !activo;

                            ModalEstadoIntegrante.Show();
                        }
                        else
                        {
                            Msg("No se pudo cargar la información del integrante.", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Msg("Error al cargar información: " + ex.Message, "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }
        }


        protected void btnDarDeBaja_Click(object sender, EventArgs e)
        {
            try
            {
                string idIntegrante = ViewState["idIntegranteSeleccionado"]?.ToString();
                if (string.IsNullOrEmpty(idIntegrante))
                {
                    Msg("No se pudo identificar al integrante seleccionado.", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    return;
                }

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connUTC"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(@"
            UPDATE INVESTIGACION.dbo.INVGCCINTEGRANTES
            SET bitActivo_int = 0, dtFechafin_int = GETDATE()
            WHERE strId_int = @Id", con))
                {
                    cmd.Parameters.AddWithValue("@Id", idIntegrante);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                string idGrupo = ViewState["idGrupoActual"]?.ToString();
                if (!string.IsNullOrEmpty(idGrupo))
                    mostrarMienbrosGrupo(idGrupo);

                ModalEstadoIntegrante.Hide();
                Msg("Integrante dado de baja correctamente.", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }
            catch (Exception ex)
            {
                Msg("Error al dar de baja: " + ex.Message, "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }
        }


        protected void btnReactivar_Click(object sender, EventArgs e)
        {
            try
            {
                string idIntegrante = ViewState["idIntegranteSeleccionado"]?.ToString();
                if (string.IsNullOrEmpty(idIntegrante))
                {
                    Msg("No se pudo identificar al integrante seleccionado.", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    return;
                }

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connUTC"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(@"
            UPDATE INVESTIGACION.dbo.INVGCCINTEGRANTES
            SET bitActivo_int = 1, dtFechafin_int = NULL
            WHERE strId_int = @Id", con))
                {
                    cmd.Parameters.AddWithValue("@Id", idIntegrante);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                string idGrupo = ViewState["idGrupoActual"]?.ToString();
                if (!string.IsNullOrEmpty(idGrupo))
                    mostrarMienbrosGrupo(idGrupo);

                ModalEstadoIntegrante.Hide();
                Msg("Integrante reactivado correctamente.", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }
            catch (Exception ex)
            {
                Msg("Error al reactivar integrante: " + ex.Message, "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }
        }


        // FIN CODIGO AGREGADO


        protected void btnEditarIntGruInv_Click(object sender, EventArgs e)
        {
            pnlEditarIntegrantesGruInv.Visible = true;
            pnlGrilla.Visible = false;
            pnlVerMienbros.Visible = false;


            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;

            codigo.Text = row.Cells[0].Text;
            codigo.Visible = false;

            var server2 = ConnectionSqlServer.Instance;
            var result4 = server2.SelectSql<InvgccIntegrantes>($"SELECT * FROM INVGCCINTEGRANTES WHERE strId_int = '{codigo.Text}'");

            if (result4.Count > 0)
            {
                InvgccIntegrantes Integrantes = result4[0]; // Suponiendo que el resultado es una lista y solo deseas el primer elemento



                // Asignar los valores a los campos de edición
                txtEditNombreInt.Text = Integrantes.strNombres_int;
                txtEditApellidoInt.Text = Integrantes.strApellidos_int;
                txtFuncionEdit.Text = Integrantes.strFuncion_int;
                txtCedulaEditInt.Text = Integrantes.strCedula_int;
                dtFechaFinEdit.Text = Integrantes.dtFechafin_int?.ToString("yyyy-MM-ddTHH:mm") ?? "";

                dtFechaIniEdit.Text = Integrantes.dtFechaini_int.ToString("yyyy-MM-ddTHH:mm");
                //ddlEditCategoria.SelectedValue = Integrantes.str;
                txtCarreraEdit.Text = Integrantes.strCarrera_int;
                txtCorreoNuevoIntEdit.Text = Integrantes.strCorreo;
                txtObservacionEdit.Text = Integrantes.strObservacion_init;


            }

        }

        protected void btnBorrarIntGruInv_Click(object sender, EventArgs e)
        {
            try
            {

                codigo.Visible = false;
                /////delete
                GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;

                codigo.Text = row.Cells[0].Text;
                string foraneo = row.Cells[1].Text;
                var server4 = ConnectionSqlServer.Instance;
                if (server4.Delete("INVGCCINTEGRANTES", $"strId_int = '{codigo.Text}'"))
                {
                    codigo.Text = "Eliminación correcta";
                    Msg("Registro Eliminado con exito", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    //mostrarRegistrosGrilla();
                    mostrarMienbrosGrupo(foraneo);
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
                Msg("Registro tiene relación con otros registros..", "ww", "GESTIÓN GENERAL DE INVESTIGACIÓN");
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

        protected void rblPreguntarNuevo_SelectedIndexChanged(object sender, EventArgs e)
        {
            mostrarOpciones();
        }

        protected void lbtnAddIntegranteSinRegistrar_Click(object sender, EventArgs e)
        {
            string correo = txtCorreoNuevoInt.Text;

            // Verificar el formato del correo electrónico
            if (!IsValidEmail(correo))
            {
                // El formato del correo es inválido
                Msg("El formato del correo es inválido.", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                return;
            }

            // Aquí debes insertar el código para verificar la existencia real del correo usando la API correspondiente


            // El correo electrónico es válido y existe, proceder con la inserción en la base de datos
            if (!string.IsNullOrEmpty(txtApellidoNuevoInt.Text) && !string.IsNullOrEmpty(txtCarreraNuevoInt.Text) && !string.IsNullOrEmpty(txtFuncionNuevoInt.Text) && !string.IsNullOrEmpty(txtIdentificacionNuevoInt.Text) && !string.IsNullOrEmpty(dtFechaInicioNuevoInt.Text))
            {
                // Verificar que la fecha de finalización no sea menor que la fecha de inicio
                DateTime fechaInicio = Convert.ToDateTime(dtFechaInicioNuevoInt.Text);
                DateTime? fechaFin = string.IsNullOrEmpty(dtFechaFinNuevoInt.Text)
                    ? (DateTime?)null
                    : Convert.ToDateTime(dtFechaFinNuevoInt.Text);

                if (fechaFin.HasValue && fechaFin.Value < fechaInicio)
                {
                    codigo.Text = "La fecha de finalización no puede ser menor que la fecha de inicio.";
                    Msg("Fecha inválida", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    return;
                }

                var server1 = ConnectionSqlServer.Instance;

                // Obtener el último número utilizado en la primary key
                var query = "SELECT TOP 1 strId_int FROM INVGCCINTEGRANTES ORDER BY CAST(SUBSTRING(strId_int, 2, LEN(strId_int)) AS INT) DESC";
                var maxIdResult = server1.SelectSql<InvgccIntegrantes>(query).FirstOrDefault();
                string ultimoId = maxIdResult?.strId_int ?? "I1";

                int ultimoNumero = 0;
                if (!string.IsNullOrEmpty(ultimoId) && ultimoId.Length > 1)
                {
                    int.TryParse(ultimoId.Substring(1), out ultimoNumero);
                }

                // Incrementar el número en 1
                int nuevoNumero = ultimoNumero + 1;

                // Generar el nuevo valor de strId_cen
                string nuevoId = "I" + nuevoNumero.ToString();

                if (rblPreguntarNuevo.SelectedValue == "REGISTRADO")
                {
                    InvgccIntegrantes integrantes = new InvgccIntegrantes
                    {
                        strId_int = nuevoId,
                        strNombres_int = txtNombreNuevoInt.Text,
                        strApellidos_int = txtApellidoNuevoInt.Text,
                        strCedula_int = txtIdentificacionNuevoInt.Text,
                        strFuncion_int = txtFuncionNuevoInt.Text,
                        dtFechaini_int = fechaInicio,
                        strCarrera_int = txtCarreraNuevoInt.Text,
                        strObservacion_init = txtObservacionNuevoInt.Text,
                        strCorreo = txtCorreoNuevoInt.Text,
                        bitPertenece_int = 1,
                        fkId_gru = lblcodigo.Text,
                        bitActivo_int = true,   // activo por defecto
                        dtFechafin_int = null  // sin fecha fin
                    };

                    server1.Insert("INVGCCINTEGRANTES", integrantes);

                    // 1) Mensaje OK
                    Msg("Integrante agregado correctamente.", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");

                    // 2) Refrescar la grilla de integrantes del grupo actual
                    mostrarMienbrosGrupo(lblcodigo.Text);

                    // 3) Cerrar el formulario/modal de alta (si aplica) y quedar en la vista de integrantes
                    pnlAgregarIntegrante.Visible = false;   // si lo usas
                    pnlVerMienbros.Visible = true;
                    gvwMiembros.Visible = true;

                    // 4) (Opcional) Limpia campos del formulario
                    ResetFormFields();

                    // 5) (Opcional) Mantén el contexto del grupo por si hay otro postback
                    ViewState["idGrupoActual"] = lblcodigo.Text;
                    Session["idGrupoActual"] = lblcodigo.Text; // opcional pero útil


                }
                else
                {
                    InvgccIntegrantes integrantes = new InvgccIntegrantes
                    {
                        strId_int = nuevoId,
                        strNombres_int = txtNombreNuevoInt.Text,
                        strApellidos_int = txtApellidoNuevoInt.Text,
                        strCedula_int = txtIdentificacionNuevoInt.Text,
                        strFuncion_int = txtFuncionNuevoInt.Text,
                        dtFechaini_int = fechaInicio,
                        strCarrera_int = txtCarreraNuevoInt.Text,
                        strObservacion_init = txtObservacionNuevoInt.Text,
                        strCorreo = txtCorreoNuevoInt.Text,
                        bitPertenece_int = 0,
                        fkId_gru = lblcodigo.Text,
                        bitActivo_int = true,   // activo por defecto
                        dtFechafin_int = null  // sin fecha fin
                    };

                    server1.Insert("INVGCCINTEGRANTES", integrantes);

                    // 1) Mensaje OK
                    Msg("Integrante agregado correctamente.", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");

                    // 2) Refrescar la grilla de integrantes del grupo actual
                    mostrarMienbrosGrupo(lblcodigo.Text);

                    // 3) Cerrar el formulario/modal de alta (si aplica) y quedar en la vista de integrantes
                    pnlAgregarIntegrante.Visible = false;   // si lo usas
                    pnlVerMienbros.Visible = true;
                    gvwMiembros.Visible = true;

                    // 4) (Opcional) Limpia campos del formulario
                    ResetFormFields();

                    // 5) (Opcional) Mantén el contexto del grupo por si hay otro postback
                    ViewState["idGrupoActual"] = lblcodigo.Text;
                    Session["idGrupoActual"] = lblcodigo.Text; // opcional pero útil

                }

            }
            else
            {
                codigo.Text = "Llene todos los campos...";
                Msg("Campos vacíos", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }
        }
        private void ResetFormFields()
        {
            txtNombreNuevoInt.Text = string.Empty;
            txtApellidoNuevoInt.Text = string.Empty;
            txtIdentificacionNuevoInt.Text = string.Empty;
            txtFuncionNuevoInt.Text = string.Empty;
            dtFechaInicioNuevoInt.Text = string.Empty;
            dtFechaFinNuevoInt.Text = string.Empty;
            txtCarreraNuevoInt.Text = string.Empty;
            txtObservacionNuevoInt.Text = string.Empty;
            txtCorreoNuevoInt.Text = string.Empty;

            // Restablecer mensajes de validación
            rfvNombreNuevoInt.IsValid = true;
            rfvApellidoNuevoInt.IsValid = true;
            rfvIdentificacionNuevoInt.IsValid = true;
            rfvFuncionNuevoInt.IsValid = true;
            rfvFechaInicioNuevoInt.IsValid = true;
            rfvFechaFinNuevoInt.IsValid = true;
            rfvCarreraNuevoInt.IsValid = true;
            rfvCorreoInt.IsValid = true;
            cvIdentificacionNuevoInt.IsValid = true;
        }


        // Función para verificar la existencia real del correo electrónico en el servidor
        //private bool VerificarCorreoElectronico(string correo)
        //{
        //    string apiKey = "4ed632f8b0a64be5835b92a7ebe054a9";
        //    string requestUrl = $"https://api.zerobounce.net/v2/validate?apikey={apiKey}&email={correo}";

        //    using (var client = new WebClient())
        //    {
        //        try
        //        {
        //            // Realiza la solicitud a la API de ZeroBounce
        //            string response = client.DownloadString(requestUrl);

        //            // Parsea la respuesta JSON
        //            JObject jsonResponse = JObject.Parse(response);

        //            // Verifica si la respuesta es válida
        //            if (jsonResponse["status"].ToString() == "valid")
        //            {
        //                return true; // El correo es válido y existe en el servidor
        //            }
        //            else
        //            {
        //                return false; // El correo no es válido o no existe
        //            }
        //        }
        //        catch (WebException ex)
        //        {
        //            // Maneja errores de conexión con la API
        //            // Puedes registrarlos en un log, mostrar mensajes de error, etc.
        //            return false;
        //        }
        //    }
        //}




        protected void lbtCancellIntegranteSinRegistrar_Click(object sender, EventArgs e)
        {

        }

        public void limpiarGrupoING()
        {
            strNombreGru.Text = "";
            strNombreCoorGru.Text = "";
            // Modificacion arreglo limpio de campos
            strSLineaInvGru1.ClearSelection();
            strLineaInvGru1.ClearSelection();
            dtFechaCreaGru.Text = "";
        }

        protected void lbnEditGruInv_Click(object sender, EventArgs e)
        {
            try
            {
                if (!flpArchivoEdit.HasFile)
                {
                    /////update
                    var server3 = ConnectionSqlServer.Instance;

                    InvgccGrupoInvestigacion gru1 = new InvgccGrupoInvestigacion
                    {
                        strNombre_gru = txtGrupoInvEdit.Text,
                        strCoordinador_gru = txtNombreCoorGruInvEdit.Text,
                        dtFechacrea_gru = Convert.ToDateTime(dtEditFechaCreaEdit.Text),
                        strCategoria_gru = ddlEditCategoria.SelectedValue,
                        strLineasinv_gru = txtEditLineaIGru1.SelectedValue,

                        strSublineasinv_gru = txtEditSLineaIGru1.SelectedValue

                    };
                    if (txtGrupoInvEdit.Text != "" || txtNombreCoorGruInvEdit.Text != "" || dtEditFechaCreaEdit.Text != "" || txtEditLineaIGru1.SelectedValue != "" || txtEditSLineaIGru1.SelectedValue != "")//estan llenos
                    {
                        if (server3.Update("INVGCCGRUPO_INVESTIGACION", gru1, $"strId_gru = '{codigo.Text}'"))
                        {
                            Msg("Registro Actualizado con éxito", "SS", "SISTEMA INTEGRADO DE GESTIÓN");
                            codigo.Text = "Registro Actualizado con éxito";
                            pnlGrilla.Visible = true;
                            lbtNuevoGruInv.Visible = true;
                            mostrarRegistrosGrilla();
                            pnlEditarGrupoInv.Visible = false;

                            // Limpiar los campos de edición
                            txtGrupoInvEdit.Text = string.Empty;
                            dtEditFechaCreaEdit.Text = string.Empty;
                            txtNombreCoorGruInvEdit.Text = string.Empty;
                            ddlEditCategoria.Text = string.Empty;
                            txtEditLineaIGru1.SelectedIndex = 0;
                            txtEditSLineaIGru1.SelectedIndex = 0;
                        }
                    }
                    else
                    {
                        Msg("Campos vacios", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                        codigo.Text = "Llene todos los campos....";
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
                        string savePath = GetSavePathForGroup(extension);

                        var server3 = ConnectionSqlServer.Instance;

                        InvgccGrupoInvestigacion gru1 = new InvgccGrupoInvestigacion
                        {
                            strNombre_gru = txtGrupoInvEdit.Text,
                            strCoordinador_gru = txtNombreCoorGruInvEdit.Text,
                            dtFechacrea_gru = Convert.ToDateTime(dtEditFechaCreaEdit.Text),
                            strCategoria_gru = ddlEditCategoria.SelectedValue,
                            strLineasinv_gru = txtEditLineaIGru1.SelectedValue,
                            strArchivo_gru = savePath,
                            strSublineasinv_gru = txtEditSLineaIGru1.SelectedValue

                        };
                        if (txtGrupoInvEdit.Text != "" || txtNombreCoorGruInvEdit.Text != "" || dtEditFechaCreaEdit.Text != "" || txtEditLineaIGru1.SelectedValue != "" || txtEditSLineaIGru1.SelectedValue != "")//estan llenos
                        {
                            flpArchivoEdit.SaveAs(savePath);
                            if (server3.Update("INVGCCGRUPO_INVESTIGACION", gru1, $"strId_gru = '{codigo.Text}'"))
                            {
                                Msg("Registro Actualizado con éxito", "SS", "SISTEMA INTEGRADO DE GESTIÓN");
                                codigo.Text = "Registro Actualizado con éxito";
                                pnlGrilla.Visible = true;
                                lbtNuevoGruInv.Visible = true;
                                mostrarRegistrosGrilla();
                                pnlEditarGrupoInv.Visible = false;

                                // Limpiar los campos de edición
                                txtGrupoInvEdit.Text = string.Empty;
                                dtEditFechaCreaEdit.Text = string.Empty;
                                txtNombreCoorGruInvEdit.Text = string.Empty;
                                ddlEditCategoria.Text = string.Empty;
                                txtEditLineaIGru1.SelectedIndex = 0;
                                txtEditSLineaIGru1.SelectedIndex = 0;
                            }
                        }
                        else
                        {
                            Msg("Campos vacios", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                            codigo.Text = "Llene todos los campos....";
                        }
                    }

                }
            }
            catch (Exception)
            {

                Msg("Error al actualizar", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                codigo.Text = "Error al actualizar";
            }
        }

        protected void lbnCancellEditGruInv_Click(object sender, EventArgs e)
        {
            pnlEditarGrupoInv.Visible = false;
            pnlGrilla.Visible = true;


        }

        protected void lbtnCancellEditIntegrantesGruInv_Click(object sender, EventArgs e)
        {
            pnlEditarIntegrantesGruInv.Visible = false;
            pnlVerMienbros.Visible = true;

        }

        protected void lbtnEditIntegrantesGruInv_Click(object sender, EventArgs e)
        {
            string nombreInt = txtEditNombreInt.Text;
            string apellidoInt = txtEditApellidoInt.Text;
            string carrera = txtCarreraEdit.Text;
            string funcion = txtFuncionEdit.Text;
            string cedulaInt = txtCedulaEditInt.Text;
            string observacion = txtObservacionEdit.Text;
           
            DateTime fechaIni = Convert.ToDateTime(dtFechaIniEdit.Text);
            DateTime fechaFin = Convert.ToDateTime(dtFechaFinEdit.Text);

            if (fechaFin < fechaIni)
            {
                Msg("Fecha de finalización no puede ser inferior a la de inicio", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                return;

            }
              

            if (string.IsNullOrEmpty(nombreInt) || string.IsNullOrEmpty(apellidoInt) || string.IsNullOrEmpty(carrera) ||
                string.IsNullOrEmpty(funcion) || string.IsNullOrEmpty(cedulaInt) || string.IsNullOrEmpty(observacion))
            {
                // Mostrar mensaje de error usando toastr
                Msg("Llene todos los campos", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                return;
            }

            // Actualizar los datos del integrante del grupo de investigación
            var server3 = ConnectionSqlServer.Instance;
            InvgccIntegrantes gru1 = new InvgccIntegrantes
            {
                strNombres_int = nombreInt,
                strApellidos_int = apellidoInt,
                strCedula_int = cedulaInt,
                strFuncion_int = funcion,
                dtFechafin_int = fechaFin,
                dtFechaini_int = fechaIni,
                strCarrera_int = carrera,
                strObservacion_init = observacion,
                strCorreo = txtCorreoNuevoIntEdit.Text,
            };

            if (server3.Update("INVGCCINTEGRANTES", gru1, $"strId_int = '{codigo.Text}'"))
            {
                // Mostrar mensaje de éxito usando toastr
                Msg("Registro Actualizado con éxito", "SS", "SISTEMA INTEGRADO DE GESTIÓN");
                pnlVerMienbros.Visible = true;
                pnlEditarIntegrantesGruInv.Visible = false;
                gvwMiembros.Visible = true;
                mostrarMienbrosGrupo(lblcodigo.Text);
            }
            else
            {
                // Mostrar mensaje de error usando toastr
                Msg("Error al actualizar el registro", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
            }
        }


        protected void btnVerArchivoGruInv_Click(object sender, EventArgs e)
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
    }
}