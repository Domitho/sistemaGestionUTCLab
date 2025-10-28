using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.IO;
using utc.Models;
using Newtonsoft.Json;
using utc.Settigns;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace utc
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] == null)
                {

                    Response.Redirect("login.aspx");
                  
            }

            docentePorCategorizacion();
                totalPublicacionesTipo();
                ProyectosPorEstado();
                obtenerCentros();
                obtenerConvocatorias();
                obtenerGrupoInvestigacion();
                obtenerIntegrantes();
            }
        }
        public string cadena = @"server=DESKTOP-A925LIU\SQLEXPRESS2019;database=INVESTIGACION;INTEGRATED SECURITY=true";
        void docentePorCategorizacion()
        {
            // Categorías a incluir en la consulta
            string[] categorias = { "PRINCIPAL 1", "PRINCIPAL 2", "PRINCIPAL 3", "PRINCIPAL 4", "AGREGADO 1", "AGREGADO 2", "AGREGADO 3", "AUXILIAR 1", "AUXILIAR 2", "AUXILIAR 3" };

            // Construir la condición de consulta
            string condicion = string.Join("', '", categorias);

            // Construir la consulta SQL
            string consulta = $"SELECT * FROM [INVESTIGACION].[dbo].[INVGCCCATEGORIA] WHERE strCategorizacion IN ('{condicion}')";

            // Obtén los datos para el gráfico desde tu fuente de datos (por ejemplo, una base de datos)
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccCategoria>(consulta);
            int[] data = new int[categorias.Length];

            // Obtén el recuento de registros para cada categoría
            for (int i = 0; i < categorias.Length; i++)
            {
                string categoria = categorias[i];
                int count = result1.Count(publicacion => publicacion.strCategorizacion == categoria);
                data[i] = count;
            }

            // Configura los colores alternados para el gráfico
            string color1 = "'#337AB7'";
            string color2 = "'#F0AD4E'";
            string backgroundColors = string.Join(",", Enumerable.Range(0, data.Length).Select(i => i % 2 == 0 ? color1 : color2));
            string borderColor = color1;

            // Configura el gráfico
            string chartScript = $@"
            var ctx = document.getElementById('myChart').getContext('2d');
            var myChart = new Chart(ctx, {{
                type: 'bar',
                data: {{
                    labels: ['Principal 1','Principal 2', 'Principal 3', 'Principal 4', 'Agregado 1', 'Agregado 2', 'Agregado 3', 'Auxiliar 1', 'Auxiliar 2', 'Auxiliar 3'],
                    datasets: [{{
                        label: 'Número de docentes por Categoría',
                        data: [{string.Join(",", data)}],
                        backgroundColor: [{backgroundColors}],
                        borderColor: [{borderColor}],
                        borderWidth: 1
                    }}]
                }},
                options: {{
                    scales: {{
                        y: {{
                            beginAtZero: true
                        }}
                    }}
                }}
            }});
        ";

            // Registra el código del gráfico en la página
            Page.ClientScript.RegisterStartupScript(this.GetType(), "chartScript", chartScript, true);

        }
        void totalPublicacionesTipo()
        {
            string[] categorias = { "LIBRO", "CAPITULO DE LIBRO", "REVISTA", "MEMORIA" };

            // Construir la condición de consulta
            string condicion = string.Join("', '", categorias);

            // Construir la consulta SQL
            string consulta = $"SELECT * FROM [INVESTIGACION].[dbo].[INVGCCPUBLICACION] WHERE strTipo_publi IN ('{condicion}')";

            // Obtén los datos para el gráfico desde tu fuente de datos (por ejemplo, una base de datos)
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccPublicacion>(consulta);
            int[] data = new int[categorias.Length];

            // Obtén el recuento de registros para cada categoría
            for (int i = 0; i < categorias.Length; i++)
            {
                string categoria = categorias[i];
                int count = result1.Count(publicacion => publicacion.TipoPubli == categoria);
                data[i] = count;
            }

            // Define los colores de fondo para cada segmento
            string[] colores = { "#337AB7", "#F0AD4E", "#47A5D6", "#FFC87A" };

            // Construir el arreglo de colores para el gráfico
            string coloresArray = string.Join(", ", colores.Select(c => $"'{c}'"));

            // Construir el arreglo de etiquetas para el gráfico
            string etiquetasArray = string.Join(", ", categorias.Select(c => $"'{c}'"));

            // Construir el arreglo de datos para el gráfico
            string datosArray = string.Join(", ", data);

            // Registra el script al cargar la página por primera vez
            string chartScript1 = $@"
        var ctx = document.getElementById('doughnutChart').getContext('2d');
        var data = {{
            labels: [{etiquetasArray}],
            datasets: [{{
                data: [{datosArray}],
                backgroundColor: [{coloresArray}]
            }}]
        }};
        var doughnutChart = new Chart(ctx, {{
            type: 'doughnut',
            data: data,
            options: {{
                responsive: true,
                maintainAspectRatio: false,
                legend: {{
                    position: 'bottom'
                }}
            }}
        }});
    ";
        
            // Registra el script en la página
            Page.ClientScript.RegisterStartupScript(this.GetType(), "chartScript1", chartScript1, true);
        }

        void ProyectosPorEstado()
        {
            string[] categorias = { "APROBADO", "NO APROBADO", "PENDIENTE", "CERRADO" };

            // Construir la condición de consulta
            string condicion = string.Join("', '", categorias);

            // Construir la consulta SQL
            string consulta = $"SELECT * FROM [INVESTIGACION].[dbo].[INVGCCPROYECTO] WHERE strEstado_pro IN ('{condicion}')";

            // Obtén los datos para el gráfico desde tu fuente de datos (por ejemplo, una base de datos)
            var server2 = ConnectionSqlServer.Instance;
            var result1 = server2.SelectSql<InvgccInsPro>(consulta);
            int[] data = new int[categorias.Length];

            // Obtén el recuento de registros para cada categoría
            for (int i = 0; i < categorias.Length; i++)
            {
                string categoria = categorias[i];
                int count = result1.Count(publicacion => publicacion.strEstado_pro == categoria);
                data[i] = count;
            }

            // Define los colores de fondo para cada segmento
            string[] colores = { "#337AB7", "#F0AD4E", "#47A5D6", "#FFC87A" };

            // Construir el arreglo de colores para el gráfico
            string coloresArray = string.Join(", ", colores.Select(c => $"'{c}'"));

            // Construir el arreglo de etiquetas para el gráfico
            string etiquetasArray = string.Join(", ", categorias.Select(c => $"'{c}'"));

            // Construir el arreglo de datos para el gráfico
            string datosArray = string.Join(", ", data);

            // Registra el script al cargar la página por primera vez
            string chartScript2 = $@"
        var ctx2 = document.getElementById('myChart3').getContext('2d');
        var data = {{
            labels: [{etiquetasArray}],
            datasets: [{{
                data: [{datosArray}],
                backgroundColor: [{coloresArray}]
            }}]
        }};
        var myChart3 = new Chart(ctx2, {{
            type: 'doughnut',
            data: data,
            options: {{
                responsive: true,
                maintainAspectRatio: false,
                legend: {{
                    position: 'bottom'
                }}
            }}
        }});
    ";

            // Registra el script en la página
            Page.ClientScript.RegisterStartupScript(this.GetType(), "chartScript2", chartScript2, true);
        }
        void obtenerCentros()
        {
            var server1 = ConnectionSqlServer.Instance;

            string connectionString = cadena;
            string query = $"SELECT COUNT(*) FROM [INVESTIGACION].[dbo].[INVGCCCENTRO_INESTIGACION]";
            int count = 0;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                count = (int)command.ExecuteScalar();
            }

        

            lblCentros.Text = count.ToString();
        }
        void obtenerConvocatorias()
        {
            var server1 = ConnectionSqlServer.Instance;

            string connectionString = cadena;
            string query = $"SELECT COUNT(*) FROM [INVESTIGACION].[dbo].[INVGCCCONVOCATORI]";
            int count = 0;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                count = (int)command.ExecuteScalar();
            }
          
            lblConvocatorias.Text = count.ToString(); 

        }
        void obtenerGrupoInvestigacion()
        {
            var server1 = ConnectionSqlServer.Instance;

            string connectionString = cadena;
            string query = $"SELECT COUNT(*) FROM [INVESTIGACION].[dbo].[INVGCCGRUPO_INVESTIGACION]";
            int count = 0;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                count = (int)command.ExecuteScalar();
            }


         

            lblGruInv.Text = count.ToString(); 

        }
        void obtenerIntegrantes()
        {
            var server1 = ConnectionSqlServer.Instance;

            string connectionString = cadena;
            string query = $"SELECT COUNT(*) FROM [INVESTIGACION].[dbo].[INVGCCINTEGRANTES]";
            int count = 0;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                count = (int)command.ExecuteScalar();
            }

            lblIntegrantes.Text = count.ToString();
        }
    }

    
}