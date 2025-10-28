using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using utc.Models;
using System.IO;
using utc.Settigns;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Globalization;
using System.Data;
using System.Text;

namespace utc
{
    public partial class InsPro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                mostrarRegistrosGrilla();
                fechaActual();
                if (Session["Username"] == null)
                {

                    Response.Redirect("login.aspx");

                }


            }
        }




        void fechaActual()
        {

            // Obtener la fecha actual
            DateTime fechaActual = DateTime.Now;

            // Asignar la fecha actual al control correspondiente
            dtFechaIniAct.Text = fechaActual.ToString("yyyy-MM-ddTHH:mm");
            dtFechaCreacion.Text = fechaActual.ToString("yyyy-MM-ddTHH:mm");
            //sdtEditFechaCrea.Text = fechaActual.ToString();

            dtFechaFinAct.Text = fechaActual.AddDays(15).ToString("yyyy-MM-ddTHH:mm");


        }
        private decimal totalPrecio = 0;

        private void mostrarRegistrosGrilla()
        {
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccInsPro>("SELECT pro.strId_pro, pro.strTema_pro, pro.strDuracion_pro, pro.dtFehains_pro, pro.strArchivo_pro, pro.strEstado_pro, conv.strNombre_conv, grupo.strNombre_gru FROM INVESTIGACION.dbo.INVGCCPROYECTO pro JOIN INVESTIGACION.dbo.INVGCCCONVOCATORI conv ON conv.strId_conv = pro.fkId_conv JOIN INVESTIGACION.dbo.INVGCCGRUPO_INVESTIGACION grupo ON grupo.strId_gru = pro.fkId_gru;");

            gvwListadoInsPro.DataSource = result1;
            gvwListadoInsPro.DataBind();
            //prueba.DataSource = result1;
            //prueba.DataBind();
            listarGruposAll();
            listarConvocatoria();
        }

        private void listarGruposAll()
        {
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccGrupoInvestigacion>($"SELECT strId_gru, strNombre_gru FROM INVGCCGRUPO_INVESTIGACION");
            //var result1 = server2.Select<InvgccConvocatori>("INVGCCGRUPO_INVESTIGACION", "strNombre_gru"); /// filtra segun los parametros enviados y solo retorna las columas especificadas
            //var result1 = server2.Select<InvccCentInv>("INVGCCCENTRO_INESTIGACION"); /// filtra todo

            ddlGrupo.DataSource = result1;
            ddlGrupo.DataValueField = "strId_gru";
            ddlGrupo.DataTextField = "strNombre_gru";
            ddlGrupo.DataBind();

        }

        private void listarConvocatoria()
        {
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccConvocatori>($"SELECT strId_conv, strNombre_conv FROM INVGCCCONVOCATORI");
            //var result1 = server2.Select<InvgccConvocatori>("INVGCCGRUPO_INVESTIGACION", "strNombre_gru"); /// filtra segun los parametros enviados y solo retorna las columas especificadas
            //var result1 = server2.Select<InvccCentInv>("INVGCCCENTRO_INESTIGACION"); /// filtra todo

            ddlConvocatoria.DataSource = result1;
            ddlConvocatoria.DataValueField = "strId_conv";
            ddlConvocatoria.DataTextField = "strNombre_conv";
            ddlConvocatoria.DataBind();

        }

        private void listarGruposAllEdit()
        {
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccGrupoInvestigacion>($"SELECT strId_gru, strNombre_gru FROM INVGCCGRUPO_INVESTIGACION");
            //var result1 = server2.Select<InvgccConvocatori>("INVGCCGRUPO_INVESTIGACION", "strNombre_gru"); /// filtra segun los parametros enviados y solo retorna las columas especificadas
            //var result1 = server2.Select<InvccCentInv>("INVGCCCENTRO_INESTIGACION"); /// filtra todo

            ddlGrupoEdit.DataSource = result1;
            ddlGrupoEdit.DataValueField = "strId_gru";
            ddlGrupoEdit.DataTextField = "strNombre_gru";
            ddlGrupoEdit.DataBind();

        }

        private void listarConvocatoriaEdit()
        {
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccConvocatori>($"SELECT strId_conv, strNombre_conv FROM INVGCCCONVOCATORI");
            //var result1 = server2.Select<InvgccConvocatori>("INVGCCGRUPO_INVESTIGACION", "strNombre_gru"); /// filtra segun los parametros enviados y solo retorna las columas especificadas
            //var result1 = server2.Select<InvccCentInv>("INVGCCCENTRO_INESTIGACION"); /// filtra todo

            ddlEditConv.DataSource = result1;
            ddlEditConv.DataValueField = "strId_conv";
            ddlEditConv.DataTextField = "strNombre_conv";
            ddlEditConv.DataBind();

        }


        protected void lbtNuevoInsPro_Click(object sender, EventArgs e)
        {
            lbtNuevoInsPro.Visible = false;
            btnRegresarInsPro.Visible = true;
            pnlAgregarInsPro.Visible = true;
            pnlGrilla.Visible = false;

        }
        protected void LimpiarCamposActividad()
        {
            // Limpiar campos de la actividad a agregar
            txtNombreAct.Text = string.Empty;
            txtDescripcionAct.Text = string.Empty;
           
            fltPrecioRecAct.Text = string.Empty;
            fltPrecioAct.Text = string.Empty;
            flpAdjuntoAct.Attributes.Clear();
            ddlEstadoAct.SelectedIndex = 0;
            pnlAddRecursos.Visible = false;
            txtTagsRecursos.Text = string.Empty;

            // Limpiar campos de la actividad a editar
            txtEditNombreAct.Text = string.Empty;
            txtEditDescAct.Text = string.Empty;
            dtFechaInicioEdit.Text = string.Empty;
            dtFechaFinEdit.Text = string.Empty;
            txtPrecioEditAct.Text = string.Empty;
            flpEditActividad.Attributes.Clear();
            ddlEstadoEditAct.SelectedIndex = 0;
            pnlEditInsumosAct.Visible = false;
            txtEditRecursosAct.Text = string.Empty;
        }

        protected void lbtADDInsPro_Click(object sender, EventArgs e)
        {
            try
            {
                pnlAgregarInsPro.Visible = false;
                lbtNuevoInsPro.Visible = true;
                btnRegresarInsPro.Visible = false;

                if (flpInscripcion.HasFile)
                {
                    string fileName = Server.HtmlEncode(flpInscripcion.FileName);
                    string extension = System.IO.Path.GetExtension(fileName);
                    if (extension == ".pdf"|| extension==".xls" || extension==".xlsx")
                    {
                        string savePath = GetSavePathForInscripcion(extension);

                        flpInscripcion.SaveAs(savePath);
                        // es pdf
                        codigo.Text = fileName + " guardado exitosamente...";
                        codigo.Visible = false;

                        var server1 = ConnectionSqlServer.Instance;


                        var query = "SELECT TOP 1 strId_pro FROM INVGCCPROYECTO ORDER BY CAST(SUBSTRING(strId_pro, 2, LEN(strId_pro)) AS INT) DESC";
                        var ultimoProyecto = server1.SelectSql<InvgccInsPro>(query).FirstOrDefault();
                        string ultimoId = ultimoProyecto?.strId_pro ?? "I1";

                        // Extraer el número del último valor utilizado
                        int ultimoNumero = 0;
                        if (!string.IsNullOrEmpty(ultimoId) && ultimoId.Length > 1)
                        {
                            int.TryParse(ultimoId.Substring(1), out ultimoNumero);
                        }

                        // Incrementar el número en 1
                        int nuevoNumero = ultimoNumero + 1;

                        // Generar el nuevo valor de strId_pro
                        string nuevoId = "P" + nuevoNumero.ToString();

                        //if (rblPreguntarAgregarInsumosOK.Checked==true)
                        //{

                        string duracion = strDuracionInsPro.Text;
                        string unidad = ddlDuracion.SelectedValue;

                        int duracionValor = 0;
                        if (int.TryParse(duracion, out duracionValor))
                        {
                            // Verificar si la duración es válida según la unidad seleccionada
                            bool duracionValida = false;

                            if (unidad == "años" && duracionValor <= 2)
                            {
                                duracionValida = true;
                            }
                            else if (unidad == "meses" && duracionValor <= 12)
                            {
                                duracionValida = true;
                            }

                            if (!duracionValida)
                            {
                                // Mostrar un mensaje de error si la duración es inválida
                                Msg("La duración seleccionada no es válida(MÁXIMO 12 MESES O 2 AÑOS)", "EE", "SISTEMA INTEGRADO DE GESTIÓN");

                                pnlAgregarInsPro.Visible = true;
                                return;
                            }
                        }
                        else
                        {
                            // Mostrar un mensaje de error si la duración no es un número válido
                            Msg("La duración ingresada no es válida(MÁXIMO 2 AÑOS O 12 MESES)", "EE", "SISTEMA INTEGRADO DE GESTIÓN");

                            pnlAgregarInsPro.Visible = true;
                            return;
                        }
                        InvgccInsPro cent = new InvgccInsPro
                            {
                                strId_pro = nuevoId,
                                strTema_pro = strTemaInsPro.Text,
                                strDuracion_pro = strDuracionInsPro.Text + " " + ddlDuracion.SelectedValue,
                                dtFehains_pro = Convert.ToDateTime(dtFechaCreacion.Text),
                                strArchivo_pro = savePath,
                                //strInsumos_pro = txtTagsRecursos.Text,
                                strEstado_pro = ddlEstadoInsPro.SelectedValue,
                                fkId_conv = ddlConvocatoria.SelectedValue,
                                fkId_gru = ddlGrupo.SelectedValue
                            };
                       
                     

                        server1.Insert("INVGCCPROYECTO", cent);
                        //codigo.Text = "Proyecto Ingresado con éxito...";
                        Msg("Registro exitoso...", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                        ddlGrupo.SelectedIndex = 0;
                        strTemaInsPro.Text = "";
                        strDuracionInsPro.Text = "";
                        ddlDuracion.SelectedIndex = 0;
                        dtFechaCreacion.Text = "";
                        flpInscripcion.Attributes.Clear();
                        ddlConvocatoria.SelectedIndex = 0;
                        ddlEstadoInsPro.SelectedIndex = 0;
                        pnlGrilla.Visible = true;
                        mostrarRegistrosGrilla();
                    }
                    else
                    {
                        codigo.Text = fileName + " Error, solo se permiten archivos pdf y excel";
                        Msg("SOLO SE ADMITEN PDF y excel", "EE", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                        codigo.Visible = true;
                        return;
                        // no es pdf
                    }
                }
            }
            catch (Exception ex)
            {
                //codigo.Text = "error al insertar";
                Msg("Ocurrio un error, intenta de nuevo", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                pnlGrilla.Visible = true;
                mostrarRegistrosGrilla();
            }
        }
        private void LimpiarCampos()
        {
            ddlGrupo.SelectedIndex = 0;
            strTemaInsPro.Text = "";
            strDuracionInsPro.Text = "";
            ddlDuracion.SelectedIndex = 0;
            dtFechaCreacion.Text = "";
            flpInscripcion.Attributes.Clear();
            ddlConvocatoria.SelectedIndex = 0;
            ddlEstadoInsPro.SelectedIndex = 0;
        }

        private void LimpiarCamposEditar()
        {
            ddlGrupoEdit.SelectedIndex = 0;
            txtEditTemaPro.Text = "";
            txtEditTiempoPRO.Text = "";
            ddlEditDuracion.SelectedIndex = 0;
            dtEditFechaCrea.Text = "";
            flpEditIns.Attributes.Clear();
            ddlEditConv.SelectedIndex = 0;
            ddlEditEstadoPro.SelectedIndex = 0;
        }

        private string GetSavePathForInscripcion(string fileExtension)
        {
            string dia = DateTime.Now.Day.ToString("00");
            string hora = DateTime.Now.Hour.ToString("00");
            string minuto = DateTime.Now.Minute.ToString("00");
            string segundo = DateTime.Now.Second.ToString("00");
            string savePath = "INSCRIPCION" + "-";
            string path1 = @"c://FILESUTC/0/UTC/PROYECTOS/"; // RUTA FISICA
            string fileName = $"{dia}-{hora}-{minuto}-{segundo}{fileExtension}";
            return System.IO.Path.Combine(path1, fileName);
        }

        private string GetSavePathForInscripcionActividad(string fileExtension)
        {
            string dia = DateTime.Now.Day.ToString("00");
            string hora = DateTime.Now.Hour.ToString("00");
            string minuto = DateTime.Now.Minute.ToString("00");
            string segundo = DateTime.Now.Second.ToString("00");
            string savePath = "INSCRIPCION" + "-";
            string path1 = @"c://FILESUTC/0/UTC/PROYECTOS/ACTIVIDADES"; // RUTA FISICA
            string fileName = $"{dia}-{hora}-{minuto}-{segundo}{fileExtension}";
            return System.IO.Path.Combine(path1, fileName);
        }

        private string GetSavePathForInscripcionEdit(string fileExtension)
        {
            string dia = DateTime.Now.Day.ToString("00");
            string hora = DateTime.Now.Hour.ToString("00");
            string minuto = DateTime.Now.Minute.ToString("00");
            string segundo = DateTime.Now.Second.ToString("00");
            string savePath = "INSCRIPCION" + "-";
            string path1 = @"c://FILESUTC/0/UTC/PROYECTOS/"; // RUTA FISICA
            string fileName = $"{dia}-{hora}-{minuto}-{segundo}{fileExtension}";
            return System.IO.Path.Combine(path1, fileName);


        }



        protected void lbtCancelarGruInv_Click(object sender, EventArgs e)
        {
            pnlAgregarInsPro.Visible = false;
            lbtNuevoInsPro.Visible = true;
            btnRegresarInsPro.Visible = false;
            lblResult.Text = "";//limpiando campos
            lblIdProyecto.Text = "";
            codigo.Text = "";
            mostrarRegistrosGrilla();
            pnlGrilla.Visible = true;
            lbtNuevoInsPro.Visible = true;

        }

        protected void btnRegresarInsPro_Click(object sender, EventArgs e)
        {
            lbtNuevoInsPro.Visible = true;
            btnRegresarInsPro.Visible = false;
            pnlAgregarInsPro.Visible = false;
            pnlGrilla.Visible = true;
            pnlActividades.Visible = false;
            pnlEditPro.Visible = false;
            pnlVerProyecto.Visible = false;
            pnlEditarActividades.Visible = false;
            pnlAgregarAct.Visible = false;

            lblResult.Text = "";//limpiando campos
            lblIdProyecto.Text = "";
            codigo.Text = "";

        }

        protected void btnVisualizarInsPro_Click(object sender, EventArgs e)
        {
            try
            {
                lblResult.Text = ""; // Limpiando campos
                lblIdProyecto.Text = "";
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


        protected void btnEditarInsPro_Click(object sender, EventArgs e)
        {

            pnlEditPro.Visible = true;
            pnlGrilla.Visible = false;
            btnRegresarInsPro.Visible = true;
            lbtNuevoInsPro.Visible = false;
            listarConvocatoriaEdit();
            listarGruposAllEdit();
            pnlEditPro.Visible = true;

            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;

            codigo.Text = row.Cells[0].Text;
            lblPath.Text = row.Cells[1].Text;

            var server2 = ConnectionSqlServer.Instance;
            var result4 = server2.SelectSql<InvgccInsPro>($"SELECT * FROM INVGCCPROYECTO WHERE strId_pro = '{codigo.Text}'");

            if (result4.Count > 0)
            {
                InvgccInsPro proyecto = result4[0]; // Suponiendo que el resultado es una lista y solo deseas el primer elemento

                //Asignar los valores a los campos de edición
                txtEditTemaPro.Text = proyecto.strTema_pro;
                dtEditFechaCrea.Text = proyecto.dtFehains_pro.ToString("yyyy-MM-ddTHH:mm");
                string duracionPro = proyecto.strDuracion_pro; // Obtener el valor completo de duración

                // Extraer solo el número utilizando una expresión regular
                string numeroDuracion = Regex.Match(duracionPro, @"\d+").Value;

                // Mostrar el número en el campo txtEditTiempoPRO.Text
                txtEditTiempoPRO.Text = numeroDuracion;

                string duracionPro2 = proyecto.strDuracion_pro.ToLower(); // Convertir a minúsculas para facilitar la comparación

                // Desmarcar todas las opciones previamente seleccionadas en el DropDownList
                ddlEditDuracion.ClearSelection();

                // Verificar si contiene "mes" y establecer la opción "meses" como seleccionada
                if (duracionPro2.Contains("mes"))
                {
                    ddlEditDuracion.SelectedValue = "meses";
                }
                // Verificar si contiene "año" y establecer la opción "años" como seleccionada
                else if (duracionPro2.Contains("año"))
                {
                    ddlEditDuracion.SelectedValue = "años";
                }
                else
                {
                    // Si no se cumple ninguna de las condiciones anteriores, puedes establecer una opción predeterminada o manejar el caso según tu lógica.
                    // Por ejemplo, seleccionar "meses" por defecto.
                    ddlEditDuracion.SelectedValue = "meses";
                }





                // Asignar el valor al DropDownList ddlEditEstadoPro
                if (!string.IsNullOrEmpty(proyecto.strEstado_pro) && ddlEditEstadoPro.Items.FindByValue(proyecto.strEstado_pro) != null)
                {
                    ddlEditEstadoPro.SelectedValue = proyecto.strEstado_pro;
                }
                else
                {
                    // Si el valor no existe en el DropDownList, establecer el índice 0 como valor predeterminado.
                    ddlEditEstadoPro.SelectedIndex = 0;
                }

                // Asignar el valor al DropDownList ddlEditConv
                if (!string.IsNullOrEmpty(proyecto.fkId_conv) && ddlEditConv.Items.FindByValue(proyecto.fkId_conv) != null)
                {
                    ddlEditConv.SelectedValue = proyecto.fkId_conv;
                }
                else
                {
                    // Si el valor no existe en el DropDownList, establecer el índice 0 como valor predeterminado.
                    ddlEditConv.SelectedIndex = 0;
                }

                // Asignar el valor al DropDownList ddlGrupoEdit
                if (!string.IsNullOrEmpty(proyecto.fkId_gru) && ddlGrupoEdit.Items.FindByValue(proyecto.fkId_gru) != null)
                {
                    ddlGrupoEdit.SelectedValue = proyecto.fkId_gru;
                }
                else
                {
                    // Si el valor no existe en el DropDownList, establecer el índice 0 como valor predeterminado.
                    ddlGrupoEdit.SelectedIndex = 0;
                }




                //    }



            }
        }

        protected void btnBorrarInsPro_Click(object sender, EventArgs e)
        {

            lblResult.Text = "";//limpiando campos
            //lblIdProyecto.Text = "";
            codigo.Text = "";

            try
            {
                GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;
                string fullPath = row.Cells[1].Text;
                string id = row.Cells[0].Text;
                //lblIdProyecto.Text = id;
                if (System.IO.File.Exists(fullPath))
                {
                    lblResult.Text = "Archivo Eliminado con exito...";
                    lblResult.Visible = false;
                    System.IO.FileInfo info = new System.IO.FileInfo(fullPath);
                    info.Attributes = System.IO.FileAttributes.Normal;
                    System.IO.File.Delete(fullPath);


                }
                else
                {

                }//si no tiene adjuntos elimina el registro

                var server4 = ConnectionSqlServer.Instance;
                if (server4.Delete("INVGCCPROYECTO", $"strId_pro = '{id}'"))
                {
                    pnlAgregarAct.Visible = false;
                    pnlGrilla.Visible = true;
                    pnlActividades.Visible = false;
                    gvwActividades.Visible = false;
                    mostrarRegistrosGrilla();
                    //mostrarActividadesAsociadas(lblIdProyecto.Text);
                    codigo.Text = "Eliminación correcta";
                    Msg("Eliminación EXitosa", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    codigo.Visible = true;

                }
                else
                {
                    codigo.Text = "Error al eliminar";
                    Msg("Error al eliminar", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    codigo.Visible = true;
                    mostrarRegistrosGrilla();
                }


            }
            catch (Exception ee)
            {
                Msg("Registro asociado a relaciones....", "ww", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                codigo.Text = "Registro asociado a relaciones....";
                codigo.Visible = true;
                mostrarRegistrosGrilla();

            }


        }

        protected void btnActividades_Click(object sender, EventArgs e)
        {
            codigo.Text = "";//limpiando mensaje
            codigo.Visible = false;
            pnlGrilla.Visible = false;
            pnlActividades.Visible = true;
            btnRegresarInsPro.Visible = true;
            pnlAgregarInsPro.Visible = false;
            lbtNuevoInsPro.Visible = false;
            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;


            lblIdProyecto.Text = row.Cells[0].Text;
            lblIdProyecto.Visible = false;
            mostrarActividadesAsociadas(lblIdProyecto.Text);


            lblMostrarProyecto.ForeColor = Color.Red;

            lblMostrarProyecto.Text = "**USTED ESTÁ EN EL PROYECTO: " + row.Cells[2].Text + "**";
            pnlVerProyecto.Visible = true;
            Msg("USTED ESTÁ EN EL PROYECTO: " + row.Cells[2].Text, "II", "GESTIÓN GENERAL DE INVESTIGACIÓN");


        }

        protected void lblNuevaActividad_Click(object sender, EventArgs e)
        {
            pnlActividades.Visible = false;
            btnRegresarInsPro.Visible = true;
            pnlAgregarAct.Visible = true;
            lblIdProyecto.Visible = true;
        }

        public void mostrarActividadesAsociadas(string id)
        {
            var server2 = ConnectionSqlServer.Instance;

            //var result1 = server2.SelectSql<InvgccAct>("InvgccAct"); ///filtra segun los parametros enviados

            var result1 = server2.SelectSql<InvgccAct>($"SELECT * FROM INVGCCACTIVIDADES Where fkId_pro = '{id}'"); /// filtra todo

            //var result4 = server2.SelectSql<InvgccConvocatori>($"SELECT * FROM InvgccConvocatori WHERE strId_conv = '{id}'");
            gvwActividades.DataSource = result1;
            gvwActividades.DataBind();
        }

        protected void btnVisualizarAct_Click(object sender, EventArgs e)
        {
            try
            {
                codigo.Text = "";
                lblResult.Text = "";

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
                    Msg("NO SE PUDO LOCALIZAR ESTE ADJUNTO", "WW", "SISTEMA GENERAL DE INVESTIGACIÓN");
                    codigo.Visible = true;
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


        protected void btnBorrarAct_Click(object sender, EventArgs e)
        {
            lblResult.Text = "";//limpiando campos
            //lblIdProyecto.Text = "";
            codigo.Text = "";

            try
            {
                GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;
                string fullPath = row.Cells[1].Text;
                string id = row.Cells[0].Text;
                if (System.IO.File.Exists(fullPath))
                {
                    lblResult.Text = "Archivo Eliminado con exito...";
                    lblResult.Visible = false;
                    System.IO.FileInfo info = new System.IO.FileInfo(fullPath);
                    info.Attributes = System.IO.FileAttributes.Normal;
                    System.IO.File.Delete(fullPath);


                }
                else
                {

                }//si no tiene adjuntos elimina el registro

                var server4 = ConnectionSqlServer.Instance;
                if (server4.Delete("INVGCCACTIVIDADES", $"strId_act = '{id}'"))
                {
                    pnlAgregarAct.Visible = false;
                    pnlActividades.Visible = true;
                    gvwActividades.Visible = true;
                    mostrarActividadesAsociadas(lblIdProyecto.Text);
                    lblResult.Text = "Eliminaciòn correcta";
                    Msg("Eliminaciòn correcta", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    //mostrarRegistrosGrilla();
                }
                else
                {
                    lblResult.Text = "Error al eliminar";
                    Msg("Error al eliminar", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                }



            }
            catch (Exception ee)
            {
                codigo.Text = "Registro asociado a relaciones....";
                Msg("Registro asociado con otro...", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");

            }
        }

        


        protected void lbtCancelAct_Click(object sender, EventArgs e)
        {
            pnlAgregarAct.Visible = false;
            pnlActividades.Visible = true;
        }

        protected void lbtnAddAct_Click(object sender, EventArgs e)
        {
            //try
            //{
                if (flpAdjuntoAct.HasFile)
                {
                    string fileName = Server.HtmlEncode(flpAdjuntoAct.FileName);
                    string extension = System.IO.Path.GetExtension(fileName).ToLower();

                    if (extension == ".pdf" || extension == ".xls" || extension == ".xlsx")
                    {
                        if (AreRequiredFieldsFilled())
                        {
                            DateTime fechaInicio, fechaFin;
                            if (DateTime.TryParse(dtFechaIniAct.Text, out fechaInicio) && DateTime.TryParse(dtFechaFinAct.Text, out fechaFin))
                            {
                                if (fechaFin >= fechaInicio)
                                {
                                    var server1 = ConnectionSqlServer.Instance;

                                    var query = "SELECT TOP 1 strId_act FROM INVGCCACTIVIDADES ORDER BY CAST(SUBSTRING(strId_act, 2, LEN(strId_act)) AS INT) DESC";
                                    var ultimoProyecto = server1.SelectSql<InvgccAct>(query).FirstOrDefault();
                                    string ultimoId = ultimoProyecto?.strId_act ?? "A1";

                                    int ultimoNumero = 0;
                                    if (!string.IsNullOrEmpty(ultimoId) && ultimoId.Length > 1)
                                    {
                                        int.TryParse(ultimoId.Substring(1), out ultimoNumero);
                                    }

                                    string savePath = GetSavePath(extension);
                                    flpAdjuntoAct.SaveAs(savePath);

                                    int nuevoNumero = ultimoNumero + 1;
                                    string nuevoId = "A" + nuevoNumero.ToString();

                                    float decPrecio_pro2 = 0;
                                    
                                        //decPrecio_pro2 = float.Parse(fltPrecioRecAct.Text);
                                    

                                    float decCosto_act = float.Parse(fltPrecioAct.Text);
                                    float decValortotal_act = decPrecio_pro2 + decCosto_act;

                                    InvgccAct actividad = new InvgccAct
                                    {
                                        strId_act = nuevoId,
                                        strNombre_act = txtNombreAct.Text,
                                        strDescripcion_act = txtDescripcionAct.Text,
                                        dtFechaini_act = fechaInicio,
                                        dtFechafinal_act = fechaFin,
                                        strInsumos_pro =  "NO APLICA",
                                        decPrecio_pro2 = decPrecio_pro2,
                                        decCosto_act = decCosto_act,
                                        strArchivo_act = string.Concat(savePath),
                                        strEstado_act = ddlEstadoAct.SelectedValue,
                                        decValortotal_act = decCosto_act,
                                        fkId_pro = lblIdProyecto.Text
                                    };

                                    server1.Insert("INVGCCACTIVIDADES", actividad);

                                    pnlAgregarAct.Visible = false;
                                    pnlActividades.Visible = true;
                                    gvwActividades.Visible = true;
                                    mostrarActividadesAsociadas(lblIdProyecto.Text);

                                    Msg("Registro insertado exitosamente", "SS", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                                    lblResult.Visible = false;
                                    LimpiarCamposActividad();
                                }
                                else
                                {
                                    Msg("Error: La fecha final no puede ser menor que la fecha de inicio", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                                    lblResult.Text = "Error: La fecha final no puede ser menor que la fecha de inicio";
                                    lblResult.Visible = false;
                                }
                            }
                            else
                            {
                                Msg("Error: Formato de fecha inválido", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                                lblResult.Text = "Error: Formato de fecha inválido";
                                lblResult.Visible = false;
                            }
                        }
                        else
                        {
                            Msg("Error: Llene todos los campos", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                            lblResult.Text = "Error: Llene todos los campos";
                            lblResult.Visible = false;
                        }
                    }
                    else
                    {
                        Msg("Error: Solo se admiten archivos con extensión .pdf, .xls o .xlsx", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                        lblResult.Text = "Error: Solo se admiten archivos con extensión .pdf, .xls o .xlsx";
                        lblResult.Visible = false;
                    }
                }
                else
                {
                    Msg("Error: Seleccione primero el archivo .pdf, .xls o .xlsx", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    lblResult.Text = "Error: Seleccione primero el archivo .pdf, .xls o .xlsx";
                    lblResult.Visible = false;
                }
            //}
            //catch (Exception ex)
            //{
            //    Msg("Error en el proceso: " + ex.Message, "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            //    lblResult.Text = "Error en el proceso: " + ex.Message;
            //    lblResult.Visible = true;
            //}
        }



        private string GetSavePath(string fileExtension)
        {
            string dia = DateTime.Now.Day.ToString("00");
            string hora = DateTime.Now.Hour.ToString("00");
            string minuto = DateTime.Now.Minute.ToString("00");
            string segundo = DateTime.Now.Second.ToString("00");
            string savePath = "ACTIVIDAD" + "-";
            string path1 = @"c://FILESUTC/0/UTC/PROYECTOS/ACTIVIDADES";
            string fileName = $"{dia}-{hora}-{minuto}-{segundo}{fileExtension}";
            return System.IO.Path.Combine(path1, fileName);
        }

        private bool AreRequiredFieldsFilled()
        {
            return !string.IsNullOrEmpty(txtNombreAct.Text) &&
                !string.IsNullOrEmpty(txtDescripcionAct.Text) &&
                !string.IsNullOrEmpty(dtFechaIniAct.Text) &&
                !string.IsNullOrEmpty(dtFechaFinAct.Text) &&
                !string.IsNullOrEmpty(fltPrecioAct.Text) &&
                !string.IsNullOrEmpty(ddlEstadoAct.SelectedValue);
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
        protected decimal GetTotalPrecio()
        {
            decimal total = 0;

            foreach (GridViewRow row in gvwActividades.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    Label lblPrecioTotal = row.FindControl("lblPrecioTotal") as Label;
                    if (lblPrecioTotal != null)
                    {
                        decimal precioTotal;
                        if (decimal.TryParse(lblPrecioTotal.Text, NumberStyles.Currency, CultureInfo.CurrentCulture, out precioTotal))
                        {
                            total += precioTotal;
                        }
                    }
                }
            }

            return total;
        }



        protected void lbtnCancellEditAct_Click(object sender, EventArgs e)
        {
            pnlEditPro.Visible = false;
            pnlEditarActividades.Visible = false;
            //pnlGrilla.Visible = true;
            pnlActividades.Visible = true;
            btnRegresarInsPro.Visible = true;

        }

        protected void lbtnEditAct_Click(object sender, EventArgs e)
        {
            try
            {
                if (!flpEditActividad.HasFile)
                {
                    // Código existente para actualizar los detalles de la actividad sin adjunto
                    var server3 = ConnectionSqlServer.Instance;

                    InvgccAct gru1 = new InvgccAct
                    {
                        strNombre_act = txtEditNombreAct.Text,
                        strDescripcion_act = txtEditDescAct.Text,
                        dtFechaini_act = Convert.ToDateTime(dtFechaInicioEdit.Text),
                        dtFechafinal_act = Convert.ToDateTime(dtFechaFinEdit.Text),
                        decCosto_act = float.Parse(fltprecioEdit.Text),
                        strEstado_act = ddlEstadoEditAct.SelectedValue,
                        decValortotal_act = float.Parse(fltprecioEdit.Text)
                    };


                    gru1.strInsumos_pro = "NO APLICA";
                    gru1.decPrecio_pro2 = 0;



                    bool parametrosLlenos = !string.IsNullOrEmpty(txtEditNombreAct.Text) ||
                        !string.IsNullOrEmpty(txtEditDescAct.Text) ||
                        !string.IsNullOrEmpty(dtFechaInicioEdit.Text) ||
                        !string.IsNullOrEmpty(dtFechaFinEdit.Text) ||
                        !string.IsNullOrEmpty(fltprecioEdit.Text);

                    if (parametrosLlenos)
                    {
                        if (gru1.dtFechafinal_act >= gru1.dtFechaini_act)
                        {
                            if (server3.Update("INVGCCACTIVIDADES", gru1, $"strId_act = '{codigo.Text}'"))
                            {
                                Msg("Registro Actualizado con éxito", "SS", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                                pnlActividades.Visible = true;
                                gvwActividades.Visible = true;
                                LimpiarCamposActividad();
                                mostrarActividadesAsociadas(lblIdProyecto.Text);
                               
                                pnlEditarActividades.Visible = false;

                                txtEditNombreAct.Text = string.Empty;
                                txtEditDescAct.Text = string.Empty;
                                dtFechaInicioEdit.Text = string.Empty;
                                dtFechaFinEdit.Text = string.Empty;
                                fltprecioEdit.Text = string.Empty;
                            }
                        }
                        else
                        {
                            Msg("La fecha final no puede ser menor que la fecha de inicio", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                        }
                    }
                    else
                    {
                        Msg("Campos vacíos", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    }
                }
                else
                {
                    // Código para el caso en que se adjunte un archivo
                    //string fullPath = GetFullFilePath(); // Debes proporcionar la implementación de esta función

                    if (System.IO.File.Exists(fullPath))
                    {
                        System.IO.FileInfo info = new System.IO.FileInfo(fullPath);
                        info.Attributes = System.IO.FileAttributes.Normal;
                        System.IO.File.Delete(fullPath);
                    }

                    string fileName = Server.HtmlEncode(flpEditActividad.FileName);
                    string extension = System.IO.Path.GetExtension(fileName).ToLower();

                    if (extension == ".xls" || extension == ".xlsx" || extension == ".pdf")
                    {
                        // Procesar el archivo adjunto
                        string savePath = GetSavePathForInscripcionActividad(extension);
                        flpEditActividad.SaveAs(savePath);

                        var server3 = ConnectionSqlServer.Instance;

                        InvgccAct gru1 = new InvgccAct
                        {
                            strNombre_act = txtEditNombreAct.Text,
                            strDescripcion_act = txtEditDescAct.Text,
                            dtFechaini_act = Convert.ToDateTime(dtFechaInicioEdit.Text),
                            dtFechafinal_act = Convert.ToDateTime(dtFechaFinEdit.Text),
                            decCosto_act = float.Parse(fltprecioEdit.Text),
                            strEstado_act = ddlEstadoEditAct.SelectedValue,
                            strArchivo_act = string.Concat(savePath),
                            decValortotal_act = float.Parse(fltprecioEdit.Text)
                        };

                        // Validar RadioButtons para el manejo de insumos

                        gru1.strInsumos_pro = "NO APLICA";
                        gru1.decPrecio_pro2 = 0;


                        if (server3.Update("INVGCCACTIVIDADES", gru1, $"strId_act = '{codigo.Text}'"))
                        {
                            Msg("Registro Actualizado con éxito", "SS", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                            pnlActividades.Visible = true;
                            gvwActividades.Visible = true;
                            LimpiarCamposActividad();
                            mostrarActividadesAsociadas(lblIdProyecto.Text);
                            pnlEditarActividades.Visible = false;

                            txtEditNombreAct.Text = string.Empty;
                            txtEditDescAct.Text = string.Empty;
                            dtFechaInicioEdit.Text = string.Empty;
                            dtFechaFinEdit.Text = string.Empty;
                            fltprecioEdit.Text = string.Empty;
                        }
                        else
                        {
                            Msg("Error al actualizar", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                        }
                    }
                    else
                    {
                        Msg("Error: Solo se admiten archivos PDF o Excel", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    }
                }
            }
            catch (Exception ex)
            {
                Msg("Error en el proceso: " + ex.Message, "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }
        }




        protected void LbtnEditPro_Click(object sender, EventArgs e)
        {
            if (!flpEditIns.HasFile)
            {
                try
                {
                    string duracion = txtEditTiempoPRO.Text;
                    string unidad = ddlEditDuracion.SelectedValue;

                    int duracionValor = 0;
                    if (int.TryParse(duracion, out duracionValor))
                    {
                        // Verificar si la duración es válida según la unidad seleccionada
                        bool duracionValida = false;

                        if (unidad == "años" && duracionValor <= 2)
                        {
                            duracionValida = true;
                        }
                        else if (unidad == "meses" && duracionValor <= 12)
                        {
                            duracionValida = true;
                        }

                        if (!duracionValida)
                        {
                            // Mostrar un mensaje de error si la duración es inválida
                            Msg("La duración seleccionada no es válida(MÁXIMO 12 MESES O 2 AÑOS)", "EE", "SISTEMA INTEGRADO DE GESTIÓN");

                            pnlEditPro.Visible = true;
                            return;
                        }
                    }
                    else
                    {
                        // Mostrar un mensaje de error si la duración no es un número válido
                        Msg("La duración ingresada no es válida(MÁXIMO 2 AÑOS O 12 MESES)", "EE", "SISTEMA INTEGRADO DE GESTIÓN");

                        pnlEditPro.Visible = true;
                        return;
                    }
                    var server3 = ConnectionSqlServer.Instance;

                    InvgccInsPro proyecto = new InvgccInsPro
                    {

                        strTema_pro = txtEditTemaPro.Text,
                        strDuracion_pro = txtEditTiempoPRO.Text + " " + ddlEditDuracion.SelectedValue,
                        dtFehains_pro = Convert.ToDateTime(dtEditFechaCrea.Text),
                        //strArchivo_pro = savePath,
                        strEstado_pro = ddlEditEstadoPro.SelectedValue,
                        fkId_conv = ddlEditConv.SelectedValue,
                        fkId_gru = ddlGrupoEdit.SelectedValue

                    };

                    bool parametrosLlenos = !string.IsNullOrEmpty(txtEditTemaPro.Text) ||
                          !string.IsNullOrEmpty(txtEditTiempoPRO.Text) ||
                          !string.IsNullOrEmpty(dtEditFechaCrea.Text);


                    if (parametrosLlenos)
                    {

                        if (server3.Update("INVGCCPROYECTO", proyecto, $"strId_pro = '{codigo.Text}'"))
                        {
                            Msg("Registro Actualizado con éxito", "SS", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                            codigo.Text = "Registro Actualizado con éxito";
                            pnlEditPro.Visible = false;
                            LimpiarCamposEditar();
                            pnlGrilla.Visible = true;
                            mostrarRegistrosGrilla();
                            lbtNuevoInsPro.Visible = true;
                            btnRegresarInsPro.Visible = false;
                            pnlEditarActividades.Visible = false;
                            pnlEditPro.Visible = false;




                            txtEditNombreAct.Text = string.Empty;
                            txtEditDescAct.Text = string.Empty;
                            dtFechaInicioEdit.Text = string.Empty;
                            dtFechaFinEdit.Text = string.Empty;
                            fltprecioEdit.Text = string.Empty;
                            //fltPrecioTotEditAct.Text = string.Empty;
                        }

                    }
                    else
                    {
                        Msg("Campos vacíos", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                        codigo.Text = "Llene todos los campos";
                    }
                }
                catch (Exception)
                {
                    Msg("Error al actualizar", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    codigo.Text = "Error al actualizar";
                }
            }
            else
            {


                if (System.IO.File.Exists(lblPath.Text))
                {
                    System.IO.FileInfo info = new System.IO.FileInfo(lblPath.Text);
                    info.Attributes = System.IO.FileAttributes.Normal;
                    System.IO.File.Delete(lblPath.Text);
                }

                string fileName = Server.HtmlEncode(flpEditIns.FileName);
                string extension = System.IO.Path.GetExtension(fileName);

                if (extension == ".pdf" || extension==".xlsx" || extension==".xls")
                {
                    string savePath = GetSavePathForInscripcionEdit(extension);
                    flpEditIns.SaveAs(savePath);

                    var server3 = ConnectionSqlServer.Instance;

                    InvgccInsPro proyecto = new InvgccInsPro
                    {
                        strTema_pro = txtEditTemaPro.Text,
                        strDuracion_pro = txtEditTiempoPRO.Text + " " + ddlEditDuracion.SelectedValue,
                        dtFehains_pro = Convert.ToDateTime(dtEditFechaCrea.Text),
                        strArchivo_pro = savePath,
                        strEstado_pro = ddlEditEstadoPro.SelectedValue,
                        fkId_conv = ddlEditConv.SelectedValue,
                        fkId_gru = ddlGrupoEdit.SelectedValue
                    };

                    bool parametrosLlenos = !string.IsNullOrEmpty(txtEditTemaPro.Text) ||
                        !string.IsNullOrEmpty(txtEditTiempoPRO.Text) ||
                        !string.IsNullOrEmpty(dtEditFechaCrea.Text) ||
                        !flpEditIns.HasFile;

                    if (parametrosLlenos)
                    {

                        if (server3.Update("INVGCCPROYECTO", proyecto, $"strId_pro = '{codigo.Text}'"))
                        {
                            Msg("Registro Actualizado con éxito", "SS", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                            codigo.Text = "Registro Actualizado con éxito";
                            pnlGrilla.Visible = true;
                            LimpiarCamposEditar();
                            pnlEditarActividades.Visible = false;
                            lbtNuevoInsPro.Visible = true;
                            mostrarRegistrosGrilla();
                            pnlEditPro.Visible = false;
                            btnRegresarInsPro.Visible = false;


                            txtEditNombreAct.Text = string.Empty;
                            txtEditDescAct.Text = string.Empty;
                            dtFechaInicioEdit.Text = string.Empty;
                            dtFechaFinEdit.Text = string.Empty;
                            fltprecioEdit.Text = string.Empty;
                            //fltPrecioTotEditAct.Text = string.Empty;
                        }

                    }
                    else
                    {
                        Msg("Error: Parámetros vacíos", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                        codigo.Text = "Error, llene todos los campos";
                    }
                }
                else
                {
                    Msg("Error: Solo se admiten archivos PDF o Excel", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    codigo.Text = "Solo se admiten archivos PDF o excel";
                }
            }

        }

        protected void lbtnCancellPro_Click(object sender, EventArgs e)
        {
            pnlEditPro.Visible = false;
            pnlGrilla.Visible = true;
            lbtNuevoInsPro.Visible = true;

        }

        protected void gvwListadoInsPro_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton btnActividades = (LinkButton)e.Row.FindControl("btnActividades");
                string estado = DataBinder.Eval(e.Row.DataItem, "strEstado_pro").ToString();

                if (estado != "APROBADO")
                {
                    btnActividades.Visible = false;
                }
                else
                {
                    btnActividades.Visible = true; // Asegúrate de establecer el botón como visible si el estado es "APROBADO"
                }
            }
        }

        //protected decimal SumarPreciosTotales()
        //{
        //    decimal suma = 0;

        //    foreach (GridViewRow row in gvwActividades.Rows)
        //    {
        //        decimal precioTotal;
        //        if (decimal.TryParse(row.Cells[9].Text, out precioTotal))
        //        {
        //            suma += precioTotal;
        //        }
        //    }

        //    return suma;
        //}
        //protected void gvwActividades_RowDataBound(object sender, GridViewRowEventArgs e)
        //{
        //    //if (e.Row.RowType == DataControlRowType.DataRow)
        //    //{
        //    //    decimal precioTotal = Convert.ToDecimal(e.Row.Cells[8].Text); // El índice 8 representa la columna "VALOR TOTAL"
        //    //    Session["TotalSum"] = Convert.ToDecimal(Session["TotalSum"]) + precioTotal;
        //    //}
        //    //else if (e.Row.RowType == DataControlRowType.Footer)
        //    //{
        //    //    e.Row.CssClass = "fila-suma";
        //    //}
        //}


        protected void gvwActividades_PreRender(object sender, EventArgs e)
        {
            //if (gvwActividades.Rows.Count > 0)
            //{
            //    // Mover el footer al final de la grilla
            //    GridViewRow footerRow = new GridViewRow(0, 0, DataControlRowType.Footer, DataControlRowState.Normal);
            //    TableCell cell = new TableCell();
            //    cell.ColumnSpan = gvwActividades.Columns.Count - 1; // Ajusta el número de columnas
            //    footerRow.Cells.Add(cell);
            //    gvwActividades.Controls[0].Controls.Add(footerRow);

            //    // Agregar el total en la nueva celda del footer
            //    cell = new TableCell();
            //    cell.Text = "TOTAL: " + totalPrecio.ToString() + "$";
            //    cell.CssClass = "mostrar-precio";
            //    footerRow.Cells.Add(cell);

            //    // Agregar texto en otra celda del footer
            //    cell = new TableCell();
            //    cell.Text = "Texto adicional";
            //    footerRow.Cells.Add(cell);
            //}
        }




        //if (gvwActividades.Rows.Count > 0)
        //{
        //    decimal total = 0;

        //    // Recorre cada fila del GridView y suma el valor de decValortotal_act
        //    foreach (GridViewRow row in gvwActividades.Rows)
        //    {
        //        decimal precio = 0;
        //        var cell = row.Cells[8];
        //        if (cell.Controls.Count > 0 && cell.Controls[0] is DataBoundLiteralControl)
        //        {
        //            var literalControl = (DataBoundLiteralControl)cell.Controls[0];
        //            if (decimal.TryParse(literalControl.Text, out precio))
        //            {
        //                total += precio;
        //            }
        //        }
        //    }

        //    // Obtener la fila del footer del GridView
        //    GridViewRow footerRow = gvwActividades.FooterRow;

        //    // Obtener la celda correspondiente al total en el footerRow
        //    TableCell cellTotal = footerRow.Cells[8];

        //    // Establecer el valor total en la celda del footer
        //    cellTotal.Text = total.ToString();

        //    // Agregar la clase "mostrar-precio" a la celda del footer
        //    cellTotal.CssClass = "mostrar-precio";
    

    protected void gvwActividades_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                decimal precio = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "decValortotal_act"));

                //Agregar el precio al total
               totalPrecio += precio;
            }
            else if (e.Row.RowType == DataControlRowType.Footer)
            {
                if (gvwActividades.Rows.Count > 0)
                {
                    //Mover el footer al final de la grilla
                    gvwActividades.UseAccessibleHeader = true;
                    gvwActividades.HeaderRow.TableSection = TableRowSection.TableHeader;
                   

                    //Mostrar el total en la celda del footer
                    e.Row.Cells[7].Text = totalPrecio.ToString() + "$";
                    e.Row.Cells[7].CssClass = "mostrar-precio";

                    //Agregar texto en otra celda del footer

                    // Mover el footer al final de la grilla
                    gvwActividades.Controls[0].Controls.Add(e.Row);
                    
                }
            }
        }

        //protected void rblPreguntarAgregarInsumosOK_CheckedChanged(object sender, EventArgs e)
        //{
        //    rblPreguntarAgregarInsumosNO.Checked = false;

        //    pnlAddRecursos.Visible = true;
        //}

        //protected void rblPreguntarAgregarInsumosNO_CheckedChanged(object sender, EventArgs e)
        //{
        //    rblPreguntarAgregarInsumosOK.Checked = false;
        //    pnlAddRecursos.Visible = false;
        //}

        //protected void rblPreguntarEditInsumosOK_CheckedChanged(object sender, EventArgs e)
        //{
        //    rblPreguntarEditnsumosNO.Checked = false;
        //    pnlEditInsumosAct.Visible = true;
        //}

        //protected void rblPreguntarEditnsumosNO_CheckedChanged(object sender, EventArgs e)
        //{
        //    rblPreguntarEditInsumosOK.Checked = false;
        //    pnlEditInsumosAct.Visible = false;
        //}
        public string fullPath;
        protected void btnEditarAct_Click(object sender, EventArgs e)
        {
            try
            {
                pnlEditarActividades.Visible = true;
            pnlGrilla.Visible = false;
            pnlActividades.Visible = false;

            // Obtener el GridViewRow a partir del LinkButton que activó el evento
            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;


            // Obtener el valor del código utilizando DataKeyNames
            //string codigoValue = gvwActividades.DataKeys[row.RowIndex].Value.ToString();
            //codigo.Text = "A1";
            codigo.Text = row.Cells[0].Text;
            fullPath = row.Cells[1].Text;
            codigo.Visible = true;
            lblIdProyecto.Visible = false;

            var server2 = ConnectionSqlServer.Instance;
            var result4 = server2.SelectSql<InvgccAct>($"SELECT * FROM INVGCCACTIVIDADES WHERE strId_act = '{codigo.Text}'");

            if (result4.Count > 0)
            {
                InvgccAct actividad = result4[0]; // Suponiendo que el resultado es una lista y solo deseas el primer elemento

                // Asignar los valores a los campos de edición
                txtEditNombreAct.Text = actividad.strNombre_act;
                txtEditDescAct.Text = actividad.strDescripcion_act;
                dtFechaInicioEdit.Text = actividad.dtFechaini_act.ToString("yyyy-MM-ddTHH:mm");
                dtFechaFinEdit.Text = actividad.dtFechafinal_act.ToString("yyyy-MM-ddTHH:mm");
                fltprecioEdit.Text = actividad.decCosto_act.ToString();

                bool insumosAplica = !string.IsNullOrEmpty(actividad.strInsumos_pro) && !actividad.strInsumos_pro.Equals("NO APLICA");
               
                pnlEditInsumosAct.Visible = insumosAplica;

                // Verificar si el nombre de los insumos está disponible y asignar el valor a los campos de texto correspondientes.
                txtEditRecursosAct.Text = insumosAplica ? actividad.strInsumos_pro : "";

                // Asignar el precio a los campos de texto correspondientes.
                txtPrecioEditAct.Text = insumosAplica ? actividad.decPrecio_pro2.ToString() : "0";

                // Asegurarse de que el DropDownList y el objeto centroInvestigacion sean válidos
                if (ddlEstadoEditAct != null && actividad.strEstado_act != null)
                {
                    // Verifica si el valor strEstado_act es válido para el DropDownList
                    if (ddlEstadoEditAct.Items.FindByValue(actividad.strEstado_act.ToString()) != null)
                    {
                        // Asigna el valor al SelectedValue del DropDownList ddlEstadoEditAct
                        ddlEstadoEditAct.SelectedValue = actividad.strEstado_act.ToString();
                    }
                    else
                    {
                        // El valor strEstado_act no es válido para el DropDownList
                        // Puedes manejar este caso según tus necesidades, por ejemplo, mostrar un mensaje de error
                    }
                }
                else
                {
                    // El DropDownList o el objeto centroInvestigacion son nulos
                    // Puedes manejar este caso según tus necesidades, por ejemplo, mostrar un mensaje de error
                }
            }
            }
            catch (Exception)
            {
                Msg("Error al cargar datos para edición", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                codigo.Text = "Error al cargar datos para edición";
            }
        }





        // Método auxiliar para obtener el índice de columna por el nombre
        //private int getColumnIndexByName(GridView gridView, string columnName)
        //{
        //    for (int i = 0; i < gridView.Columns.Count; i++)
        //    {
        //        if (gridView.Columns[i].HeaderText.Equals(columnName))
        //        {
        //            return i;
        //        }
        //    }
        //    return -1; // Si no se encuentra la columna, devuelve -1
        //}













        //protected void gvwActividades_DataBound(object sender, EventArgs e)
        //{
        //    if (gvwActividades.Rows.Count > 0)
        //    {
        //        decimal total = 0;

        //        // Recorre cada fila del GridView y suma el valor de decValortotal_act
        //        foreach (GridViewRow row in gvwActividades.Rows)
        //        {
        //            decimal precio = 0;
        //            if (decimal.TryParse(row.Cells[8].Text, out precio))
        //            {
        //                total += precio;
        //            }
        //        }

        //        // Crea una nueva fila en el footer del GridView y muestra el total calculado
        //        GridViewRow footerRow = new GridViewRow(0, 0, DataControlRowType.Footer, DataControlRowState.Normal);

        //        // Agrega celdas vacías para las columnas ocultas
        //        for (int i = 0; i < gvwActividades.Columns.Count - 4; i++)
        //        {
        //            TableCell emptyCell = new TableCell();
        //            footerRow.Cells.Add(emptyCell);
        //        }

        //        // Agrega la celda con el texto del total y los estilos correspondientes
        //        TableCell totalCell = new TableCell();
        //        totalCell.ColumnSpan = 4; // Ajusta el colspan según el número de columnas que ocultaste
        //        totalCell.Text = "Total: " + total.ToString();
        //        totalCell.CssClass = "text-left";
        //        footerRow.Cells.Add(totalCell);

        //        gvwActividades.Controls[0].Controls.Add(footerRow);
        //    }
        //}







    }

}