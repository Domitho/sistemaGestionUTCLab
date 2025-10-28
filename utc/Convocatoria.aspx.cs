using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.Sql;
using System.Data;
using utc.Settigns;
using System.IO;
using utc.Models;

namespace utc
{
    public partial class _Default : Page
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
            strFechaIniConv.Text = fechaActual.ToString("yyyy-MM-ddTHH:mm");

            DateTime fechaInicio = DateTime.Parse(strFechaIniConv.Text);
            DateTime fechaFin = fechaInicio.AddDays(15);
            strFechaFinConv.Text = fechaFin.ToString("yyyy-MM-ddTHH:mm");




        }



        public void mostrarRegistrosGrilla()//metodo para listar convocatoria
        {
           
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.Select<InvgccConvocatori>("INVGCCCONVOCATORI"); /// filtra todo

            gvwListadoConvocatoriaInv.DataSource = result1;
            gvwListadoConvocatoriaInv.DataBind();
        }
        protected void lbtNuevaNormativa_Click(object sender, EventArgs e)
        {
            lbtNormativa.Visible = false;
            lbtNuevaNormativa.Visible = false;
            btnRegresarConvocatoria.Visible = true;
            pnlAgregarConvocatoria.Visible = true;
            lblMsg.Text = "";
            codigo.Text = "";
            pnlGrilla.Visible = false;

        }

        protected void btnRegresarConvocatoria_Click(object sender, EventArgs e)
        {
            lbtNormativa.Visible = false;
            lbtNuevaNormativa.Visible = true;
            btnRegresarConvocatoria.Visible = false;
            pnlAgregarConvocatoria.Visible = false;
            codigo.Text = "";
            pnlGrilla.Visible = true;
        }


        public void guardarConv()
        {
            try
            {
                if (flpArchivoConvocatoriaAdd.HasFile)
                {//SI SUBE EL ARCHIVO, CAPTURO LOS ATRIBUTOS, ESPECIALMENTE EXTENSION
                    string fileName = Server.HtmlEncode(flpArchivoConvocatoriaAdd.FileName);
                    string extension = System.IO.Path.GetExtension(fileName);
                    if (extension == ".pdf" || extension == ".xlsx" || extension == ".xls")
                    {



                        DateTime fechaFin;
                        DateTime.TryParse(strFechaFinConv.Text, out fechaFin);

                        DateTime fechaInicio;
                        DateTime.TryParse(strFechaIniConv.Text, out fechaInicio);

                        if (fechaFin < fechaInicio)
                        {
                            mostrarError("La fecha de finalización no puede ser inferior a la fecha de inicio de la convocatoria.");
                            return;
                        }
                        string savePath = GetSavePathForconvocatory(extension);

                        flpArchivoConvocatoriaAdd.SaveAs(savePath);
                        // es pdf
                        codigo.Text = fileName + " guardado exitosamente...";
                        codigo.Visible = false;

                        var server1 = ConnectionSqlServer.Instance;

                        var query = "SELECT TOP 1 strId_conv FROM[INVESTIGACION].[dbo].[INVGCCCONVOCATORI] ORDER BY CAST(SUBSTRING(strId_conv, 5, LEN(strId_conv)) AS INT) DESC";
                        var ultimoConv = server1.SelectSql<InvgccConvocatori>(query).FirstOrDefault();
                        string ultimoId = ultimoConv?.strId_conv ?? "CONV1";

                        // Extraer el número del último valor utilizado
                        int ultimoNumero = 0;
                        if (!string.IsNullOrEmpty(ultimoId) && ultimoId.Length > 4)
                        {
                            int.TryParse(ultimoId.Substring(4), out ultimoNumero);
                        }

                        // Incrementar el número en 1
                        int nuevoNumero = ultimoNumero + 1;

                        // Generar el nuevo valor de strId_publi
                        string nuevoId = "CONV" + nuevoNumero.ToString();

                        InvgccConvocatori conv = new InvgccConvocatori
                        {
                            strId_conv = nuevoId,
                            strNombre_conv = txtNombreConv.Text,
                            strDescripcion_conv = txtDescripcionConv.Text,
                            dtFechaini_conv = fechaInicio,
                            dtFechafin_conv = fechaFin,
                            strArchivo_conv = savePath
                        };

                        server1.Insert("INVGCCCONVOCATORI", conv);

                        mostrarExito("Registro Exitoso");
                        LimpiarCampos();
                        mostrarRegistrosGrilla();


                    }
                    else
                    {
                        Msg("SOLO SE ADMITEN ARCHIVOS PDF O EXCEL", "EE", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    }
                }
                else
                {
                    Msg("SELECCIONE UN ARCHIVO", "EE", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                }
        }
            catch (Exception)
            {
                mostrarError("ERROR AL CREAR REGISTRO");
    }
}
        private string GetSavePathForconvocatory(string fileExtension)
        {
            string dia = DateTime.Now.Day.ToString("00");
            string hora = DateTime.Now.Hour.ToString("00");
            string minuto = DateTime.Now.Minute.ToString("00");
            string segundo = DateTime.Now.Second.ToString("00");
            string savePath = "INSCRIPCION" + "-";
            string path1 = @"c://FILESUTC/0/UTC/CONVOCATORIA/"; // RUTA FISICA
            string fileName = $"Convocatoria-{dia}-{hora}-{minuto}-{segundo}{fileExtension}";
            return System.IO.Path.Combine(path1, fileName);
        }

        private void mostrarError(string mensaje)
        {
            //codigo.Text = mensaje;
            Msg(mensaje, "WW", "SISTEMA INTEGRADO DE GESTIÓN");
            codigo.Visible = true;
            pnlAgregarConvocatoria.Visible = true;
            lbtNormativa.Visible = false;
            lbtNuevaNormativa.Visible = false;
            btnRegresarConvocatoria.Visible = true;
        }

        private void mostrarExito(string mensaje)
        {
            //codigo.Text = "EXITO AL GUARDAR";
            pnlAgregarConvocatoria.Visible = false;
            lbtNormativa.Visible = false;
            lbtNuevaNormativa.Visible = true;
            btnRegresarConvocatoria.Visible = false;
            mostrarRegistrosGrilla();
            pnlGrilla.Visible = true;
            LimpiarCampos();
            Msg(mensaje, "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
        }

        private int ObtenerNuevoNumero(string ultimoId)
        {
            int ultimoNumero = 0;
            if (!string.IsNullOrEmpty(ultimoId) && ultimoId.Length > 5)
            {
                int.TryParse(ultimoId.Substring(5), out ultimoNumero);
            }

            return ultimoNumero + 1;
        }



        protected void lbtADDConvocatoria_Click(object sender, EventArgs e)
        {
            if (txtNombreConv.Text != "" || txtDescripcionConv.Text != "" || strFechaIniConv.Text != "" || strFechaIniConv.Text != "")
            {

                guardarConv();
               
                // cont = cont++;
               
            
            }
            else
            {
                //codigo.Text = "ERROR, PARAMETROS VACIOS";
                Msg("Error, llene todos los campos", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
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
        protected void lbtCancelarConvocatoria_Click(object sender, EventArgs e)
        {
            pnlAgregarConvocatoria.Visible = false;
            lbtNormativa.Visible = false;
            lbtNuevaNormativa.Visible = true;
            btnRegresarConvocatoria.Visible = false;
           
            pnlGrilla.Visible = true;

        }
        
        protected void btnEditarConvInv_Click(object sender, EventArgs e)
        {
            pnlEditarConvocatoria.Visible = true;
            pnlGrilla.Visible = false;
            pnlAgregarConvocatoria.Visible = false;
            lbtNormativa.Visible = false;
            lbtNuevaNormativa.Visible = false;
            btnRegresarConvocatoria.Visible = true;

            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;

            codigo.Text = row.Cells[0].Text;
            fullpath1.Text = row.Cells[1].Text;
            codigo.Visible = false;

            var server2 = ConnectionSqlServer.Instance;
            var result4 = server2.SelectSql<InvgccConvocatori>($"SELECT * FROM INVGCCCONVOCATORI WHERE strId_conv = '{codigo.Text}'");

            if (result4.Count > 0)
            {
                InvgccConvocatori convocatoria = result4[0]; // Suponiendo que el resultado es una lista y solo deseas el primer elemento

                // Asignar los valores a los campos de edición
                txtEditNombreConv.Text = convocatoria.strNombre_conv;
                dtEditFechaIni.Text = convocatoria.dtFechaini_conv.ToString("yyyy-MM-ddTHH:mm");
                dtEditFechaFin.Text = convocatoria.dtFechafin_conv.ToString("yyyy-MM-ddTHH:mm");
                txtEditDescripcionConv.Text = convocatoria.strDescripcion_conv;
            }


        }

        protected void btnBorrarConvInv_Click(object sender, EventArgs e)
        {
            try
            {

                codigo.Visible = false;
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
                if (server4.Delete("INVGCCCONVOCATORI", $"strId_conv = '{codigo.Text}'"))
                {
                    codigo.Text = "Eliminaciòn correcta";
                    Msg("Registro Eliminado con Exito", "ss", "SISTEMA INTEGRADO DE GESTIÓN");
                    mostrarRegistrosGrilla();
                }
                else
                {
                    Msg("Error al eliminar,intente nuevamente.", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                    codigo.Text = "Error al eliminar";
                }

            }
            catch (Exception ex)
            {

                codigo.Text = "Error al eliminar, posible registro asociado a otra entidad...";
                Msg("Error al eliminar, posible registro asociado a otra entidad..", "ww", "SISTEMA INTEGRADO DE GESTIÓN");
            }
        }
        public void LimpiarCampos()
        {
            txtNombreConv.Text = string.Empty;
            txtDescripcionConv.Text = string.Empty;
            strFechaIniConv.Text = string.Empty;
            strFechaFinConv.Text = string.Empty;
            // Limpiar otros campos si es necesario
        }


        protected void lbnEditConvocatoria_Click(object sender, EventArgs e)
        {
            try
            {
                /////update
                var server3 = ConnectionSqlServer.Instance;

                DateTime fechaInicio = Convert.ToDateTime(dtEditFechaIni.Text);
                DateTime fechaFin = Convert.ToDateTime(dtEditFechaFin.Text);

                if (fechaFin < fechaInicio)//estan mal 
                {
                    codigo.Text = "La fecha de finalización no puede ser menor que la fecha de inicio.";
                    Msg("La fecha de finalización no puede ser menor que la fecha de inicio.", "ww", "SISTEMA INTEGRADO DE GESTIÓN");
                    pnlGrilla.Visible = false;
                    mostrarRegistrosGrilla();
                    pnlEditarConvocatoria.Visible = true;
                    return;

                }
                else if (fechaFin > fechaInicio)
                {//esta bien las fechas
                    if (!flpArchivoConvEdit.HasFile)// no edita archivo
                    {


                        InvgccConvocatori conv1 = new InvgccConvocatori
                        {
                            strNombre_conv = txtEditNombreConv.Text,
                            dtFechaini_conv = fechaInicio,
                            dtFechafin_conv = fechaFin,
                            strDescripcion_conv = txtEditDescripcionConv.Text,
                        };

                        if (server3.Update("INVGCCCONVOCATORI", conv1, $"strId_conv = '{codigo.Text}'"))
                        {
                            Msg("Registro Actualizado con éxito", "SS", "SISTEMA INTEGRADO DE GESTIÓN");
                            codigo.Text = "Registro Actualizado con éxito";
                            pnlGrilla.Visible = true;
                            mostrarRegistrosGrilla();
                            lbtNuevaNormativa.Visible = false;
                            pnlEditarConvocatoria.Visible = false;

                            // Limpiar los campos de edición
                            txtEditNombreConv.Text = string.Empty;
                            dtEditFechaIni.Text = string.Empty;
                            dtEditFechaFin.Text = string.Empty;
                            txtEditDescripcionConv.Text = string.Empty;
                            btnRegresarConvocatoria.Visible = false;
                        }
                        else
                        {
                            //codigo.Text = "Error al actualizar";
                            Msg("Error al actualizar", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                        }
                    }
                    else //edita el adjunto, primero borro del path 
                    {
                    if (System.IO.File.Exists(fullpath1.Text))
                    {
                        System.IO.FileInfo info = new System.IO.FileInfo(fullpath1.Text);
                        info.Attributes = System.IO.FileAttributes.Normal;
                        System.IO.File.Delete(fullpath1.Text);
                    }

                        string fileName = Server.HtmlEncode(flpArchivoConvEdit.FileName);
                        string extension = System.IO.Path.GetExtension(fileName).ToLower();

                        if (extension == ".xls" || extension == ".xlsx" || extension == ".pdf")
                        {
                            // Procesar el archivo adjunto
                            string savePath = GetSavePathForconvocatory(extension);
                            flpArchivoConvEdit.SaveAs(savePath);

                            InvgccConvocatori conv1 = new InvgccConvocatori
                            {
                                strNombre_conv = txtEditNombreConv.Text,
                                dtFechaini_conv = fechaInicio,
                                dtFechafin_conv = fechaFin,
                                strArchivo_conv = savePath,
                                strDescripcion_conv = txtEditDescripcionConv.Text,
                            };

                            if (server3.Update("INVGCCCONVOCATORI", conv1, $"strId_conv = '{codigo.Text}'"))
                            {
                                Msg("Registro Actualizado con éxito", "SS", "SISTEMA INTEGRADO DE GESTIÓN");
                                codigo.Text = "Registro Actualizado con éxito";
                                pnlGrilla.Visible = true;
                                mostrarRegistrosGrilla();
                                lbtNuevaNormativa.Visible = false;
                                pnlEditarConvocatoria.Visible = false;

                                // Limpiar los campos de edición
                                txtEditNombreConv.Text = string.Empty;
                                dtEditFechaIni.Text = string.Empty;
                                dtEditFechaFin.Text = string.Empty;
                                txtEditDescripcionConv.Text = string.Empty;
                                btnRegresarConvocatoria.Visible = false;
                            }
                            else
                            {
                                //codigo.Text = "Error al actualizar";
                                Msg("Error al actualizar", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                            }
                        }
                    }
                }
        }

            catch (Exception)
            {
                codigo.Text = "Error al actualizar";
                Msg("Error al actualizar", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
    }
}

        protected void lbnCancellConvocatoria_Click(object sender, EventArgs e)
        {
            pnlEditarConvocatoria.Visible = false;
            pnlGrilla.Visible = true;
            pnlAgregarConvocatoria.Visible = false;
            lbtNormativa.Visible = false;
            lbtNuevaNormativa.Visible = true;
            btnRegresarConvocatoria.Visible = false;
        }

        protected void btnVsiualizaConv_Click(object sender, EventArgs e)
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