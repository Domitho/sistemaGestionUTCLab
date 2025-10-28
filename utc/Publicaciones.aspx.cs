using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using utc.Models;
using utc.Settigns;
using System.IO;
using System.Data.SqlClient;

namespace utc
{
    public partial class Publicaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] == null)
                {

                    Response.Redirect("login.aspx");

                }
                ModalPopupExtender1.Show();
                mostrarRegistrosGrillaLibro();
                mostrarRegistrosGrillaCapLibro();
                mostrarRegistrosGrillaRevista();
                mostrarRegistrosGrillaMemoria();
                obtenerFechaActual();
                mostrarMnenu();
                obtenerRangoAnios();
                mostrarID();

                // Validación para dllRIEditRevista
                if (dllRIEditRevista.SelectedValue == "Alto Impacto")
                {
                    txtSjrEditRevista.Enabled = true; // Habilitar el TextBox si la opción seleccionada es "Alto Impacto"
                }
               

            }
        }
        public  string  cadena = @"server=LENNIN;database=INVESTIGACION;INTEGRATED SECURITY=true";
        void mostrarID()
        {
            var server1 = ConnectionSqlServer.Instance;

            var query = "SELECT TOP 1 strId_publi FROM INVGCCPUBLICACION ORDER BY CAST(SUBSTRING(strId_publi, 4, LEN(strId_publi)) AS INT) DESC";
            var ultimoCentro = server1.SelectSql<InvgccPublicacion>(query).FirstOrDefault();
            string ultimoId = ultimoCentro?.strId_publi ?? "PUB1";

            // Extraer el número del último valor utilizado
            int ultimoNumero = 0;
            if (!string.IsNullOrEmpty(ultimoId) && ultimoId.Length > 3)
            {
                int.TryParse(ultimoId.Substring(3), out ultimoNumero);
            }

            // Incrementar el número en 1
            int nuevoNumero = ultimoNumero + 1;

            // Generar el nuevo valor de strId_publi
            string nuevoId = "PUB" + nuevoNumero.ToString();

            txtCodPubliMemoriaAdd.Text = nuevoId;
           
            txtCodPubliAddRevista.Text = nuevoId;
           
            txtLibroCodPubliAdd.Text = nuevoId;
           
            txtCapLibroCodPubliAdd.Text = nuevoId;
          
        }
        void obtenerRangoAnios()
        {

            // Obtener el año actual
            int year = DateTime.Now.Year;

            // Agregar los años desde 1995 hasta el año actual al DropDownList
            for (int i = 1995; i <= year; i++)
            {
                ddlAnioRevista.Items.Add(new ListItem(i.ToString(), i.ToString()));
                ddlAnioRevistaEdit.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
        }
        void obtenerFechaActual()
        {
            DateTime fechaActual = DateTime.Now;
            txtFechaPubCapLibroAdd.Text =  fechaActual.ToString("yyyy-MM-ddTHH:mm");
            txtFechaPubLibroAdd.Text = fechaActual.ToString("yyyy-MM-ddTHH:mm");
            txtFechaPubAddRevista.Text= fechaActual.ToString("yyyy-MM-ddTHH:mm");
            txtFechaPubMemoriaAdd.Text = fechaActual.ToString("yyyy-MM-ddTHH:mm");
        }

        private void mostrarRegistrosGrillaLibro()
        {
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccPublicacion>("SELECT * FROM[INVESTIGACION].[dbo].[INVGCCPUBLICACION] where strTipo_publi='LIBRO'");

            gvwListadoLibroPub.DataSource = result1;
            gvwListadoLibroPub.DataBind();
          
        }
        private void mostrarRegistrosGrillaCapLibro()
        {
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccPublicacion>("SELECT * FROM[INVESTIGACION].[dbo].[INVGCCPUBLICACION] where strTipo_publi='CAPITULO DE LIBRO'");

            gvwGrillaCapLibro.DataSource = result1;
            gvwGrillaCapLibro.DataBind();

        }

        private void mostrarRegistrosGrillaRevista()
        {
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccPublicacion>("SELECT * FROM[INVESTIGACION].[dbo].[INVGCCPUBLICACION] where strTipo_publi='REVISTA'");

            gvwRevistas.DataSource = result1;
            gvwRevistas.DataBind();

        }

        private void mostrarRegistrosGrillaMemoria()
        {
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccPublicacion>("SELECT * FROM[INVESTIGACION].[dbo].[INVGCCPUBLICACION] where strTipo_publi='MEMORIA'");

            gvwMemoria.DataSource = result1;
            gvwMemoria.DataBind();

        }

        protected void btnEditarPub_Click(object sender, EventArgs e)
        {

        }

        protected void btnBorrarPub_Click(object sender, EventArgs e)
        {

        }

        protected void lbtNuevoPub_Click(object sender, EventArgs e)
        {

        }

        protected void btnRegresarPub_Click(object sender, EventArgs e)
        {

        }

        protected void btnMostrarModal_Click(object sender, EventArgs e)
        {
            ModalPopupExtender1.Show();
        }

        protected void btnMostrarOpcionesADD_Click(object sender, EventArgs e)
        {
            ModalPopupExtender1.Show();
            btnNuevoParticipante.Visible = false;
            pnlGrillaDetalle.Visible = false;
        }

        protected void rbl_SelectedIndexChanged(object sender, EventArgs e)
        {

            mostrarMnenu();

        }
        void mostrarMnenu()
        {
            if (rbl.SelectedValue == "LIBRO")
            {
                Msg("HAS SELECCIONADO PUBLICACIONES DE LIBRO", "II", "SISTEMA INTEGRADO DE GESTIÓN");
                pnlLibroGEN.Visible = true;

                btnMostrarOpcionesADD.Visible = true;

                pnlGrillaLibro.Visible = true;
                btnNuevoLibro.Visible = true;
                btnNuevoCapLibro.Visible = false;
                btnNuevaRevista.Visible = false;
                btnNuevaMemoria.Visible = false;

                pnlGrillaMemoria.Visible = false;
                gvwMemoria.Visible = false;

                pnlGrillaCapLibro.Visible = false;
                gvwGrillaCapLibro.Visible = false;

            }
            else if (rbl.SelectedValue == "CAPLIBRO")
            {
                Msg("HAS SELECCIONADO PUBLICACIONES DE CAPITULO DE LIBRO", "II", "SISTEMA INTEGRADO DE GESTIÓN");
                pnlLibroGEN.Visible = false;
                btnNuevoLibro.Visible = false;
                btnMostrarOpcionesADD.Visible = true;
                pnlGrillaLibro.Visible = false;

                btnNuevoCapLibro.Visible = true;
                btnNuevoLibro.Visible = false;

                btnNuevaRevista.Visible = false;
                btnNuevaMemoria.Visible = false;
                pnlLibroGEN.Visible = false;
                btnNuevoLibro.Visible = false;

                pnlGrillaLibro.Visible = false;

                pnlGrillaCapLibro.Visible = true;
                gvwGrillaCapLibro.Visible = true;

                pnlGrillaMemoria.Visible = false;
                gvwMemoria.Visible = false;

                gvwRevistas.Visible = false;
                pnlGrillaRevistas.Visible = false;
                btnNuevaRevista.Visible = false;
                mostrarRegistrosGrillaCapLibro();
            }
            else if (rbl.SelectedValue == "REVISTAS")
            {
                Msg("HAS SELECCIONADO PUBLICACIONES DE REVISTAS", "II", "SISTEMA INTEGRADO DE GESTIÓN");

                pnlLibroGEN.Visible = false;
                btnNuevoLibro.Visible = false;
                btnMostrarOpcionesADD.Visible = true;
                pnlGrillaLibro.Visible = false;

                btnNuevoCapLibro.Visible = false;
                pnlGrillaCapLibro.Visible = false;
                gvwGrillaCapLibro.Visible = false;

                gvwRevistas.Visible = false;
                pnlGrillaRevistas.Visible = false;
                btnNuevaRevista.Visible = false;

                gvwRevistas.Visible = true;
                pnlGrillaRevistas.Visible = true;
                mostrarRegistrosGrillaRevista();
                btnNuevaRevista.Visible = true;
                btnNuevoCapLibro.Visible = false;
                btnNuevoLibro.Visible = false;
                pnlGrillaMemoria.Visible = false;
                gvwMemoria.Visible = false;

                btnNuevaMemoria.Visible = false;
            }
            else if (rbl.SelectedValue == "MEMORIA")
            {
                Msg("HAS SELECCIONADO PUBLICACIONES DE MEMORIAS", "II", "SISTEMA INTEGRADO DE GESTIÓN");

                pnlLibroGEN.Visible = false;
                btnNuevoLibro.Visible = false;
                btnMostrarOpcionesADD.Visible = true;
                pnlGrillaLibro.Visible = false;

                btnNuevoCapLibro.Visible = false;
                pnlGrillaCapLibro.Visible = false;
                gvwGrillaCapLibro.Visible = false;

                gvwRevistas.Visible = false;
                pnlGrillaRevistas.Visible = false;
                btnNuevaRevista.Visible = false;

                btnNuevaMemoria.Visible = true;
                btnNuevoCapLibro.Visible = false;
                btnNuevoLibro.Visible = false;
                btnNuevaRevista.Visible = false;

                mostrarRegistrosGrillaMemoria();
                pnlGrillaMemoria.Visible = true;
                gvwMemoria.Visible = true;
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

        protected void btnNuevoLibro_Click(object sender, EventArgs e)
        {
            pnlLibroADD.Visible = true;
            pnlLibroGEN.Visible = true;
            btnMostrarOpcionesADD.Visible = false;
            pnlGrillaLibro.Visible = false;
            gvwListadoLibroPub.Visible = false;
            btnNuevoLibro.Visible = false;
        }

        protected void btnCheckmarkADDlIBRO_Click(object sender, EventArgs e)
        {
            string nuevoCodigo = txtLibroCodISBNAdd.Text;
            string connectionString = @"server=LENNIN;database=INVESTIGACION;INTEGRATED SECURITY=true";
            var server1 = ConnectionSqlServer.Instance;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query1 = "SELECT COUNT(*) FROM INVGCCPUBLICACION WHERE strCodigoissnn_publi = @nuevoCodigo";

                using (SqlCommand command = new SqlCommand(query1, connection))
                {
                    command.Parameters.AddWithValue("@nuevoCodigo", nuevoCodigo);
                    int count = (int)command.ExecuteScalar();

                    if (count > 0)
                    {
                        // Mostrar mensaje de error usando toastr
                        Msg("Código ISSN NO PUEDE REPETIRSE, INTENTE DE NUEVO", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                        return;
                    }
                }
            }
         

            var query = "SELECT TOP 1 strId_publi FROM [INVESTIGACION].[dbo].[INVGCCPUBLICACION] ORDER BY CAST(SUBSTRING(strId_publi, 4, LEN(strId_publi)) AS INT) DESC";
            var ultimoCentro = server1.SelectSql<InvgccPublicacion>(query).FirstOrDefault();
            string ultimoId = ultimoCentro?.strId_publi ?? "PUB1";

            // Extraer el número del último valor utilizado
            int ultimoNumero = 0;
            if (!string.IsNullOrEmpty(ultimoId) && ultimoId.Length > 3)
            {
                int.TryParse(ultimoId.Substring(3), out ultimoNumero);
            }

            // Incrementar el número en 1
            int nuevoNumero = ultimoNumero + 1;

            // Generar el nuevo valor de strId_publi
            string nuevoId = "PUB" + nuevoNumero.ToString();


            InvgccPublicacion publicacionLIbro = new InvgccPublicacion
            {
                strId_publi = nuevoId,
                IdCodIes = txtLibroCodIesAdd.Text,
                CodigoPubliPubli = txtLibroCodPubliAdd.Text,
                TipoPubli = "LIBRO",
                TituloPubli = txtLibroTituloAdd.Text,
                CodigoISSNNPubli = txtLibroCodISBNAdd.Text,
                //dtFecha_publi = Convert.ToDateTime(txtFechaPubLibroAdd.Text),
                dtFecha_publi = DateTime.Now,
                CampoDetalladoPubli = txtCampoDetalladoLibroAdd.Text,
                Pares = ddlParesLibroAdd.SelectedValue,
              
               
            };

             
            server1.Insert("INVGCCPUBLICACION", publicacionLIbro);
          
          
            codigo.Text = "Registro Correcto";
            Msg("Registro exitoso", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
            txtLibroCodIesAdd.Text = string.Empty;
            txtLibroCodPubliAdd.Text = string.Empty;
            txtLibroTituloAdd.Text = string.Empty;
            txtLibroCodISBNAdd.Text = string.Empty;
            txtFechaPubLibroAdd.Text = string.Empty;
            txtCampoDetalladoLibroAdd.Text = string.Empty;
            ddlParesLibroAdd.SelectedIndex = 0; // Opcionalmente, establecer el índice seleccionado predeterminado
            limpiarCamposAddLibro();
            pnlLibroGrilla.Visible = true;
            btnNuevoLibro.Visible = true;
            pnlLibroADD.Visible = false;
            pnlGrillaLibro.Visible = true;
            gvwListadoLibroPub.Visible = true;
            mostrarRegistrosGrillaLibro();
            btnMostrarOpcionesADD.Visible = true;


        }//lleno
    

        protected void btnBroomADDlIBRO_Click(object sender, EventArgs e)
        {
            limpiarCamposAddLibro();
        }
        void limpiarCamposAddLibro()
        {
            txtLibroCodIesAdd.Text = string.Empty;
            txtLibroCodPubliAdd.Text = string.Empty;
            txtLibroTituloAdd.Text = string.Empty;
            txtLibroCodISBNAdd.Text = string.Empty;
            txtFechaPubLibroAdd.Text = string.Empty;
            txtCampoDetalladoLibroAdd.Text = string.Empty;
            ddlParesLibroAdd.SelectedIndex = 0; // Opcionalmente, establecer el índice seleccionado predeterminado
          
        }
        protected void btnXADDlIBRO_Click(object sender, EventArgs e)
        {
            limpiarCamposAddLibro();
            pnlLibroGrilla.Visible = true;
            btnNuevoLibro.Visible = true;
            pnlLibroADD.Visible = false;
            pnlGrillaLibro.Visible = true;
            gvwListadoLibroPub.Visible = true;
            mostrarRegistrosGrillaLibro();
            btnMostrarOpcionesADD.Visible = true;
        }

        public bool ValidarDocumento(string documento)
        {
            // Remover espacios en blanco y guiones del documento
            string documentoSinFormato = documento.Replace(" ", "").Replace("-", "");

            // Validar formato de cédula
            if (documentoSinFormato.Length == 10 && documentoSinFormato.All(char.IsDigit))
            {
                int suma = 0;
                int verificador = int.Parse(documentoSinFormato[9].ToString());

                for (int i = 0; i < 9; i++)
                {
                    int digito = int.Parse(documentoSinFormato[i].ToString());

                    if (i % 2 == 0)
                    {
                        digito *= 2;

                        if (digito > 9)
                        {
                            digito -= 9;
                        }
                    }

                    suma += digito;
                }

                int residuo = suma % 10;
                int digitoVerificador = (residuo == 0) ? 0 : 10 - residuo;

                return digitoVerificador == verificador;
            }
            // Validar formato de pasaporte
            else if (documentoSinFormato.Length == 9 && documentoSinFormato.All(char.IsLetterOrDigit))
            {
                // Aquí puedes implementar tu propia lógica de validación para pasaportes si es necesario
                // Por ejemplo, verificar que el primer carácter sea una letra, etc.
                return true;
            }
            else
            {
                return false;
            }
        }

        protected void btnEditarLibro_Click(object sender, EventArgs e)
        {
            pnlLibroEdit.Visible = true;
            pnlGrillaLibro.Visible = false;
            gvwListadoLibroPub.Visible = false;
            btnNuevoLibro.Visible = false;
            btnMostrarOpcionesADD.Visible = false;

            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;

            codigo.Text = row.Cells[0].Text;

            var server2 = ConnectionSqlServer.Instance;
            var result4 = server2.SelectSql<InvgccPublicacion>($"SELECT * FROM INVGCCPUBLICACION WHERE strId_publi = '{codigo.Text}'");
            if (result4.Count > 0)
            {
                InvgccPublicacion publicacion = result4[0]; // Suponiendo que el resultado es una lista y solo deseas el primer elemento

                txtEditCodIesLibro.Text = publicacion.IdCodIes;
                txtEditCodPubliLibro.Text = publicacion.strId_publi;
                txtEditTituloLibro.Text = publicacion.TipoPubli;
                txtEditCapLibroCodPubli.Text = publicacion.strId_publi;
                txtEditCodISBNLibro.Text = publicacion.CodigoISSNNPubli;
                txtEditFechaPubLibro.Text = publicacion.dtFecha_publi.ToString("yyyy-MM-ddTHH:mm");
                txtEditCampoDetalladoLibro.Text = publicacion.CampoDetalladoPubli;
                string valorSeleccionadoPares = publicacion.Pares;
                ListItem itemSeleccionadoPares = ddlEditParesLibro.Items.FindByValue(valorSeleccionadoPares);
                if (itemSeleccionadoPares != null)
                {
                    ddlEditParesLibro.SelectedValue = valorSeleccionadoPares;
                }
                else
                {
                    // El valor no está presente en la lista, puedes manejar este caso según tus necesidades
                    // Por ejemplo, mostrar un mensaje de error o asignar un valor por defecto
                }

             

            }
        }




        protected void btnBorrarLibro_Click(object sender, EventArgs e)
        {
            try
            {

                codigo.Visible = false;
                /////delete
                GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;

                codigo.Text = row.Cells[0].Text;
                var server4 = ConnectionSqlServer.Instance;
                if (server4.Delete("INVGCCPUBLICACION", $"strId_publi = '{codigo.Text}'"))
                {
                    Msg("Eliminación correcta", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    codigo.Text = "Eliminaciòn correcta";
                    mostrarRegistrosGrillaLibro();
                    gvwListadoLibroPub.Visible = true;
                    pnlGrillaLibro.Visible = true;
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

        protected void btnNuevoCapLibro_Click(object sender, EventArgs e)
        {
            pnlGrillaCapLibro.Visible = false;
            gvwGrillaCapLibro.Visible = false;
            btnMostrarOpcionesADD.Visible = false;
            pnlADDCapLibro.Visible = true;
            btnNuevoCapLibro.Visible = false;
        }

        protected void btnADDCapLibro_Click(object sender, EventArgs e)
        {
            string nuevoCodigo = txtCapLibroCodISBNAdd.Text;
            string connectionString = cadena;
            var server1 = ConnectionSqlServer.Instance;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query1 = "SELECT COUNT(*) FROM INVGCCPUBLICACION WHERE strCodigoissnn_publi = @nuevoCodigo";

                using (SqlCommand command = new SqlCommand(query1, connection))
                {
                    command.Parameters.AddWithValue("@nuevoCodigo", nuevoCodigo);
                    int count = (int)command.ExecuteScalar();

                    if (count > 0)
                    {
                        // Mostrar mensaje de error usando toastr
                        Msg("Código ISSN NO PUEDE REPETIRSE, INTENTE DE NUEVO", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                        return;
                    }
                }
            }

       

            var query = "SELECT TOP 1 strId_publi FROM INVGCCPUBLICACION ORDER BY CAST(SUBSTRING(strId_publi, 4, LEN(strId_publi)) AS INT) DESC";
            var ultimoCentro = server1.SelectSql<InvgccPublicacion>(query).FirstOrDefault();
            string ultimoId = ultimoCentro?.strId_publi ?? "PUB1";

            // Extraer el número del último valor utilizado
            int ultimoNumero = 0;
            if (!string.IsNullOrEmpty(ultimoId) && ultimoId.Length > 3)
            {
                int.TryParse(ultimoId.Substring(3), out ultimoNumero);
            }

            // Incrementar el número en 1
            int nuevoNumero = ultimoNumero + 1;

            // Generar el nuevo valor de strId_publi
            string nuevoId = "PUB" + nuevoNumero.ToString();


            InvgccPublicacion publicacionCapLIbro = new InvgccPublicacion
            {
                strId_publi = nuevoId,
                IdCodIes = txtCapLibroCodIesAdd.Text,
                CodigoPubliPubli = txtCapLibroCodPubliAdd.Text,
                TipoPubli = "CAPITULO DE LIBRO",
                strTituloclib_publi = txtCapLibroTituloCapAdd.Text,
                strPaginasclib_publi = txtPagsCapLibroAdd.Text,
                strEditorcompiladorclib_publi = txttags1.Text,
                TituloPubli = txtCapLibroTituloAdd.Text,
                CodigoISSNNPubli = txtCapLibroCodISBNAdd.Text,
                //dtFecha_publi = Convert.ToDateTime(txtFechaPubCapLibroAdd.Text),
                dtFecha_publi = DateTime.Now,
                CampoDetalladoPubli = txtCampoDetalladoCapLibroAdd.Text

            };

           


                server1.Insert("INVGCCPUBLICACION", publicacionCapLIbro);
                

                codigo.Text = "Registro Correcto";
                Msg("Registro exitoso", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                pnlADDCapLibro.Visible = false;
                pnlGrillaCapLibro.Visible = true;
                gvwGrillaCapLibro.Visible = true;
                mostrarRegistrosGrillaCapLibro();
                btnMostrarOpcionesADD.Visible = true;
            btnNuevoCapLibro.Visible = true;
        Msg("SI DESEA INGRESAR OTRO PARTICIPANTE LLENE LOS DATOS CORRESPONDIENTE.. CASO CONTRARIO CANCELE EL REGISTRO O LIMPIELO", "ii", "GESTIÓN GENERAL DE INVESTIGACIÓN");
          
        }

        protected void btnLimpiarCapLibro_Click(object sender, EventArgs e)
        {
            LimpiarCamposCapLibro();
        }

        protected void btnCancelarADDCapLibro_Click(object sender, EventArgs e)
        {
            LimpiarCamposCapLibro();
            pnlADDCapLibro.Visible = false;
            pnlGrillaCapLibro.Visible = true;
            gvwGrillaCapLibro.Visible = true;
            mostrarRegistrosGrillaCapLibro();
            btnMostrarOpcionesADD.Visible = true;

        }
        protected void LimpiarCamposCapLibro()
        {
            txtCapLibroCodIesAdd.Text = string.Empty;
            txtCapLibroCodPubliAdd.Text = string.Empty;
            txtCapLibroTituloCapAdd.Text = string.Empty;
            txtCapLibroTituloAdd.Text = string.Empty;
            txtCapLibroCodISBNAdd.Text = string.Empty;
            txttags1.Text = string.Empty;
            txtPagsCapLibroAdd.Text = string.Empty;
            txtFechaPubCapLibroAdd.Text = string.Empty;
            txtCampoDetalladoCapLibroAdd.Text = string.Empty;
         
        }

        protected void btnEditarCapLibro_Click(object sender, EventArgs e)
        {
            pnlEditCapLibro.Visible = true;
            pnlGrillaCapLibro.Visible = false;
            btnNuevoCapLibro.Visible = false;
            gvwGrillaCapLibro.Visible = false;
            btnMostrarOpcionesADD.Visible = false;

            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;
            codigo.Text = row.Cells[0].Text;

            var server2 = ConnectionSqlServer.Instance;
            var result4 = server2.SelectSql<InvgccPublicacion>($"SELECT * FROM INVGCCPUBLICACION WHERE strId_publi = '{codigo.Text}'");
            if (result4.Count > 0)
            {
                InvgccPublicacion publicacion = result4[0]; // Suponiendo que el resultado es una lista y solo deseas el primer elemento

                txtEditCapLibroCodIes.Text = publicacion.IdCodIes;
                txtEditCapLibroCodPubli.Text = publicacion.CodigoPubliPubli;
                txtEditCapLibroTituloLibro.Text = publicacion.TituloPubli;
                txtEditCapLibroCodISBN.Text = publicacion.CodigoISSNNPubli;
                txtEditCapLibroFechaPub.Text = publicacion.dtFecha_publi.ToString("yyyy-MM-ddTHH:mm");
                txtEditCapLibroCampoDetallado.Text = publicacion.CampoDetalladoPubli;
                txtEditCapLibroTituloCap.Text = publicacion.strTituloclib_publi;
                txtEditCapLibroEditorCompilador.Text = publicacion.strEditorcompiladorclib_publi;
                txtEditCapLibroPags.Text = publicacion.strPaginasclib_publi;
     

            }



        }

        protected void btnBorrarCapLibro_Click(object sender, EventArgs e)
        {
            try
            {

                codigo.Visible = false;
                /////delete
                GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;

                codigo.Text = row.Cells[0].Text;
                var server4 = ConnectionSqlServer.Instance;
                if (server4.Delete("INVGCCPUBLICACION", $"strId_publi = '{codigo.Text}'"))
                {
                    Msg("Eliminación correcta", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    codigo.Text = "Eliminaciòn correcta";
                    mostrarRegistrosGrillaCapLibro();
                    gvwGrillaCapLibro.Visible = true;
                    pnlGrillaCapLibro.Visible = true;
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

        protected void btnEditarRevistas_Click(object sender, EventArgs e)
        {
            pnlEditRevistas.Visible = true;
            pnlGrillaRevistas.Visible = false;
            gvwRevistas.Visible = false;
            btnNuevaRevista.Visible = false;
            btnMostrarOpcionesADD.Visible = false;

            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;
            string idPubli = row.Cells[0].Text;
            codigo.Text = idPubli;
            var server = ConnectionSqlServer.Instance;
            var result = server.SelectSql<InvgccPublicacion>($"SELECT * FROM INVGCCPUBLICACION WHERE strId_publi = '{idPubli}'");
            if (result.Count > 0)
            {
                InvgccPublicacion publicacion = result[0]; // Suponiendo que el resultado es una lista y solo deseas el primer elemento

                ddlAnioRevistaEdit.SelectedValue = publicacion.strAnio_publi;
                txtCodIesEditRevista.Text = publicacion.IdCodIes;
               
                txtCodPubliEditRevista.Text = publicacion.strId_publi;
                txtTituloPubliEditRevista.Text = publicacion.TituloPubli;
               
                txtCodISSNEditRevista.Text = publicacion.CodigoISSNNPubli;
                //txtNombreEditRevista.Text = publicacion.NombrePubli;
                txtNumeroRevistaEditRevista.Text = publicacion.strNumr_publi;
                txtNombreEditRevista.Text = publicacion.strnombrerevis_publi;
                
                txtSjrEditRevista.Text = publicacion.SjrPubli;
                txtFechaPubEditRevista.Text = publicacion.dtFecha_publi.ToString("yyyy-MM-ddTHH:mm");
                txtCampoDetEditRevista.Text = publicacion.CampoDetalladoPubli;
               
                txtLinkPubliEditRevista.Text = publicacion.LinkPubli;
                txtLinkRevistaEditRevista.Text = publicacion.LinkRevistaPubli;
               
             
                // Validación de dllRIEditRevista
                if (dllRIEditRevista.Items.FindByValue(publicacion.strRegImp_publi) != null)
                {
                    dllRIEditRevista.SelectedValue = publicacion.strRegImp_publi;
                }
                else
                {
                    // El valor de publicacion.strRegImp_publi no es válido, realiza alguna acción o muestra un mensaje de error
                }

                // Validación de ddlTipoPubEditRevista
                if (ddlTipoPubEditRevista.Items.FindByValue(publicacion.TipoPubli) != null)
                {
                    ddlTipoPubEditRevista.SelectedValue = publicacion.TipoPubli;
                }
                else
                {
                    // El valor de publicacion.TipoPubli no es válido, realiza alguna acción o muestra un mensaje de error
                }

                // Validación de ddlEstadoEditRevista
                if (ddlEstadoEditRevista.Items.FindByValue(publicacion.EstadoPubli) != null)
                {
                    ddlEstadoEditRevista.SelectedValue = publicacion.EstadoPubli;
                }
                else
                {
                    // El valor de publicacion.EstadoPubli no es válido, realiza alguna acción o muestra un mensaje de error
                }

              
            }
        }


        protected void btnBorrarRevistas_Click(object sender, EventArgs e)
        {
            try
            {

                codigo.Visible = false;
                /////delete
                GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;

                codigo.Text = row.Cells[0].Text;
                var server4 = ConnectionSqlServer.Instance;
                if (server4.Delete("INVGCCPUBLICACION", $"strId_publi = '{codigo.Text}'"))
                {
                    Msg("Eliminación correcta", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    codigo.Text = "Eliminaciòn correcta";
                    mostrarRegistrosGrillaRevista();
                    gvwRevistas.Visible = true;
                    pnlGrillaRevistas.Visible = true;
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
    

        protected void btnNuevaRevista_Click(object sender, EventArgs e)
        {
            pnlADDRevistas.Visible = true;
            gvwRevistas.Visible = false;
            pnlGrillaRevistas.Visible = false;
            btnMostrarOpcionesADD.Visible = false;
            btnNuevaRevista.Visible = false;
        }

        protected void btnNuevaMemoria_Click(object sender, EventArgs e)
        {
            pnlGrillaMemoria.Visible = false;
            gvwMemoria.Visible = false;
            pnlMemoriaADD.Visible = true;
            btnMostrarOpcionesADD.Visible = false;
        }


    
        protected void btnAddRevista_Click(object sender, EventArgs e)
        {
            string nuevoCodigo = txtCodISSNAddRevista.Text;
            string connectionString = cadena;
            var server1 = ConnectionSqlServer.Instance;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query1 = "SELECT COUNT(*) FROM INVGCCPUBLICACION WHERE strCodigoissnn_publi = @nuevoCodigo";

                using (SqlCommand command = new SqlCommand(query1, connection))
                {
                    command.Parameters.AddWithValue("@nuevoCodigo", nuevoCodigo);
                    int count = (int)command.ExecuteScalar();

                    if (count > 0)
                    {
                        // Mostrar mensaje de error usando toastr
                        Msg("Código ISSN NO PUEDE REPETIRSE, INTENTE DE NUEVO", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                        return;
                    }
                }
            }

            var query = "SELECT TOP 1 strId_publi FROM INVGCCPUBLICACION ORDER BY CAST(SUBSTRING(strId_publi, 4, LEN(strId_publi)) AS INT) DESC";
            var ultimoCentro = server1.SelectSql<InvgccPublicacion>(query).FirstOrDefault();
            string ultimoId = ultimoCentro?.strId_publi ?? "PUB1";

            // Extraer el número del último valor utilizado
            int ultimoNumero = 0;
            if (!string.IsNullOrEmpty(ultimoId) && ultimoId.Length > 3)
            {
                int.TryParse(ultimoId.Substring(3), out ultimoNumero);
            }

            // Incrementar el número en 1
            int nuevoNumero = ultimoNumero + 1;

            // Generar el nuevo valor de strId_publi
            string nuevoId = "PUB" + nuevoNumero.ToString();


            InvgccPublicacion publicacionRevista = new InvgccPublicacion
            {
                strId_publi = nuevoId,
                strAnio_publi =ddlAnioRevista.SelectedValue,
                IdCodIes = txtCodIesAddRevista.Text,
               
                TipoPubli = "REVISTA",
                TipoArticuloPubli = ddlTipoPubAddRevista.SelectedValue,
                CodigoPubliPubli = txtCodPubliAddRevista.Text,
                TituloPubli = txtTituloPubliAddRevista.Text,
                BddIndeaxadaPubli = ddlBddAddRevista.Text,
                strRegImp_publi = dllRIAddRevista.Text,
                CodigoISSNNPubli = txtCodISSNAddRevista.Text,
                strnombrerevis_publi = txtNombreAddRevista.Text,
                strNumr_publi = txtNumeroRevistaAddRevista.Text,
                SjrPubli = txtSjrAddRevista.Text,
                //dtFecha_publi = Convert.ToDateTime(txtFechaPubAddRevista.Text),
                dtFecha_publi = DateTime.Now,
                CampoDetalladoPubli = txtCampoDetAddRevista.Text,
                EstadoPubli = ddlEstadoAddRevista.SelectedValue,
                LinkPubli = txtLinkPubliAddRevista.Text,
                LinkRevistaPubli = txtLinkRevistaAddRevista.Text
            };

       


                server1.Insert("INVGCCPUBLICACION", publicacionRevista);
               

            codigo.Text = "Registro Correcto";
            pnlEditRevistas.Visible = false;
            pnlGrillaRevistas.Visible = true;
            gvwRevistas.Visible = true;
            pnlADDRevistas.Visible = false;
            btnAddRevista.Visible = true;
            btnMostrarOpcionesADD.Visible = true;
            mostrarRegistrosGrillaRevista();
                Msg("Registro exitoso", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                Msg("SI DESEA INGRESAR OTRO PARTICIPANTE LLENE LOS DATOS CORRESPONDIENTE.. CASO CONTRARIO CANCELE EL REGISTRO O LIMPIELO", "ii", "GESTIÓN GENERAL DE INVESTIGACIÓN");
          
        }

        protected void btnLimpiarRevista_Click(object sender, EventArgs e)
        {
            limpiarRevistaAdd();
        }
        void limpiarRevistaAdd()
        {
            // Limpiar los campos del panel "pnlADDRevistas"
            ddlAnioRevista.SelectedIndex = 0;
            txtCodIesAddRevista.Text = string.Empty;
            ddlTipoPubAddRevista.SelectedIndex = 0;
            txtCodPubliAddRevista.Text = string.Empty;
            txtTituloPubliAddRevista.Text = string.Empty;
            ddlBddAddRevista.SelectedIndex = 0;
            dllRIAddRevista.SelectedIndex = 0;
            txtCodISSNAddRevista.Text = string.Empty;
            txtNombreAddRevista.Text = string.Empty;
            txtNumeroRevistaAddRevista.Text = string.Empty;
            txtSjrAddRevista.Text = string.Empty;
            txtFechaPubAddRevista.Text = string.Empty;
            txtCampoDetAddRevista.Text = string.Empty;
            ddlEstadoAddRevista.SelectedIndex = 0;
            txtLinkPubliAddRevista.Text = string.Empty;
            txtLinkRevistaAddRevista.Text = string.Empty;
         
        }
        protected void btnCancelarRevista_Click(object sender, EventArgs e)
        {
            limpiarRevistaAdd();
            pnlADDRevistas.Visible = false;
            pnlGrillaRevistas.Visible = true;
            gvwRevistas.Visible = true;
            mostrarRegistrosGrillaRevista();
            btnMostrarOpcionesADD.Visible = true;
        }

        protected void btnBorrarMemoria_Click(object sender, EventArgs e)
        {
            try
            {

                codigo.Visible = false;
                /////delete
                GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;

                codigo.Text = row.Cells[0].Text;
                var server4 = ConnectionSqlServer.Instance;
                if (server4.Delete("INVGCCPUBLICACION", $"strId_publi = '{codigo.Text}'"))
                {
                    Msg("Eliminación correcta", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                    codigo.Text = "Eliminaciòn correcta";
                    mostrarRegistrosGrillaMemoria();
                    gvwMemoria.Visible = true;
                    pnlGrillaMemoria.Visible = true;
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

        protected void btnEditarMemoria_Click(object sender, EventArgs e)
        {
            pnlMemoriaEdit.Visible = true;
            pnlGrillaMemoria.Visible = false;
            btnNuevaMemoria.Visible = false;
            gvwMemoria.Visible = false;
            btnMostrarOpcionesADD.Visible = false;

            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;
            string idPubli = row.Cells[0].Text;
            codigo.Text = idPubli;
            var server = ConnectionSqlServer.Instance;
            var result = server.SelectSql<InvgccPublicacion>($"SELECT * FROM INVGCCPUBLICACION WHERE strId_publi = '{idPubli}'");
            if (result.Count > 0)
            {
                InvgccPublicacion publicacion = result[0]; // Suponiendo que el resultado es una lista y solo deseas el primer elemento

                
                txtCodIesMemoriaEdit.Text = publicacion.IdCodIes;
               
                txtCodPubliMemoriaEdit.Text = publicacion.strId_publi;
                txtNombrePonenciaMemoriaEdit.Text = publicacion.NombrePonenciaMPubli;
                txtIsbnMemoriaEdit.Text = publicacion.CodigoISSNNPubli;
                txtNombreEventoMemoriaEdit.Text = publicacion.strNombreEven_publi;
               
                txtOrganizadorMemoriaEdit.Text = publicacion.OrganizadoresEventoMPubli;
                txtComiteMemoriaEdit.Text = publicacion.strComiteOrgam_publi;
                txtPaisMemoriaEdit.Text = publicacion.PaisMPubli;
                txtCiudadMemoriaEdit.Text = publicacion.CiudadMPubli;
                txtFechaPubMemoriaEdit.Text = publicacion.dtFecha_publi.ToString("yyyy-MM-ddTHH:mm");
                txtCampoDetalladoMemoriaEdit.Text = publicacion.CampoDetalladoPubli;
                txtEdicionMemoriaEdit.Text = publicacion.strEdicionEven_publi;
              

               

                // Validación de ddlTipoPubEditMemoria
                if (!string.IsNullOrEmpty(publicacion.TipoPubli))
                {
                    if (ddlTipoPubEditMemoria.Items.FindByValue(publicacion.TipoPubli) != null)
                    {
                        ddlTipoPubEditMemoria.SelectedValue = publicacion.TipoPubli;
                    }
                    else
                    {
                        // El valor de publicacion.TipoPubli no es válido, realiza alguna acción o muestra un mensaje de error
                    }
                }
            }
        }
     
        protected void btnADDMemoria_Click(object sender, EventArgs e)
        {
            string nuevoCodigo = txtIsbnMemoriaAdd.Text;
            string connectionString = cadena;
            var server1 = ConnectionSqlServer.Instance;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query1 = "SELECT COUNT(*) FROM INVGCCPUBLICACION WHERE strCodigoissnn_publi = @nuevoCodigo";

                using (SqlCommand command = new SqlCommand(query1, connection))
                {
                    command.Parameters.AddWithValue("@nuevoCodigo", nuevoCodigo);
                    int count = (int)command.ExecuteScalar();

                    if (count > 0)
                    {
                        // Mostrar mensaje de error usando toastr
                        Msg("Código ISSN NO PUEDE REPETIRSE, INTENTE DE NUEVO", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                        return;
                    }
                }
            }



            var query = "SELECT TOP 1 strId_publi FROM INVGCCPUBLICACION ORDER BY CAST(SUBSTRING(strId_publi, 4, LEN(strId_publi)) AS INT) DESC";
            var ultimoCentro = server1.SelectSql<InvgccPublicacion>(query).FirstOrDefault();
            string ultimoId = ultimoCentro?.strId_publi ?? "PUB1";

            // Extraer el número del último valor utilizado
            int ultimoNumero = 0;
            if (!string.IsNullOrEmpty(ultimoId) && ultimoId.Length > 3)
            {
                int.TryParse(ultimoId.Substring(3), out ultimoNumero);
            }

            // Incrementar el número en 1
            int nuevoNumero = ultimoNumero + 1;

            // Generar el nuevo valor de strId_publi
            string nuevoId = "PUB" + nuevoNumero.ToString();


            InvgccPublicacion publicacionMemoria = new InvgccPublicacion
            {
                strId_publi = nuevoId,

                IdCodIes = txtCodIesMemoriaAdd.Text,
                TipoPubli = "MEMORIA",
                TipoArticuloPubli = ddlTipoPubAddMemoria.SelectedValue,
                CodigoPubliPubli = txtCodPubliMemoriaAdd.Text,
                NombrePonenciaMPubli = txtNombrePonenciaMemoriaAdd.Text,
                CodigoISSNNPubli = txtIsbnMemoriaAdd.Text,
                strNombreEven_publi = txtNombrePonenciaMemoriaAdd.Text,
                strEdicionEven_publi = txtEdicionMemoriaAdd.Text,
                OrganizadoresEventoMPubli = txtOrganizadorMemoriaAdd.Text,
                strComiteOrgam_publi = txtComiteMemoriaAdd.Text,
                PaisMPubli = txtPaisMemoriaAdd.Text,
                CiudadMPubli = txtCiudadMemoriaAdd.Text,
                //dtFecha_publi = Convert.ToDateTime(txtFechaPubMemoriaAdd.Text),
                dtFecha_publi = DateTime.Now,
                CampoDetalladoPubli = txtCampoDetalladoMemoriaAdd.Text,
               

            };

         

                server1.Insert("INVGCCPUBLICACION", publicacionMemoria);
                pnlMemoriaEdit.Visible = false;
                btnMostrarOpcionesADD.Visible = true;
                   pnlMemoriaADD.Visible = false;
                pnlGrillaMemoria.Visible = true;
                mostrarRegistrosGrillaMemoria();
                btnNuevaMemoria.Visible = true;

                codigo.Text = "Registro Correcto";
                Msg("Registro exitoso", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                Msg("SI DESEA INGRESAR OTRO PARTICIPANTE LLENE LOS DATOS CORRESPONDIENTE.. CASO CONTRARIO CANCELE EL REGISTRO O LIMPIELO", "ii", "GESTIÓN GENERAL DE INVESTIGACIÓN");
         
        }

        protected void btnClearMemoria_Click(object sender, EventArgs e)
        {
            LimpiarCamposMemoriaAdd();
        }

        protected void btnCancellMemoria_Click(object sender, EventArgs e)
        {
            LimpiarCamposMemoriaAdd();
            btnADDMemoria.Visible = true;
            pnlGrillaMemoria.Visible = true;
            gvwMemoria.Visible = true;
            mostrarRegistrosGrillaMemoria();
            pnlMemoriaADD.Visible = false;
            btnMostrarOpcionesADD.Visible = true;
        }
        protected void LimpiarCamposMemoriaAdd()
        {
            txtCodIesMemoriaAdd.Text = string.Empty;
            ddlTipoPubAddMemoria.SelectedIndex = 0;
            txtCodPubliMemoriaAdd.Text = string.Empty;
            txtNombrePonenciaMemoriaAdd.Text = string.Empty;
            txtIsbnMemoriaAdd.Text = string.Empty;
            txtNombreEventoMemoriaAdd.Text = string.Empty;
            txtEdicionMemoriaAdd.Text = string.Empty;
            txtOrganizadorMemoriaAdd.Text = string.Empty;
            txtComiteMemoriaAdd.Text = string.Empty;
            txtPaisMemoriaAdd.Text = string.Empty;
            txtCiudadMemoriaAdd.Text = string.Empty;
            txtFechaPubMemoriaAdd.Text = string.Empty;
            txtCampoDetalladoMemoriaAdd.Text = string.Empty;
         
        }

        protected void btnCheckmarkEditLibro_Click(object sender, EventArgs e)
        {
            var server2 = ConnectionSqlServer.Instance;
            string codigoActual = codigo.Text; // Guarda el código actual antes de actualizar

            // Obtener el valor de CodigoISSNNPubli (strCodigoissnn_publi) del registro actual
            string nuevoCodigo = txtEditCodISBNLibro.Text;

            string connectionString = cadena;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                // Verificar si el nuevo valor de strCodigoissnn_publi ya existe en la tabla para otro registro distinto al que se está actualizando
                string query = "SELECT COUNT(*) FROM INVGCCPUBLICACION WHERE strCodigoissnn_publi = @nuevoCodigo AND strId_publi != @codigoActual";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@nuevoCodigo", nuevoCodigo);
                    command.Parameters.AddWithValue("@codigoActual", codigoActual);
                    int count = (int)command.ExecuteScalar();

                    if (count > 0)
                    {
                        // Mostrar mensaje de error usando toastr
                        Msg("El código ISSN ya está en uso en otro registro. No se puede actualizar.", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                        return;
                    }
                }
            }
          
            InvgccPublicacion libro = new InvgccPublicacion
            {
                strId_publi = codigo.Text,
                IdCodIes = txtEditCodIesLibro.Text,
                SjrPubli = txtSjrEditRevista.Text,
                CodigoPubliPubli = txtEditCodPubliLibro.Text,
                TituloPubli = txtEditTituloLibro.Text,
                CodigoISSNNPubli = txtEditCodISBNLibro.Text,
                //dtFecha_publi = Convert.ToDateTime(txtEditFechaPubLibro.Text),
                dtFecha_publi = DateTime.Now,
                CampoDetalladoPubli = txtEditCampoDetalladoLibro.Text,
                Pares = ddlEditParesLibro.SelectedValue
            };

            if (server2.Update("INVGCCPUBLICACION", libro, $"strId_publi = '{codigo.Text}'"))
            {
                Msg("Registro Actualizado con éxito", "SS", "SISTEMA INTEGRADO DE GESTIÓN");
                codigo.Text = "Registro Actualizado con éxito";
                pnlGrillaLibro.Visible = true;
                mostrarRegistrosGrillaLibro();
                gvwListadoLibroPub.Visible = true;
                btnMostrarOpcionesADD.Visible = true;
                pnlLibroEdit.Visible = false;

                LimpiarCamposLibroEdit();

            }
            else
            {
                codigo.Text = "Error al actualizar";
                Msg("Error al actualizar", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
            }
        }

        protected void btnBroomEditLibro_Click(object sender, EventArgs e)
        {
            LimpiarCamposLibroEdit();
        }

        protected void btnXEditLibro_Click(object sender, EventArgs e)
        {
            LimpiarCamposLibroEdit();
            pnlLibroEdit.Visible = false;
           
            pnlGrillaLibro.Visible = true;
            gvwListadoLibroPub.Visible = true;
            mostrarRegistrosGrillaLibro();
            btnMostrarOpcionesADD.Visible = true;
        }

        private void LimpiarCamposLibroEdit()
        {
            txtEditCodIesLibro.Text = string.Empty;
            txtEditCodPubliLibro.Text = string.Empty;
            txtEditTituloLibro.Text = string.Empty;
            txtEditCodISBNLibro.Text = string.Empty;
            txtEditFechaPubLibro.Text = string.Empty;
            txtEditCampoDetalladoLibro.Text = string.Empty;
            ddlEditParesLibro.SelectedIndex = 0;
          
        }

        protected void btnUpdateCapLibro_Click(object sender, EventArgs e)
        {
            var server = ConnectionSqlServer.Instance;

            // Obtener el valor de CodigoISSNNPubli (strCodigoissnn_publi) del registro actual
            string nuevoCodigo = txtEditCapLibroCodISBN.Text;

            // Obtener el código del registro actual antes de actualizar
            string codigoActual = codigo.Text;

            string connectionString = cadena;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                // Verificar si el nuevo valor de strCodigoissnn_publi ya existe en la tabla para otro registro distinto al que se está actualizando
                string query = "SELECT COUNT(*) FROM INVGCCPUBLICACION WHERE strCodigoissnn_publi = @nuevoCodigo AND strId_publi != @codigoActual";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@nuevoCodigo", nuevoCodigo);
                    command.Parameters.AddWithValue("@codigoActual", codigoActual);
                    int count = (int)command.ExecuteScalar();

                    if (count > 0)
                    {
                        // Mostrar mensaje de error usando toastr
                        Msg("El código ISSN ya está en uso en otro registro. No se puede actualizar.", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                        return;
                    }
                }
            }

            InvgccPublicacion capituloLibro = new InvgccPublicacion
            {

                IdCodIes = txtEditCapLibroCodIes.Text,
                CodigoPubliPubli = txtEditCapLibroCodPubli.Text,
                TituloPubli = txtEditCapLibroTituloLibro.Text,
                CodigoISSNNPubli = txtEditCapLibroCodISBN.Text,
                //dtFecha_publi = Convert.ToDateTime(txtEditCapLibroFechaPub.Text),
                dtFecha_publi = DateTime.Now,
                CampoDetalladoPubli = txtEditCapLibroCampoDetallado.Text,
                strPaginasclib_publi = txtEditCapLibroPags.Text,
                strTituloclib_publi = txtEditCapLibroTituloCap.Text,
                strEditorcompiladorclib_publi = txtEditCapLibroEditorCompilador.Text,




            };

            if (server.Update("INVGCCPUBLICACION", capituloLibro, $"strId_publi = '{codigo.Text}'"))
            {
                Msg("Registro Actualizado con éxito", "SS", "SISTEMA INTEGRADO DE GESTIÓN");
                codigo.Text = "Registro Actualizado con éxito";
                pnlGrillaCapLibro.Visible = true;
                mostrarRegistrosGrillaCapLibro();
                gvwGrillaCapLibro.Visible = true;
                btnMostrarOpcionesADD.Visible = true;
                pnlEditCapLibro.Visible = false;

                LimpiarCamposEdicionCapituloLibro();
            }
            else
            {
                codigo.Text = "Error al actualizar";
                Msg("Error al actualizar", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                return;
            }

        }



        protected void btnBorrarCapLibro_Click1(object sender, EventArgs e)
        {
            LimpiarCamposEdicionCapituloLibro();
        }

        protected void btnCancelarEditCapLibro_Click(object sender, EventArgs e)
        {
            LimpiarCamposEdicionCapituloLibro();

            pnlEditCapLibro.Visible = false;

            pnlGrillaCapLibro.Visible = true;
            gvwGrillaCapLibro.Visible = true;
            mostrarRegistrosGrillaCapLibro();
            btnMostrarOpcionesADD.Visible = true;
        }

        protected void LimpiarCamposEdicionCapituloLibro()
        {
            txtEditCapLibroCodIes.Text = string.Empty;
            txtEditCapLibroCodPubli.Text = string.Empty;
            txtEditCapLibroTituloCap.Text = string.Empty;
            txtEditCapLibroTituloLibro.Text = string.Empty;
            txtEditCapLibroCodISBN.Text = string.Empty;
            txtEditCapLibroFechaPub.Text = string.Empty;
            txtEditCapLibroCampoDetallado.Text = string.Empty;
           
        }

        protected void btnEditRevista_Click(object sender, EventArgs e)
        {
            var server = ConnectionSqlServer.Instance;

            // Obtener el valor de CodigoISSNNPubli (strCodigoissnn_publi) del registro actual
            string nuevoCodigo = txtCodISSNEditRevista.Text;

            // Obtener el código del registro actual antes de actualizar
            string codigoActual = codigo.Text;

            string connectionString = cadena;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                // Verificar si el nuevo valor de strCodigoissnn_publi ya existe en la tabla para otro registro distinto al que se está actualizando
                string query = "SELECT COUNT(*) FROM INVGCCPUBLICACION WHERE strCodigoissnn_publi = @nuevoCodigo AND strId_publi != @codigoActual";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@nuevoCodigo", nuevoCodigo);
                    command.Parameters.AddWithValue("@codigoActual", codigoActual);
                    int count = (int)command.ExecuteScalar();

                    if (count > 0)
                    {
                        // Mostrar mensaje de error usando toastr
                        Msg("El código ISSN ya está en uso en otro registro. No se puede actualizar.", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                        return;
                    }
                }
            }
            InvgccPublicacion revista = new InvgccPublicacion
            {
                
                
               
                strPaginasclib_publi = txtEditCapLibroPags.Text,
              
                strRegImp_publi = dllRIEditRevista.SelectedValue,
                TipoArticuloPubli = ddlTipoPubEditRevista.SelectedValue,
                EstadoPubli = ddlEstadoEditRevista.SelectedValue,
               
                BddIndeaxadaPubli = ddlBddEditRevista.SelectedValue,

                strAnio_publi = ddlAnioRevistaEdit.SelectedValue,
                IdCodIes = txtCodIesEditRevista.Text,
                CodigoPubliPubli = txtCodPubliEditRevista.Text,
                TituloPubli = txtTituloPubliEditRevista.Text,
                CodigoISSNNPubli = txtCodISSNEditRevista.Text,
                //dtFecha_publi = Convert.ToDateTime(txtFechaPubEditRevista.Text),
                dtFecha_publi = DateTime.Now,
                CampoDetalladoPubli = txtCampoDetEditRevista.Text,
                strTituloclib_publi = txtNombreEditRevista.Text,
                strNumr_publi = txtNumeroRevistaEditRevista.Text,
                strEditorcompiladorclib_publi = txtLinkPubliEditRevista.Text,
               
                SjrPubli = txtSjrEditRevista.Text,
                strnombrerevis_publi = txtNombreAddRevista.Text,
                LinkRevistaPubli = txtLinkRevistaAddRevista.Text,
                LinkPubli = txtLinkPubliAddRevista.Text,
            };

            if (server.Update("INVGCCPUBLICACION", revista, $"strId_publi = '{codigo.Text}'"))
            {
                Msg("Registro actualizado con éxito", "SS", "SISTEMA INTEGRADO DE GESTIÓN");
                pnlGrillaRevistas.Visible = true;
                mostrarRegistrosGrillaRevista();
                gvwRevistas.Visible = true;
                btnMostrarOpcionesADD.Visible = true;
                pnlEditRevistas.Visible = false;

                LimpiarCamposRevistaEdit();
            }
            else
            {
                Msg("Error al actualizar el registro", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                return;
            }
        }

        protected void btnLimpiarEditRevista_Click(object sender, EventArgs e)
        {
            LimpiarCamposRevistaEdit();
        }

        protected void btnCancelarEditRevista_Click(object sender, EventArgs e)
        {
            LimpiarCamposRevistaEdit();

            pnlEditRevistas.Visible = false;

            pnlGrillaRevistas.Visible = true;
            gvwRevistas.Visible = true;
            mostrarRegistrosGrillaRevista();
            btnMostrarOpcionesADD.Visible = true;
        }

        protected void btnEditMemoria_Click(object sender, EventArgs e)
        {
            var server = ConnectionSqlServer.Instance;

            // Obtener el valor de CodigoISSNNPubli (strCodigoissnn_publi) del registro actual
            string nuevoCodigo = txtIsbnMemoriaEdit.Text;

            // Obtener el código del registro actual antes de actualizar
            string codigoActual = codigo.Text;

            string connectionString = cadena;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                // Verificar si el nuevo valor de strCodigoissnn_publi ya existe en la tabla para otro registro distinto al que se está actualizando
                string query = "SELECT COUNT(*) FROM INVGCCPUBLICACION WHERE strCodigoissnn_publi = @nuevoCodigo AND strId_publi != @codigoActual";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@nuevoCodigo", nuevoCodigo);
                    command.Parameters.AddWithValue("@codigoActual", codigoActual);
                    int count = (int)command.ExecuteScalar();

                    if (count > 0)
                    {
                        // Mostrar mensaje de error usando toastr
                        Msg("El código ISSN ya está en uso en otro registro. No se puede actualizar.", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                        return;
                    }
                }
            }
            InvgccPublicacion memoria = new InvgccPublicacion
            {
                IdCodIes = txtCodIesMemoriaEdit.Text,
                TipoArticuloPubli = ddlTipoPubEditMemoria.SelectedValue,
                CodigoPubliPubli = txtCodPubliMemoriaEdit.Text,
                NombrePonenciaMPubli = txtNombrePonenciaMemoriaEdit.Text,
                CodigoISSNNPubli = txtIsbnMemoriaEdit.Text,
                strNombreEven_publi = txtNombreEventoMemoriaEdit.Text,
                strEdicionEven_publi = txtEdicionMemoriaEdit.Text,
                OrganizadoresEventoMPubli = txtOrganizadorMemoriaEdit.Text,
                strComiteOrgam_publi = txtComiteMemoriaEdit.Text,
                PaisMPubli = txtPaisMemoriaEdit.Text,
                CiudadMPubli = txtCiudadMemoriaEdit.Text,
                //dtFecha_publi = Convert.ToDateTime(txtFechaPubMemoriaEdit.Text),
                dtFecha_publi = DateTime.Now,
                CampoDetalladoPubli = txtCampoDetalladoMemoriaEdit.Text,
             
            };

            if (server.Update("INVGCCPUBLICACION", memoria, $"strId_publi = '{codigo.Text}'"))
            {
                Msg("Registro actualizado con éxito", "SS", "SISTEMA INTEGRADO DE GESTIÓN");
                pnlGrillaMemoria.Visible = true;
                mostrarRegistrosGrillaMemoria();
                gvwMemoria.Visible = true;
                btnMostrarOpcionesADD.Visible = true;
                btnADDMemoria.Visible = true;
                pnlMemoriaEdit.Visible = false;

                LimpiarEdicionMemoria();
            }
            else
            {
                Msg("Error al actualizar el registro", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                return;
            }
        }

        protected void btnClearMemoriaEdit_Click(object sender, EventArgs e)
        {
            LimpiarEdicionMemoria();
        }

        protected void btnCancelMemoriaEdit_Click(object sender, EventArgs e)
        {
            LimpiarEdicionMemoria();
            pnlMemoriaEdit.Visible = false;
            pnlGrillaMemoria.Visible = true;
            gvwMemoria.Visible = true;
            mostrarRegistrosGrillaMemoria();
            btnMostrarOpcionesADD.Visible = true;
        }

        protected void LimpiarEdicionMemoria()
        {
            txtCodIesMemoriaEdit.Text = string.Empty;
            ddlTipoPubEditMemoria.SelectedIndex = 0;
            txtCodPubliMemoriaEdit.Text = string.Empty;
            txtNombrePonenciaMemoriaEdit.Text = string.Empty;
            txtIsbnMemoriaEdit.Text = string.Empty;
            txtNombreEventoMemoriaEdit.Text = string.Empty;
            txtEdicionMemoriaEdit.Text = string.Empty;
            txtOrganizadorMemoriaEdit.Text = string.Empty;
            txtComiteMemoriaEdit.Text = string.Empty;
            txtPaisMemoriaEdit.Text = string.Empty;
            txtCiudadMemoriaEdit.Text = string.Empty;
            txtFechaPubMemoriaEdit.Text = string.Empty;
            txtCampoDetalladoMemoriaEdit.Text = string.Empty;
          
        }
        protected void LimpiarCamposRevistaEdit()
        {
            ddlAnioRevistaEdit.SelectedIndex = 0;
            txtCodIesEditRevista.Text = string.Empty;
            ddlTipoPubEditRevista.SelectedIndex = 0;
            txtCodPubliEditRevista.Text = string.Empty;
            txtTituloPubliEditRevista.Text = string.Empty;
            ddlBddEditRevista.SelectedIndex = 0;
            dllRIEditRevista.SelectedIndex = 0;
            txtCodISSNEditRevista.Text = string.Empty;
            txtNombreEditRevista.Text = string.Empty;
            txtNumeroRevistaEditRevista.Text = string.Empty;
            txtSjrEditRevista.Text = string.Empty;
            txtFechaPubEditRevista.Text = string.Empty;
            txtCampoDetEditRevista.Text = string.Empty;
            ddlEstadoEditRevista.SelectedIndex = 0;
            txtLinkPubliEditRevista.Text = string.Empty;
            txtLinkRevistaEditRevista.Text = string.Empty;
           
        }

        protected void dllRIEditRevista_SelectedIndexChanged(object sender, EventArgs e)
        {
           
            // Validación para dllRIEditRevista
            if (dllRIEditRevista.SelectedValue == "Alto Impacto")
            {
                txtSjrEditRevista.Enabled = true; // Habilitar el TextBox si la opción seleccionada es "Alto Impacto"
            }
            else
            {
                txtSjrEditRevista.Enabled = false; // Deshabilitar el TextBox si la opción seleccionada no es "Alto Impacto"
            }

        }

        protected void dllRIAddRevista_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Validación para dllRIAddRevista
            if (dllRIAddRevista.SelectedValue == "Alto Impacto")
            {
                txtSjrAddRevista.Enabled = true; // Habilitar el TextBox si la opción seleccionada es "Alto Impacto"
            }
            else
            {
                txtSjrAddRevista.Enabled = false; // Deshabilitar el TextBox si la opción seleccionada no es "Alto Impacto"
            }

        }

        protected void btnParticipantesLibro_Click(object sender, EventArgs e)
        {

            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;
            aux1.Text = row.Cells[0].Text;

            pnlGrillaDetalle.Visible = true;
            pnlGrillaLibro.Visible = false;
            pnlGrillaCapLibro.Visible = false;
            pnlGrillaMemoria.Visible = false;
            pnlGrillaRevistas.Visible = false;
            btnNuevaMemoria.Visible = false;
            btnNuevaRevista.Visible = false;
            btnNuevoCapLibro.Visible = false;
            btnNuevoLibro.Visible = false;
            btnNuevoParticipante.Visible = true;
            mostrarDetalle(aux1.Text);


        }
        void mostrarDetalle(string aux)
        {
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccPublicacionDetalle>($@"SELECT
            pd.id_publicacion_detalle,
            pd.id_publicacion,
            pd.strIdentificacionparti_publi,
            pd.strNombreparti_publi,
            pd.strParticipacion_publi,
            pd.strFiliacion_publi,
            p.strTipo_publi,
            p.strTitulo_publi,
            p.strTipoarti_publi
            
        FROM INVESTIGACION.dbo.INVGCCPUBLICACION_DETALLE pd
        INNER JOIN INVESTIGACION.dbo.INVGCCPUBLICACION p ON pd.id_publicacion = p.strId_publi
                    where pd.id_publicacion = '{aux}' ");
            
            gvwDetalle.DataSource = result1;
            gvwDetalle.DataBind();
        }
        protected void btnEditarDetalle_Click(object sender, EventArgs e)
        {
            pnlEditDetalle.Visible = true;
            pnlGrillaDetalle.Visible = false;
            pnlDetalleAdd.Visible = false;
            btnMostrarOpcionesADD.Visible = false;
            btnNuevoLibro.Visible = false;
            btnNuevoCapLibro.Visible = false;
            btnNuevaRevista.Visible = false;
            btnNuevaMemoria.Visible = false;
            btnNuevoParticipante.Visible = false;


            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;

            codigo.Text = row.Cells[0].Text;

            var server2 = ConnectionSqlServer.Instance;
            var result4 = server2.SelectSql<InvgccPublicacionDetalle>($"SELECT * FROM INVGCCPUBLICACION_DETALLE WHERE id_publicacion_detalle = '{codigo.Text}'");

            if (result4.Count > 0)
            {
                InvgccPublicacionDetalle det_pub = result4[0]; // Suponiendo que el resultado es una lista y solo deseas el primer elemento

                txtIdentificacionEdit.Text = det_pub.IdentificacionParticipacionPublicacion;
                txtNombreParticipanteEdit.Text = det_pub.NombreParticipacionPublicacion;
                // Supongamos que tienes un objeto det_pub que contiene los datos a mostrar en el formulario de edición
                // Puedes verificar si los valores que se van a asignar están presentes en las listas de opciones de los DropDownLists

                // Validar ddlParticipacionEdit
                string participacionSeleccionada = det_pub.ParticipacionPublicacion;
                if (ddlParticipacionEdit.Items.FindByValue(participacionSeleccionada) != null)
                {
                    ddlParticipacionEdit.SelectedValue = participacionSeleccionada;
                }
                else
                {
                    // Si el valor no está presente en las opciones del DropDownList, puedes asignar un valor por defecto o mostrar un mensaje de error
                    ddlParticipacionEdit.SelectedIndex = 0; // Por ejemplo, asignamos "Autor" como valor por defecto
                                                                  // o mostrar un mensaje de error
                                                                  // Msg("Error: Valor de Participación inválido", "error", "Error");
                }

                // Validar ddlFiliacionEdit
                string filiacionSeleccionada = det_pub.FiliacionPublicacion;
                if (ddlFiliacionEdit.Items.FindByValue(filiacionSeleccionada) != null)
                {
                    ddlFiliacionEdit.SelectedValue = filiacionSeleccionada;
                }
                else
                {
                    // Si el valor no está presente en las opciones del DropDownList, puedes asignar un valor por defecto o mostrar un mensaje de error
                    ddlFiliacionEdit.SelectedIndex = 0; // Por ejemplo, asignamos "NO" como valor por defecto
                                                         // o mostrar un mensaje de error
                                                         // Msg("Error: Valor de Filicación inválido", "error", "Error");
                }


            }

        }

        protected void btnBorrarDetalle_Click(object sender, EventArgs e)
        {
            try { 
            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;
                codigo.Text = row.Cells[0].Text;

            var server4 = ConnectionSqlServer.Instance;
            if (server4.Delete("INVGCCPUBLICACION_DETALLE", $"id_publicacion_detalle = '{codigo.Text}'"))
            {
                btnMostrarOpcionesADD.Visible = true;
                pnlGrillaDetalle.Visible = true;
                btnNuevoParticipante.Visible = true;
                pnlDetalleAdd.Visible = false;

                //mostrarActividadesAsociadas(lblIdProyecto.Text);
                codigo.Text = "Eliminación correcta";
                Msg("Eliminación EXitosa", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                codigo.Visible = false;
                    mostrarDetalle(aux1.Text);

                }
            else
            {
                codigo.Text = "Error al eliminar";
                Msg("Error al eliminar", "ee", "GESTIÓN GENERAL DE INVESTIGACIÓN");
                codigo.Visible = false;
                mostrarDetalle(aux1.Text);
            }


        }
            catch (Exception ee)
            {
                Msg("Registro asociado a relaciones....", "ww", "GESTIÓN GENERAL DE INVESTIGACIÓN");
        codigo.Text = "Registro asociado a relaciones....";
                codigo.Visible = false;
                mostrarDetalle(aux1.Text);

            }

}

        protected void btnNuevoParticipante_Click(object sender, EventArgs e)
        {
            pnlGrillaDetalle.Visible = false;
            pnlDetalleAdd.Visible = true;
            btnMostrarOpcionesADD.Visible = false;
            btnNuevoLibro.Visible = false;
            btnNuevoCapLibro.Visible = false;
            btnNuevaRevista.Visible = false;
            btnNuevaMemoria.Visible = false;
            btnNuevoParticipante.Visible = false;
        }

        protected void lbtADDParticipantes_Click(object sender, EventArgs e)
        {
            var server1 = ConnectionSqlServer.Instance;
            string connectionString = cadena;
            string nuevoId = string.Empty;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT MAX(CAST(SUBSTRING(id_publicacion_detalle, 3, LEN(id_publicacion_detalle)) AS INT)) FROM INVGCCPUBLICACION_DETALLE WHERE id_publicacion_detalle LIKE 'PD%'";
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                object result = command.ExecuteScalar();
                int ultimoNumero = 0;

                if (result != null && result != DBNull.Value && int.TryParse(result.ToString(), out ultimoNumero))
                {
                    int nuevoNumero = ultimoNumero + 1;
                    nuevoId = "PD" + nuevoNumero.ToString("D2");
                }
                else
                {
                    nuevoId = "PD01"; // Si no hay registros con el prefijo "PD", empezamos con "PD01"
                }
                if (ddlParticipanteDetalleAdd.SelectedValue == "Autor")
                {
                    string queryExistsAutor = $"SELECT COUNT(*) FROM [INVESTIGACION].[dbo].[INVGCCPUBLICACION_DETALLE] WHERE id_publicacion = '{aux1.Text}' AND strParticipacion_publi = 'Autor'";
                    SqlCommand commandExistsAutor = new SqlCommand(queryExistsAutor, connection);
                    int existingCountAutor = (int)commandExistsAutor.ExecuteScalar();

                    if (existingCountAutor > 0)
                    {
                        // Ya existe un autor con la misma identificación en este registro
                        Msg("Ya existe un autor asociado con este registro.", "ee", "error");
                        return; // Salir temprano de la función
                    }
                }
                else
                {

                    InvgccPublicacionDetalle publi = new InvgccPublicacionDetalle
                    {
                        IdPublicacion_Detalle = nuevoId,
                        IdPublicacion = aux1.Text,
                        IdentificacionParticipacionPublicacion = txtIdentificacionDetalleAdd.Text,
                        NombreParticipacionPublicacion = txtNombreParticipanteDetalleAdd.Text,
                        ParticipacionPublicacion = ddlParticipanteDetalleAdd.SelectedValue,
                        FiliacionPublicacion = ddlFiliacionDetalleAdd.SelectedValue,
                    };

                    server1.Insert("INVGCCPUBLICACION_DETALLE", publi);

                    Msg("Registro exitoso...", "ss", "GESTIÓN GENERAL DE INVESTIGACIÓN");

                    txtIdentificacionDetalleAdd.Text = string.Empty;
                    txtNombreParticipanteDetalleAdd.Text = string.Empty;
                    ddlParticipanteDetalleAdd.SelectedIndex = 0; // Si es un DropDownList, restablecer a la opción predeterminada.
                    ddlFiliacionDetalleAdd.SelectedIndex = 0; // Si es un DropDownList, restablecer a la opción predeterminada.

                    btnMostrarOpcionesADD.Visible = true;
                    pnlGrillaDetalle.Visible = true;
                    mostrarDetalle(aux1.Text);
                    btnNuevoParticipante.Visible = true;
                    pnlDetalleAdd.Visible = false;
                }
            }
        }

        protected void lbtCancellAddParticipantes_Click(object sender, EventArgs e)
        {
            btnMostrarOpcionesADD.Visible = true;
            pnlGrillaDetalle.Visible = true;
            btnNuevoParticipante.Visible = true;
            pnlDetalleAdd.Visible = false;
            mostrarDetalle(aux1.Text);
            txtIdentificacionDetalleAdd.Text = string.Empty;
            txtNombreParticipanteDetalleAdd.Text = string.Empty;
            ddlParticipanteDetalleAdd.SelectedIndex = 0; // Si es un DropDownList, restablecer a la opción predeterminada.
            ddlFiliacionDetalleAdd.SelectedIndex = 0; // Si es un DropDownList, restablecer a la opción predeterminada.

        }

        protected void btnCancellEdirDetalle_Click(object sender, EventArgs e)
        {
            btnMostrarOpcionesADD.Visible = true;
            pnlEditDetalle.Visible = false;
            pnlGrillaDetalle.Visible = true;
            btnNuevoParticipante.Visible = true;
            pnlDetalleAdd.Visible = false;
            mostrarDetalle(aux1.Text);
        }

        protected void lbtnEditDetalle_Click(object sender, EventArgs e)
        {
            try
            {

                var server = ConnectionSqlServer.Instance;

                var server1 = ConnectionSqlServer.Instance;
                string connectionString = cadena;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // ... Código para obtener los datos del participante que se está editando ...
                    if (ddlParticipacionEdit.SelectedValue == "Autor")
                    {
                        // Verificar si existe un autor asociado al registro
                        string queryExistsAutor = $"SELECT COUNT(*) FROM [INVESTIGACION].[dbo].[INVGCCPUBLICACION_DETALLE] WHERE id_publicacion = '{aux1.Text}' AND strParticipacion_publi = 'Autor'";
                        SqlCommand commandExistsAutor = new SqlCommand(queryExistsAutor, connection);
                        int existingCountAutor = (int)commandExistsAutor.ExecuteScalar();

                        if (existingCountAutor > 0)
                        {
                            // Ya existe un autor en el registro, no se permite cambiar a "Autor"
                            Msg("Ya existe un autor asociado con este registro.", "ee", "error");
                            return;
                        }
                    }
                    InvgccPublicacionDetalle detalle = new InvgccPublicacionDetalle
                    {
                        IdentificacionParticipacionPublicacion = txtIdentificacionEdit.Text,
                        NombreParticipacionPublicacion = txtNombreParticipanteEdit.Text,
                        ParticipacionPublicacion = ddlParticipacionEdit.SelectedValue,
                        FiliacionPublicacion = ddlFiliacionEdit.SelectedValue
                    };
                    if (server.Update("INVGCCPUBLICACION_DETALLE", detalle, $"id_publicacion_detalle = '{codigo.Text}'"))
                    {
                        Msg("Registro actualizado con éxito", "SS", "SISTEMA INTEGRADO DE GESTIÓN");
                        btnMostrarOpcionesADD.Visible = true;
                        pnlEditDetalle.Visible = false;
                        pnlGrillaDetalle.Visible = true;
                        btnNuevoParticipante.Visible = true;
                        pnlDetalleAdd.Visible = false;
                        mostrarDetalle(aux1.Text);
                    }
                    else
                    {
                        Msg("Error al actualizar el registro", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
                        return;
                    }
                }
            }
            catch (Exception ex)
            {
                Msg("Error al actualizar el registro", "ee", "SISTEMA INTEGRADO DE GESTIÓN");
            }
        }
    }
}