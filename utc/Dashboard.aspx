<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="utc.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-chart-3d@2.0.0/dist/chartjs-chart-3d.min.js"></script>
     <style>
        .border-dash {
            background: #337AB7;
            border-radius: 10px;
            border: 2px solid #004289;
            color: white;
            text-align: center;
        }

        .titulo-dash {
            font-size: 20px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .valor {
            color: #F0AD4E;
            font-size: 35px;
            font-weight: bold;
        }

        .subtitulo-dash {
            font-weight: bold;
            text-transform: uppercase;
            font-style: oblique;
            font-size: 15px;
        }
    </style>

    
    <script type="text/javascript">
    window.addEventListener('load', function () {
       $(".loading").css("display","none");
    })
    </script>
    
    <link href="prueba/Styles/datatables/datatables.css" rel="stylesheet" />

    <script src="prueba/Scripts/datatables/datatables.js"></script>
    <script src="prueba/Scripts/datatables/datatables.min.js"></script>

    <!-- EXPORTAR PDF EXCEL -->
    <script src="prueba/Scripts/datatables_imprimir/pdfmake.min.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/print.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/vfs_fonts.js"></script>
    <script src="prueba/Scripts/propias/datatablesMetodo.js"></script>
    <%-- font awesome--%>
        
   <%-- añadiendo toastr--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/js/toastr.js" type="text/javascript"></script>
    



    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />


    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>



    <%-- estilos propios para boton redondo--%>
    <link href="prueba/Styles/propio/propio.css" rel="stylesheet" />

    <script type="text/javascript">//para mostrar splash screen
        window.addEventListener('load', function () {
            $(".loading").css("display", "none");
        })
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <div class="loading">Loading&#8230;</div>
    <div class="row">
                <div class="col-md-12 text-center">
                    
                    <div class="col-md-12 text-center">
                        <h3 style="color: #312783; font-weight: bold;"><i class="fa fa-tachometer"></i>DASHBOARD
                        </h3>
                    </div>
                    
                </div>
                
            </div>
    <div class="row justify-content-between">


            <div class="col-8col-md-5 col-lg-3 mb-3">
                <div class="card border-dash">

                    <div class="card-body">
                        <div class="card-title  justify-content-between mb-0">
                            <h3 class="h5 titulo-dash">CENTROS DE INVESTIGACIÓN</h3>
                            <!--<button class="btn" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-info menu-tareas-industrial" style="font-weight: lighter; font-size: 1.3rem;"></i></button>-->
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item industrial">Detalle</a>
                                <!-- <a class="dropdown-item industrial">Another action</a>
							<a class="dropdown-item industrial">Something else here</a> -->
                            </div>
                        </div>

                        <div class="card-text text-center color-2 industrial">
                            <p class="display-2 valor mb-0">
                                <asp:Label ID="lblCentros" runat="server" Text="Label" CssClass="valor"></asp:Label>
                            </p>
                            <p class="font-weight-bolder mb-0 subtitulo-dash">
                                CENTROS			
                            </p>
                        </div>
                    </div>

                </div>
            </div>
            <div class="col-8col-md-5 col-lg-3 mb-3">
                <div class="card border-dash">
                    <div class="card-body">
                        <div class="card-title d-flex justify-content-between mb-0">
                            <h3 class="h5 titulo-dash"> TOTAL DE CONVOCATORIAS </h3>
                            <!--<button class="btn" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-info menu-tareas-industrial" style="font-weight: lighter; font-size: 1.3rem;"></i></button>-->
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item industrial">Detalle</a>
                                <!-- <a class="dropdown-item industrial">Another action</a>
            <a class="dropdown-item industrial">Something else here</a> -->
                            </div>
                        </div>
                        <div class="card-text text-center color-2 industrial">
                            <p class="display-2 valor mb-0">

                                <asp:Label ID="lblConvocatorias" runat="server" Text="" CssClass="valor"></asp:Label>
                            </p>
                            <p class="font-weight-bolder mb-0 subtitulo-dash">
                                CONVOCATORIAS					
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-8col-md-5 col-lg-3 mb-3">
                <div class="card border-dash">
                    <div class="card-body">
                        <div class="card-title d-flex justify-content-between mb-0">
                            <h3 class="h5 text-capitalize titulo-dash">GRUPOS DE INVESTIGACIÓN					</h3>
                            <!--<button class="btn" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-info menu-tareas-industrial" style="font-weight: lighter; font-size: 1.3rem;"></i></button>-->
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item industrial">Detalle</a>
                                <!-- <a class="dropdown-item industrial">Another action</a>
          <a class="dropdown-item industrial">Something else here</a> -->
                            </div>
                        </div>
                        <div class="card-text text-center color-2 industrial">
                            <p class="display-2 valor mb-0">
                                <asp:Label ID="lblGruInv" runat="server" Text="" CssClass="valor"></asp:Label>
                            </p>
                            <p class="font-weight-bolder mb-0 subtitulo-dash">
                                GRUPOS					
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-8col-md-5 col-lg-3 mb-3">
                <div class="card border-dash">
                    <div class="card-body">
                        <div class="card-title d-flex justify-content-between mb-0">
                            <h3 class="h5 titulo-dash">TOTAL DE INTEGRANTES					</h3>
                            <!--<button class="btn" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-info menu-tareas-industrial" style="font-weight: lighter; font-size: 1.3rem;"></i></button>-->
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            </div>
                        </div>
                        <div class="card-text text-center color-2 industrial">
                            <p class="display-2 mb-0 valor">
                                <asp:Label ID="lblIntegrantes" runat="server" Text="" CssClass="valor"></asp:Label>
                            </p>
                            <p class="font-weight-bolder mb-0 subtitulo-dash">
                                INTEGRANTES					
                            </p>
                        </div>
                    </div>
                </div>
              </div>
                </div>
     
     <hr style="background-color:#F0AD4E; height:5px;"  />
<div class="col-md-12 text-center">

<asp:label runat="server" CssClass="text-center" Font-Bold="true">Número de docentes por Categoría</asp:label>
    </div> 
    <div class="row" style="background-color:aliceblue;" >
        <div class="col-md-12 text-center" >
                   
                </div>
    <div class="col-md-1"></div>
        <div class="col-md-10">
   <canvas id="myChart" width="400" height="200"></canvas>
            </div>
    <div class="col-md-1"></div>

   
    </div>
     
  
     <hr style="background-color:#F0AD4E; height:5px;"  />

    <div class="col-md-6 text-center">
          <asp:label runat="server" CssClass="text-center" Font-Bold="true">Total de Publicaciones por Tipo</asp:label>
         </div>
    <div class="col-md-6 text-center">
         <asp:label runat="server" CssClass="text-center" Font-Bold="true">Total de Proyectos por Estado</asp:label>
        </div>

       
    <div class="row">
        <div class="col-md-12">
        <div class="col-md-6 text-center" style="background-color: aliceblue; padding-bottom:5px;">
            <canvas id="doughnutChart" width="200" height="300"></canvas>
        </div>
        
        <div class="col-md-6 text-center" style="background-color: aliceblue; padding-bottom:5px; ">
            <canvas id="myChart3" width="200" height="300"></canvas>
        </div>
            </div>
    
</div>



</asp:Content>
