using System;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using utc.Models;
using utc.Settigns; 

namespace utc
{
    public partial class Valoracion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                mostrarValoraciones();
                cargarGrupos();
            }
        }

        // ======================== CARGAR DATOS ========================
        private void mostrarValoraciones()
        {
            try
            {
                var server = ConnectionSqlServer.Instance;
                var lista = server.Select<InvgccValoracion>("INVGCCVALORACION");
                gvValoracion.DataSource = lista;
                gvValoracion.DataBind();
            }
            catch (Exception ex)
            {
                Msg("Error al cargar valoraciones: " + ex.Message, "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }
        }

        private void cargarGrupos()
        {
            try
            {
                var server = ConnectionSqlServer.Instance;
                var grupos = server.Select<InvgccGrupoInvestigacion>("INVGCCGRUPO_INVESTIGACION");

                ddlGrupo.DataSource = grupos;
                ddlGrupo.DataTextField = "strNombre_gru";
                ddlGrupo.DataValueField = "strId_gru";
                ddlGrupo.DataBind();

                ddlGrupo.Items.Insert(0, new ListItem("-- Seleccione Grupo --", ""));
            }
            catch (Exception ex)
            {
                Msg("Error al cargar grupos: " + ex.Message, "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }
        }

        // ======================== NUEVA VALORACIÓN ========================
        protected void lbtNuevoValo_Click(object sender, EventArgs e)
        {
            pnlGrilla.Visible = false;
            pnlAgregarValo.Visible = true;
            btnRegresarValo.Visible = true;
            lbtNuevoValo.Visible = false;
        }

        protected void btnRegresarValo_Click(object sender, EventArgs e)
        {
            pnlGrilla.Visible = true;
            pnlAgregarValo.Visible = false;
            btnRegresarValo.Visible = false;
            lbtNuevoValo.Visible = true;
            mostrarValoraciones();
        }

        protected void lbtAddValo_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlGrupo.SelectedValue == "")
                {
                    Msg("Seleccione un grupo.", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    return;
                }

                if (!flpArchivoValo.HasFile)
                {
                    Msg("Debe adjuntar un archivo PDF.", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    return;
                }

                string extension = Path.GetExtension(flpArchivoValo.FileName).ToLower();
                if (extension != ".pdf")
                {
                    Msg("Solo se permiten archivos PDF.", "ww", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    return;
                }

                string savePath = GetSavePathForValoracion(extension);
                flpArchivoValo.SaveAs(savePath);

                var server = ConnectionSqlServer.Instance;
                var lista = server.Select<InvgccValoracion>("INVGCCVALORACION");

                // generar nuevo ID automático (V1, V2, ...)
                string ultimoId = "V0";
                if (lista != null && lista.Count > 0)
                {
                    ultimoId = lista[lista.Count - 1].strId_valo.ToString();
                }

                int ultimoNum = 0;
                if (ultimoId.Length > 1)
                {
                    int.TryParse(ultimoId.Substring(1), out ultimoNum);
                }

                string nuevoId = "V" + (ultimoNum + 1).ToString();

                // calcular categoría de valoración
                string categoriaValoracion = CalcularCategoria(txtPuntajeValo.Text);
                int puntaje = int.Parse(txtPuntajeValo.Text);

                // Guardar la valoración
                InvgccValoracion val = new InvgccValoracion();
                val.strId_valo = Convert.ToInt32(ultimoNum + 1); // si tu PK es numérica
                val.fkId_gru = ddlGrupo.SelectedValue;
                val.strInforme_valo = savePath;
                val.intPuntaje_valo = puntaje;
                val.strCategoria_valo = categoriaValoracion;
                val.strReconocimiento_valo = txtReconocimiento.Text;
                val.dtFecha_valo = Convert.ToDateTime(dtFechaValo.Text);

                server.Insert("INVGCCVALORACION", val);

                // 🟢 Actualizar categoría en la tabla de GRUPO_INVESTIGACION
                string nuevaCategoria = (puntaje >= 70) ? "CONSOLIDADO" : "EMERGENTE";
                string idGrupo = ddlGrupo.SelectedValue;

                string updateSql = "UPDATE INVESTIGACION.dbo.INVGCCGRUPO_INVESTIGACION " +
                                   "SET strCategoria_gru = '" + nuevaCategoria + "' " +
                                   "WHERE strId_gru = '" + idGrupo + "'";

                server.UpdateSql(updateSql);

                Msg("Valoración registrada con éxito y categoría actualizada a " + nuevaCategoria + ".",
                    "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");

                pnlAgregarValo.Visible = false;
                pnlGrilla.Visible = true;
                btnRegresarValo.Visible = false;
                lbtNuevoValo.Visible = true;
                mostrarValoraciones();
            }
            catch (Exception ex)
            {
                Msg("Error al guardar valoración: " + ex.Message, "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }
        }

        // ======================== VER ARCHIVO PDF ========================
        protected void btnVerArchivoValo_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = (GridViewRow)((LinkButton)sender).NamingContainer;
                HiddenField hfRuta = (HiddenField)row.FindControl("hfRutaInforme");
                string filePath = hfRuta.Value;

                if (File.Exists(filePath))
                {
                    Response.Clear();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("Content-Disposition", "inline; filename=" + Path.GetFileName(filePath));
                    Response.WriteFile(filePath);
                    Response.Flush();
                    Response.End();
                }
                else
                {
                    Msg("El archivo no se encontró en el servidor.", "ww", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                }
            }
            catch (Exception ex)
            {
                Msg("Error al visualizar el archivo: " + ex.Message, "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }
        }

        // ======================== ELIMINAR REGISTRO ========================
        protected void btnBorrarValo_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = (GridViewRow)((LinkButton)sender).NamingContainer;
                string idValo = row.Cells[0].Text;
                HiddenField hfRuta = (HiddenField)row.FindControl("hfRutaInforme");
                string filePath = hfRuta.Value;

                var server = ConnectionSqlServer.Instance;

                if (server.Delete("INVGCCVALORACION", "strId_valo = '" + idValo + "'"))
                {
                    if (File.Exists(filePath))
                    {
                        File.Delete(filePath);
                    }

                    Msg("Valoración eliminada correctamente.", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    mostrarValoraciones();
                }
                else
                {
                    Msg("Error al eliminar la valoración.", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                }
            }
            catch (Exception ex)
            {
                Msg("Error al eliminar: " + ex.Message, "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            }
        }

        // ======================== MÉTODOS AUXILIARES ========================
        private string GetSavePathForValoracion(string extension)
        {
            string path = @"C:\UTC\VALORACIONES";
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            string fileName = "VALORACION_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + extension;
            return Path.Combine(path, fileName);
        }

        private string CalcularCategoria(string puntajeTxt)
        {
            int puntaje;
            if (int.TryParse(puntajeTxt, out puntaje))
            {
                if (puntaje >= 70) return "CONSOLIDADO";
                if (puntaje <= 69) return "EMERGENTE";
                return "DEFICIENTE";
            }
            return "NO DEFINIDA";
        }

        private void Msg(string msg, string tipo, string titulo)
        {
            titulo = titulo.ToUpper();
            string script = "";

            switch (tipo.ToUpper())
            {
                case "SS":
                    script = "toastr.success('" + msg + "', '" + titulo + "');";
                    break;
                case "EE":
                    script = "toastr.error('" + msg + "', '" + titulo + "');";
                    break;
                case "WW":
                    script = "toastr.warning('" + msg + "', '" + titulo + "');";
                    break;
                case "II":
                    script = "toastr.info('" + msg + "', '" + titulo + "');";
                    break;
                default:
                    script = "toastr.error('" + msg + "', '" + titulo + "');";
                    break;
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "toastr_message", script, true);
        }
    }
}
