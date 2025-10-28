<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Publicaciones.aspx.cs" Inherits="utc.Publicaciones" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link href="prueba/Styles/datatables/datatables.css" rel="stylesheet" />

    <script src="prueba/Scripts/datatables/datatables.js"></script>
    <script src="prueba/Scripts/datatables/datatables.min.js"></script>

    <!-- EXPORTAR PDF EXCEL -->
    <script src="prueba/Scripts/datatables_imprimir/pdfmake.min.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/print.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/vfs_fonts.js"></script>
    <script src="prueba/Scripts/propias/datatablesMetodo.js"></script>

       <link href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>

    <script>
    $(document).ready(function () {
        $(".chosen-select").chosen();
    });
</script>


    <link href="https://cdn.jsdelivr.net/bootstrap.tagsinput/0.8.0/bootstrap-tagsinput.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/bootstrap.tagsinput/0.8.0/bootstrap-tagsinput.min.js"></script>



    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />


    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
     




    <%-- estilos propios para boton redondo--%>
    <link href="prueba/Styles/propio/propio.css" rel="stylesheet" />

    <script type="text/javascript">//para mostrar splash screen
        window.addEventListener('load', function () {
            $(".loading").css("display", "none");
        });


    </script>
    <style>
        .btn-xl:hover {
            transform: scale(1.8); /* Aumenta el tamaño en un 20% */
            transition: transform 0.3s ease; /* Agrega una transición suave */
        }
    </style>
    <style>
        .modalBackground {
            background-color: rgba(0, 0, 0, 0.5);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }

        .modalPopup {
            background-color: #fff;
            border-radius: 5px;
            padding: 20px;
            max-width: 80%;
            margin: 0 auto;
            position: fixed;
            top: 50%;
            left: 50%;
            right: 50%;
            /*transform: translate(auto);*/
        }
    </style>

    <style type="text/css">
        .radioList label {
            display: inline-block;
            padding-right: 50px;
        }
    </style>




    <%--<script src="https://cdn.ckeditor.com/ckeditor5/35.3.2/classic/ckeditor.js"></script>--%>
    <script src="https://cdn.ckeditor.com/4.18.0/full/ckeditor.js"></script>


    <%-- font awesome--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="loading">Loading&#8230;</div>
    <div class="row">
        <div class="col-md-12 text-center">



            <div class="row">
                <div class="col-md-12 text-center">
                    <div class="col-md-4 text-center">
                        <%--<asp:button Cssclass="btn btn btn-bitbucket text-center" style="border-radius: 100px; width: 214px; height: 52px;"  BackColor="#312783" ForeColor="White" Font-Bold="True" runat="server" Text="UTC"  ID="btnUtc" ClientIDMode="Static" ToolTip="UNIVERSIDAD TÉCNICA DE COTOPAXI..." Font-Size="25px"> </asp:button>--%>
                        <%-- <label class="" style="color: #312783; font-size:25px;">UTC</label>--%>
                    </div>
                    <div class="col-md-4 text-center">
                        <h3 style="color: #312783; font-weight: bold;"><i class="fa fa-book"></i>SISTEMA DE GESTIÓN GENERAL DE INVESTIGACIÓN
                        </h3>
                    </div>
                    <div class="col-md-4 text-center">
                        <asp:LinkButton CssClass="btn btn btn-bitbucket text-center" CausesValidation="false" Style="border-radius: 100px; width: 260px; height: 47px; font-weight: bold;" runat="server" Text="<span><i class='fa fa-chevron-left'></i></span> REGRESAR" BackColor="#312783" ForeColor="White" Font-Bold="True" ID="btnRegresarPub" ToolTip="REGRESAR..." Font-Size="20px" Visible="false" OnClick="btnRegresarPub_Click"> </asp:LinkButton>
                        <asp:Label ID="lblPath" runat="server" Visible="false"></asp:Label>

                    </div>
                </div>
            </div>



            <asp:LinkButton ID="btnMostrarOpcionesADD" runat="server" CausesValidation="false" Text="Mostrar Opciones" OnClick="btnMostrarOpcionesADD_Click"
                CssClass="btn btn-bitbucket" BackColor="#312783" ForeColor="White" Font-Bold="True" Style="border-radius: 100px; width: 260px; height: 47px; font-weight: bold;"></asp:LinkButton>

            <asp:LinkButton ID="btnNuevoLibro" CausesValidation="false" runat="server" Text="Nueva Publicación de Libro" OnClick="btnNuevoLibro_Click" Visible="false"
                CssClass="btn btn-bitbucket" BackColor="#312783" ForeColor="White" Font-Bold="True" Style="border-radius: 100px; width: 260px; height: 47px; font-weight: bold;"></asp:LinkButton>


            <asp:LinkButton ID="btnNuevoCapLibro" CausesValidation="false" runat="server" Text="Nueva Publicación de Capitulo de Libro" OnClick="btnNuevoCapLibro_Click" Visible="false"
                CssClass="btn btn-bitbucket" BackColor="#312783" ForeColor="White" Font-Bold="True" Style="border-radius: 100px; width: 300px; height: 47px; font-weight: bold;"></asp:LinkButton>


            <asp:LinkButton ID="btnNuevaRevista" CausesValidation="false" runat="server" Text="Nueva Publicación de Revistas" OnClick="btnNuevaRevista_Click" Visible="false"
                CssClass="btn btn-bitbucket" BackColor="#312783" ForeColor="White" Font-Bold="True" Style="border-radius: 100px; width: 300px; height: 47px; font-weight: bold;"></asp:LinkButton>

            <asp:LinkButton ID="btnNuevaMemoria" CausesValidation="false" runat="server" Text="Nueva Publicación de Memoria" OnClick="btnNuevaMemoria_Click" Visible="false"
                CssClass="btn btn-bitbucket" BackColor="#312783" ForeColor="White" Font-Bold="True" Style="border-radius: 100px; width: 300px; height: 47px; font-weight: bold;"></asp:LinkButton>

             <asp:LinkButton ID="btnNuevoParticipante" CausesValidation="false" runat="server" Text="Agregar Participante" OnClick="btnNuevoParticipante_Click" Visible="false"
                CssClass="btn btn-bitbucket" BackColor="#312783" ForeColor="White" Font-Bold="True" Style="border-radius: 100px; width: 260px; height: 47px; font-weight: bold;"></asp:LinkButton>



            <asp:Label ID="codigo" runat="server" ForeColor="Red" Visible="false"></asp:Label>
              <asp:Label ID="aux1" runat="server" ForeColor="Red" Visible="false"></asp:Label>
            <br />

            <div class="text-right">
            </div>

        </div>
    </div>

    <asp:Panel runat="server" ID="pnlGrillaLibro" Visible="false">
        <br />
        <br />
        <div class="table table-responsive text-center" style="background-color: #F5F5F5;">
            <asp:GridView runat="server" ID="gvwListadoLibroPub" CssClass="cabeza table table-bordered table-hover table-responsive text-center" ForeColor="#333333" GridLines="Horizontal" HorizontalAlign="Center" AutoGenerateColumns="false" ToolTip="registros...">
                <Columns>


                    <asp:BoundField DataField="strId_publi" HeaderText="COD" ItemStyle-Width="15px" ItemStyle-Wrap="true" ItemStyle-Font-Size="X-Small" ReadOnly="true" Visible="true" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                    <asp:BoundField DataField="IdCodIes" HeaderText="COD IES" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="CodigoPubliPubli" HeaderText="COD PUBLI" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="TipoPubli" HeaderText="TIPO PUBLI" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="TituloPubli" HeaderText="TITULO PUBLI" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="CodigoISSNNPubli" HeaderText="COD ISSN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />

                    <asp:BoundField DataField="dtFecha_publi" HeaderText="FECHA PUBLI" HtmlEncode="false" ItemStyle-CssClass="html" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="CampoDetalladoPubli" HeaderText="CAMPO DET" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <%--<asp:BoundField DataField="Pares" HeaderText="REV PARES" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />--%>
                  <%--  <asp:BoundField DataField="IdentificacionPartiPubli" HeaderText="IDENTIFICACIÓN INT" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="FiliacionPubli" HeaderText="FILIACIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="NombrePartiPubli" HeaderText="NOMBRE INT" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="ParticipacionPubli" HeaderText="PARTICIPACIÓN INT" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />--%>

                    <asp:TemplateField HeaderText="ACCIONES" HeaderStyle-Font-Size="Small">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnParticipantesLibro" OnClick="btnParticipantesLibro_Click" CausesValidation="false" runat="server" CssClass="btn btn-success btn-xs btn-circle" Text="<span class='glyphicon glyphicon-user'></span>" ToolTip="Visualizar Participantes..." Style="color: white;" />
                            <asp:LinkButton ID="btnEditarLibro" CausesValidation="false" runat="server" CssClass="btn btn-warning btn-xs btn-circle" Text="<span class='glyphicon glyphicon-edit'></span>" OnClick="btnEditarLibro_Click" ToolTip="Editar Registro." Style="color: white;" />
                            <asp:LinkButton ID="btnBorrarLibro" CausesValidation="false" runat="server" Text="<span class='glyphicon glyphicon-trash'></span>" CssClass="btn btn-danger btn-xs btn-circle" OnClick="btnBorrarLibro_Click" Style="color: white;" OnClientClick="return confirm('Esta seguro que desea eliminar este registro, esta opción es irreversible?')" ToolTip="Eliminar registro." />
                            <%--ELIMINANDO REGISTRO DE LA BDD --%>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <AlternatingRowStyle BackColor="White" />

                <EditRowStyle BackColor="#004289" />
                <EmptyDataTemplate>
                    SIN REGISTROS
                </EmptyDataTemplate>
                <FooterStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />

                <PagerStyle BackColor="#004289" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />

                <SelectedRowStyle BackColor="Yellow" BorderColor="Black" VerticalAlign="Middle" CssClass="font-weight-bold" />

                <SortedAscendingCellStyle BackColor="#004289" />
                <SortedAscendingHeaderStyle BackColor="#004289" />
                <SortedDescendingCellStyle BackColor="#004289" />
                <SortedDescendingHeaderStyle BackColor="#004289" />
            </asp:GridView>
        </div>
    </asp:Panel>

        <asp:Panel runat="server" ID="pnlGrillaDetalle" Visible="false">
        <br />
        <br />
        <div class="table table-responsive text-center" style="background-color: #F5F5F5;">
            <asp:GridView runat="server" ID="gvwDetalle" CssClass="cabeza table table-bordered table-hover table-responsive text-center" ForeColor="#333333" GridLines="Horizontal" HorizontalAlign="Center" AutoGenerateColumns="false" ToolTip="registros...">
                <Columns>


                    <asp:BoundField DataField="IdPublicacion_Detalle" HeaderText="COD" ItemStyle-Width="15px" ItemStyle-Wrap="true" ItemStyle-Font-Size="X-Small" ReadOnly="true" Visible="true"  /> <%--ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar"--%>
                    <asp:BoundField DataField="IdentificacionParticipacionPublicacion" HeaderText="IDENTIFICACIÓN PARTICIPANTE " ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="NombreParticipacionPublicacion" HeaderText="MOMBRES PARTICIPANTE" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="FiliacionPublicacion" HeaderText="FILIACIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                     <asp:BoundField DataField="ParticipacionPublicacion" HeaderText="PARTICIPACIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    
                    <asp:TemplateField HeaderText="ACCIONES" HeaderStyle-Font-Size="Small">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditarDetalle" CausesValidation="false" runat="server" CssClass="btn btn-warning btn-xs btn-circle" Text="<span class='glyphicon glyphicon-edit'></span>" OnClick="btnEditarDetalle_Click" ToolTip="Editar Registro." Style="color: white;" />
                            <asp:LinkButton ID="btnBorrarDetalle" CausesValidation="false" runat="server" Text="<span class='glyphicon glyphicon-trash'></span>" CssClass="btn btn-danger btn-xs btn-circle" OnClick="btnBorrarDetalle_Click" Style="color: white;" OnClientClick="return confirm('Esta seguro que desea eliminar este registro, esta opción es irreversible?')" ToolTip="Eliminar registro." />
                            <%--ELIMINANDO REGISTRO DE LA BDD --%>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <AlternatingRowStyle BackColor="White" />

                <EditRowStyle BackColor="#004289" />
                <EmptyDataTemplate>
                    SIN REGISTROS
                </EmptyDataTemplate>
                <FooterStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />

                <PagerStyle BackColor="#004289" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />

                <SelectedRowStyle BackColor="Yellow" BorderColor="Black" VerticalAlign="Middle" CssClass="font-weight-bold" />

                <SortedAscendingCellStyle BackColor="#004289" />
                <SortedAscendingHeaderStyle BackColor="#004289" />
                <SortedDescendingCellStyle BackColor="#004289" />
                <SortedDescendingHeaderStyle BackColor="#004289" />
            </asp:GridView>
        </div>
    </asp:Panel>


    <asp:Panel runat="server" ID="pnlGrillaCapLibro" Visible="false">
        <br />
        <br />
        <div class="table table-responsive text-center" style="background-color: #F5F5F5;">
            <asp:GridView runat="server" ID="gvwGrillaCapLibro" CssClass="cabeza table table-bordered table-hover table-responsive text-center" ForeColor="#333333" GridLines="Horizontal" HorizontalAlign="Center" AutoGenerateColumns="false" ToolTip="registros...">
                <Columns>


                    <asp:BoundField DataField="strId_publi" HeaderText="COD" ItemStyle-Width="15px" ItemStyle-Wrap="true" ItemStyle-Font-Size="X-Small" ReadOnly="true" Visible="true" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                    <asp:BoundField DataField="IdCodIes" HeaderText="COD IES" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="CodigoPubliPubli" HeaderText="COD PUBLI" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="TipoPubli" HeaderText="TIPO PUBLI" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="strTituloclib_publi" HeaderText="TITULO CAPITULO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="TituloPubli" HeaderText="TITULO PUBLI" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="CodigoISSNNPubli" HeaderText="COD ISSN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="strEditorcompiladorclib_publi" HeaderText="EDITOR COMP" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="strPaginasclib_publi" HeaderText="PÁGINAS" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="dtFecha_publi" HeaderText="FECHA PUBLI" HtmlEncode="false" ItemStyle-CssClass="html" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="CampoDetalladoPubli" HeaderText="CAMPO DET" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="Pares" HeaderText="REV PARES" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                   <%-- <asp:BoundField DataField="IdentificacionPartiPubli" HeaderText="IDENTIFICACIÓN INT" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="FiliacionPubli" HeaderText="FILIACIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="NombrePartiPubli" HeaderText="NOMBRE INT" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="ParticipacionPubli" HeaderText="PARTICIPACIÓN INT" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />--%>

                    <asp:TemplateField HeaderText="ACCIONES" HeaderStyle-Font-Size="Small">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnParticipantesLibro1" OnClick="btnParticipantesLibro_Click" CausesValidation="false" runat="server" CssClass="btn btn-success btn-xs btn-circle" Text="<span class='glyphicon glyphicon-user'></span>" ToolTip="Visualizar Participantes..." Style="color: white;" />
                            <asp:LinkButton ID="btnEditarCapLibro" CausesValidation="false" runat="server" CssClass="btn btn-warning btn-xs btn-circle" Text="<span class='glyphicon glyphicon-edit'></span>" OnClick="btnEditarCapLibro_Click" ToolTip="Editar Registro." Style="color: white;" />
                            <asp:LinkButton ID="btnBorrarCapLibro" CausesValidation="false" runat="server" Text="<span class='glyphicon glyphicon-trash'></span>" CssClass="btn btn-danger btn-xs btn-circle" OnClick="btnBorrarCapLibro_Click" Style="color: white;" OnClientClick="return confirm('Esta seguro que desea eliminar este registro, esta opción es irreversible?')" ToolTip="Eliminar registro." />
                            <%--ELIMINANDO REGISTRO DE LA BDD --%>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <AlternatingRowStyle BackColor="White" />

                <EditRowStyle BackColor="#004289" />
                <EmptyDataTemplate>
                    SIN REGISTROS
                </EmptyDataTemplate>
                <FooterStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />

                <PagerStyle BackColor="#004289" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />

                <SelectedRowStyle BackColor="Yellow" BorderColor="Black" VerticalAlign="Middle" CssClass="font-weight-bold" />

                <SortedAscendingCellStyle BackColor="#004289" />
                <SortedAscendingHeaderStyle BackColor="#004289" />
                <SortedDescendingCellStyle BackColor="#004289" />
                <SortedDescendingHeaderStyle BackColor="#004289" />
            </asp:GridView>
        </div>
    </asp:Panel>


    <asp:Panel runat="server" ID="pnlGrillaRevistas" Visible="false">
        <br />
        <br />
        <div class="table table-responsive text-center" style="background-color: #F5F5F5;">
            <asp:GridView runat="server" ID="gvwRevistas" CssClass="cabeza table table-bordered table-hover table-responsive text-center" ForeColor="#333333" GridLines="Horizontal" HorizontalAlign="Center" AutoGenerateColumns="false" ToolTip="registros...">
                <Columns>
                    <asp:BoundField DataField="strId_publi" HeaderText="COD" ItemStyle-Width="15px" ItemStyle-Wrap="true" ItemStyle-Font-Size="X-Small" ReadOnly="true" Visible="true" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                    <asp:BoundField DataField="strAnio_publi" HeaderText="AÑO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="IdCodIes" HeaderText="COD IES" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="CodigoPubliPubli" HeaderText="COD PUBLICACIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="TipoPubli" HeaderText="TIPO PUBLICACIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="TipoArticuloPubli" HeaderText="TIPO ARTICULO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="TituloPubli" HeaderText="TITULO PUBLICACIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="BddIndeaxadaPubli" HeaderText="BASE DE DATOS INDEXADA" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="strRegImp_publi" HeaderText="REGIONAL / IMPACTO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="CodigoISSNNPubli" HeaderText="COD ISSN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="strnombrerevis_publi" HeaderText="NOMBRE REVISTA" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="strNumr_publi" HeaderText="NUMERO REVISTA" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="SjrPubli" HeaderText="SJR" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="dtFecha_publi" HeaderText="FECHA PUBLICACIÓN" HtmlEncode="false" ItemStyle-CssClass="html" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="CampoDetalladoPubli" HeaderText="CAMPO DETALLADO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="EstadoPubli" HeaderText="ESTADO REVISTA" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="LinkPubli" HeaderText="LINK PUBLICACIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="LinkRevistaPubli" HeaderText="LINK REVISTA" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                   <%-- <asp:BoundField DataField="IdentificacionPartiPubli" HeaderText="IDENTIFICACIÓN INTEGRANTE" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="FiliacionPubli" HeaderText="FILIACIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="NombrePartiPubli" HeaderText="NOMBRE INTEGRANTE" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="ParticipacionPubli" HeaderText="PARTICIPACIÓN INTEGRANTE" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />--%>

                    <asp:TemplateField HeaderText="ACCIONES" HeaderStyle-Font-Size="Small">
                        <ItemTemplate>
                             <asp:LinkButton ID="btnParticipantesLibro2" OnClick="btnParticipantesLibro_Click" CausesValidation="false" runat="server" CssClass="btn btn-success btn-xs btn-circle" Text="<span class='glyphicon glyphicon-user'></span>" ToolTip="Visualizar Participantes..." Style="color: white;" />
                            <asp:LinkButton ID="btnEditarRevistas" CausesValidation="false" runat="server" CssClass="btn btn-warning btn-xs btn-circle" Text="<span class='glyphicon glyphicon-edit'></span>" OnClick="btnEditarRevistas_Click" ToolTip="Editar Registro." Style="color: white;" />
                            <asp:LinkButton ID="btnBorrarRevistas" CausesValidation="false" runat="server" Text="<span class='glyphicon glyphicon-trash'></span>" CssClass="btn btn-danger btn-xs btn-circle" OnClick="btnBorrarRevistas_Click" Style="color: white;" OnClientClick="return confirm('Esta seguro que desea eliminar este registro, esta opción es irreversible?')" ToolTip="Eliminar registro." />
                            <%--ELIMINANDO REGISTRO DE LA BDD --%>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <AlternatingRowStyle BackColor="White" />

                <EditRowStyle BackColor="#004289" />
                <EmptyDataTemplate>
                    SIN REGISTROS
                </EmptyDataTemplate>
                <FooterStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />

                <PagerStyle BackColor="#004289" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />

                <SelectedRowStyle BackColor="Yellow" BorderColor="Black" VerticalAlign="Middle" CssClass="font-weight-bold" />

                <SortedAscendingCellStyle BackColor="#004289" />
                <SortedAscendingHeaderStyle BackColor="#004289" />
                <SortedDescendingCellStyle BackColor="#004289" />
                <SortedDescendingHeaderStyle BackColor="#004289" />
            </asp:GridView>
        </div>
    </asp:Panel>

    <asp:Panel runat="server" ID="pnlGrillaMemoria" Visible="false">
        <br />
        <br />
        <div class="table table-responsive text-center" style="background-color: #F5F5F5;">
            <asp:GridView runat="server" ID="gvwMemoria" CssClass="cabeza table table-bordered table-hover table-responsive text-center" ForeColor="#333333" GridLines="Horizontal" HorizontalAlign="Center" AutoGenerateColumns="false" ToolTip="registros...">
                <Columns>


                    <asp:BoundField DataField="strId_publi" HeaderText="COD" ItemStyle-Width="15px" ItemStyle-Wrap="true" ItemStyle-Font-Size="X-Small" ReadOnly="true" Visible="true" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                    <asp:BoundField DataField="IdCodIes" HeaderText="COD IES" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="CodigoPubliPubli" HeaderText="COD PUBLI" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="TipoPubli" HeaderText="TIPO PUBLI" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="TipoArticuloPubli" HeaderText="TIPO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="NombrePonenciaMPubli" HeaderText="PONENCIA" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="CodigoISSNNPubli" HeaderText="COD ISSN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="strNombreEven_publi" HeaderText="EVENTO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="strEdicionEven_publi" HeaderText="EDICIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="OrganizadoresEventoMPubli" HeaderText="ORGANIZADORES EVENTO" HtmlEncode="false" ItemStyle-CssClass="html" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="strComiteOrgam_publi" HeaderText="COMITÉ" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="PaisMPubli" HeaderText="PAÍS" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="CiudadMPubli" HeaderText="CIUDAD" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="dtFecha_publi" HeaderText="FECHA PUBLICACIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="CampoDetalladoPubli" HeaderText="CAMPO DET" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                   <%-- <asp:BoundField DataField="IdentificacionPartiPubli" HeaderText="IDENTIFICACIÓN INTEGRANTE" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="NombrePartiPubli" HeaderText="NOMBRES INTEGRANTE" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="FiliacionPubli" HeaderText="FILIACIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="ParticipacionPubli" HeaderText="PARTICIPACIÓN INTEGRANTE" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />--%>

                    <asp:TemplateField HeaderText="ACCIONES" HeaderStyle-Font-Size="Small">
                        <ItemTemplate>
                             <asp:LinkButton ID="btnParticipantesLibro" OnClick="btnParticipantesLibro_Click" CausesValidation="false" runat="server" CssClass="btn btn-success btn-xs btn-circle" Text="<span class='glyphicon glyphicon-user'></span>" ToolTip="Visualizar Participantes..." Style="color: white;" />
                            <asp:LinkButton ID="btnEditarMemoria" CausesValidation="false" runat="server" CssClass="btn btn-warning btn-xs btn-circle" Text="<span class='glyphicon glyphicon-edit'></span>" OnClick="btnEditarMemoria_Click" ToolTip="Editar Registro." Style="color: white;" />
                            <asp:LinkButton ID="btnBorrarMemoria" CausesValidation="false" runat="server" Text="<span class='glyphicon glyphicon-trash'></span>" CssClass="btn btn-danger btn-xs btn-circle" OnClick="btnBorrarMemoria_Click" Style="color: white;" OnClientClick="return confirm('Esta seguro que desea eliminar este registro, esta opción es irreversible?')" ToolTip="Eliminar registro." />
                            <%--ELIMINANDO REGISTRO DE LA BDD --%>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <AlternatingRowStyle BackColor="White" />

                <EditRowStyle BackColor="#004289" />
                <EmptyDataTemplate>
                    SIN REGISTROS
                </EmptyDataTemplate>
                <FooterStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />

                <PagerStyle BackColor="#004289" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />

                <SelectedRowStyle BackColor="Yellow" BorderColor="Black" VerticalAlign="Middle" CssClass="font-weight-bold" />

                <SortedAscendingCellStyle BackColor="#004289" />
                <SortedAscendingHeaderStyle BackColor="#004289" />
                <SortedDescendingCellStyle BackColor="#004289" />
                <SortedDescendingHeaderStyle BackColor="#004289" />
            </asp:GridView>
        </div>
    </asp:Panel>


    <%--       
  <div class="col-md-12 text-center">
         <asp:LinkButton runat="server" ID="lbtNuevoPub" CausesValidation="false" Cssclass="btn btn btn-bitbucket text-center" style="border-radius: 100px;  width: 260px; height: 47px; font-weight:bold;" BackColor="#312783" ForeColor="White" Font-Bold="True" OnClick="lbtNuevoPub_Click">Agregar Nuevo</asp:LinkButton>
     
      <br />
       <asp:Label runat="server" ID="lblMsg" ForeColor="Red"></asp:Label>
      
     <br />
      <br />
      </div>--%>



    <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btnTrigger"
        PopupControlID="pnlModal" BackgroundCssClass="modalBackground">
    </ajaxToolkit:ModalPopupExtender>

    <asp:Button ID="btnTrigger" runat="server" Style="display: none" />

    <asp:Panel ID="pnlModal" runat="server" CssClass="modalPopup" Width="100%" Style="display: none; overflow: auto;" BackColor="WhiteSmoke">

        <div class="panel-primary">
            <div class="panel-heading col-lg-12" style="height: auto; width: 100%">
                <div class="col-sm-8">
                    <strong>.::SELECCIONE UNA OPCIÓN::.</strong>
                </div>
                <div class="col-sm-4" style="text-align: right;">
                    <asp:Button ID="btnCerrarModal" runat="server" Text="Salir" CssClass="btn btn-warning" />
                </div>
            </div>

            <div class="col-md-12 text-center">
                <asp:Panel runat="server" ID="pnlPreguntarPub" Visible="true" CssClass="text-center">
                    <br />
                    <asp:RadioButtonList ID="rbl" runat="server" Visible="true" AutoPostBack="true" RepeatDirection="Horizontal" BackColor="#F0AD4E" CssClass="radioList form-control" ForeColor="Black" RepeatLayout="Flow" OnSelectedIndexChanged="rbl_SelectedIndexChanged">
                        <asp:ListItem Value="LIBRO">LIBRO</asp:ListItem>
                        <asp:ListItem Value="CAPLIBRO">CAPITULO DE LIBRO</asp:ListItem>
                        <asp:ListItem Value="REVISTAS">REVISTAS</asp:ListItem>
                        <asp:ListItem Value="MEMORIA">MEMORIA</asp:ListItem>

                    </asp:RadioButtonList>
                </asp:Panel>
            </div>
        </div>
        <asp:Panel ID="pnlLibroGEN" runat="server" Visible="false">
            <asp:Panel ID="pnlLibroGrilla" runat="server" Visible="false">
            </asp:Panel>
        </asp:Panel>


    </asp:Panel>

    <asp:Panel ID="pnlLibroADD" runat="server" Visible="false">
        <div class="row">
            <br />
            <div class="col-md-12 text-center form-control">
                Agregando publicación de libro...
            </div>
            <div class="row">
                <div class="col-md-12">
                    <br />
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO IES*</asp:Label>
                        <asp:TextBox runat="server" ID="txtLibroCodIesAdd" TextMode="Number" CssClass="form-control" Placeholder="Ingrese COD IES..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLibroCodIesAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO PUBLICACIÓN*</asp:Label>
                        <asp:TextBox runat="server" ReadOnly="true" ID="txtLibroCodPubliAdd" CssClass="form-control" Placeholder="Ingrese cod publicación..."></asp:TextBox>
                        
                    </div>
                    <div class="col-md-5">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*TITULO LIBRO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtLibroTituloAdd" CssClass="form-control" Placeholder="Ingrese titulo libro..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLibroTituloAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO ISBN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtLibroCodISBNAdd" CssClass="form-control" TextMode="Number" Placeholder="Ingrese cod ISBN..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLibroCodISBNAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <br />
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*FECHA PUBLI*</asp:Label>
                        <asp:TextBox runat="server" ID="txtFechaPubLibroAdd" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFechaPubLibroAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-4">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CAMPO DETALLADO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCampoDetalladoLibroAdd" CssClass="form-control" Placeholder="Ingrese campo detallado..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCampoDetalladoLibroAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*REVISADO PARES*</asp:Label>
                        <asp:DropDownList ID="ddlParesLibroAdd" runat="server" CssClass="form-control text-center" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                            <asp:ListItem Value="SI">SI</asp:ListItem>
                            <asp:ListItem Value="NO">NO</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlParesLibroAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                  
                    <div class="col-md-1">
                        <asp:LinkButton runat="server" ID="btnCheckmarkADDlIBRO" CssClass="btn btn-success btn-xl btn-circle" Style="color: white;" OnClick="btnCheckmarkADDlIBRO_Click">
        <i class="fas fa-check"></i> <!-- Agrega la clase del icono para el visto -->
                        </asp:LinkButton>
                        <br class="mb-2" />
                        <asp:LinkButton runat="server" CausesValidation="false" ID="btnBroomADDlIBRO" CssClass="btn btn-warning btn-xl btn-circle" Style="color: white;" OnClick="btnBroomADDlIBRO_Click">
        <i class="fas fa-broom"></i> <!-- Agrega la clase del icono para la escoba -->
                        </asp:LinkButton>
                        <br class="mb-2" />
                        <asp:LinkButton runat="server" CausesValidation="false" ID="btnXADDlIBRO" CssClass="btn-block btn-danger  btn-xl btn-circle" Style="color: white;" OnClick="btnXADDlIBRO_Click">
        <i class="fas fa-times"></i> <!-- Agrega la clase del icono para la x -->
                        </asp:LinkButton>
                    </div>


                </div>
            </div>
        </div>

    </asp:Panel>

    <asp:Panel ID="pnlDetalleAdd" runat="server" Visible="false">
         <div class="row">
            <br />
            <div class="col-md-12 text-center form-control">
                Agregando Participante....
            </div>
       
            <div class="row">
               
                <div class="col-md-12">
                     <br />
                   <br />
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*IDENTIFICACIÓN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtIdentificacionDetalleAdd" CssClass="form-control" TextMode="Number" onblur="validarCedulaEcuatoriana(this.value)" Placeholder="Ingrese identificación..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtIdentificacionDetalleAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*NOMBRES PARTICIPANTE*</asp:Label>
                        <asp:TextBox runat="server" ID="txtNombreParticipanteDetalleAdd" CssClass="form-control" Placeholder="Ingrese nombres del participante..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombreParticipanteDetalleAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">

                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*PARTICIPACIÓN*</asp:Label>
                        <asp:DropDownList runat="server" ID="ddlParticipanteDetalleAdd" AutoPostBack="true" CssClass="form-control" BackColor="#F0AD4E" ForeColor="White">
                            <asp:ListItem Value="Autor">AUTOR</asp:ListItem>
                            <asp:ListItem Value="Coautor">COAUTOR</asp:ListItem>
                           
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlParticipanteDetalleAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>

                    </div>
                      <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*FILIACIÓN*</asp:Label>
                        <asp:DropDownList ID="ddlFiliacionDetalleAdd" runat="server" CssClass="form-control text-center" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                            <asp:ListItem Value="SI">SI</asp:ListItem>
                            <asp:ListItem Value="NO">NO</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlFiliacionDetalleAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    </div>
                </div>
             <br />
             <div class="row">
                 <div class="col-md-12 text-center">
            <br />
            <asp:LinkButton ID="lbtADDParticipantes" OnClientClick="return validarCedulaAdd();" runat="server" CssClass="btn btn-success" OnClick="lbtADDParticipantes_Click" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-floppy-disk'&gt;&lt;/span&gt; CREAR REGISTRO" />
            <asp:LinkButton ID="lbtCancellAddParticipantes" CausesValidation="false" runat="server" CssClass="btn btn-danger" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-ban-circle'&gt;&lt;/span&gt; CANCELAR REGISTRO" OnClick="lbtCancellAddParticipantes_Click"/>
            <br />
            <br />
        </div>
             </div>
             </div>
                      

    </asp:Panel>

    <asp:Panel ID="pnlEditDetalle" runat="server" Visible="false">
    <div class="row">
        <br />
        <div class="col-md-12 text-center form-control">
            Editando Participante....
        </div>

        <div class="row">

            <div class="col-md-12">
                <br />
                <br />
                <div class="col-md-3">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*IDENTIFICACIÓN*</asp:Label>
                    <asp:TextBox runat="server" ID="txtIdentificacionEdit" CssClass="form-control" TextMode="Number" onblur="validarCedulaEcuatoriana(this.value)" Placeholder="Ingrese identificación..."></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtIdentificacionEdit" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-3">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*NOMBRES PARTICIPANTE*</asp:Label>
                    <asp:TextBox runat="server" ID="txtNombreParticipanteEdit" CssClass="form-control" Placeholder="Ingrese nombres del participante..."></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombreParticipanteEdit" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-3">

                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*PARTICIPACIÓN*</asp:Label>
                    <asp:DropDownList runat="server" ID="ddlParticipacionEdit" CssClass="form-control" BackColor="#F0AD4E" ForeColor="White">
                        <asp:ListItem Value="Autor">AUTOR</asp:ListItem>
                        <asp:ListItem Value="Coautor">COAUTOR</asp:ListItem>

                    </asp:DropDownList>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlParticipacionEdit" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>

                </div>
                <div class="col-md-3">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*FILIACIÓN*</asp:Label>
                    <asp:DropDownList ID="ddlFiliacionEdit" runat="server" CssClass="form-control text-center" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                        <asp:ListItem Value="SI">SI</asp:ListItem>
                        <asp:ListItem Value="NO">NO</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlFiliacionEdit" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12 text-center">
                <br />
                <asp:LinkButton ID="lbtnEditDetalle" OnClientClick="return validarCedulaEdit();" runat="server" CssClass="btn btn-success" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-floppy-disk'&gt;&lt;/span&gt; EDITAR REGISTRO" OnClick="lbtnEditDetalle_Click" />
                <asp:LinkButton ID="btnCancellEdirDetalle" CausesValidation="false" runat="server" CssClass="btn btn-danger" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-ban-circle'&gt;&lt;/span&gt; CANCELAR REGISTRO" OnClick="btnCancellEdirDetalle_Click" />
                <br />
                <br />
            </div>
        </div>
    </div>
</asp:Panel>

   <script>
    function validarCedulaEcuatoriana(cedula) {
        cedula = cedula.trim();

        if (!/^\d{10}$/.test(cedula)) {
            return false;
        }

        var coeficientes = [2, 1, 2, 1, 2, 1, 2, 1, 2];
        var total = 0;

        for (var i = 0; i < coeficientes.length; i++) {
            var valor = parseInt(cedula.charAt(i), 10) * coeficientes[i];
            total += (valor > 9) ? valor - 9 : valor;
        }

        var digitoVerificador = (10 - (total % 10)) % 10;

        return digitoVerificador === parseInt(cedula.charAt(9), 10);
    }

    function validarCedulaAdd() {
        var cedulaInput = document.getElementById('<%= txtIdentificacionDetalleAdd.ClientID %>');
        var cedula = cedulaInput.value;

        if (validarCedulaEcuatoriana(cedula)) {
            // Cédula válida, continuar con la inserción
            return true;
        } else {
            toastr.error("La cédula ingresada no es válida.");
            return false;
        }
    }

    function validarCedulaEdit() {
        var cedulaInput = document.getElementById('<%= txtIdentificacionEdit.ClientID %>');
        var cedula = cedulaInput.value;

        if (validarCedulaEcuatoriana(cedula)) {
            // Cédula válida, continuar con la edición
            return true;
        } else {
            toastr.error("La cédula ingresada no es válida.");
            return false;
        }
    }
</script>


    <asp:Panel ID="pnlLibroEdit" runat="server" Visible="false">
        <div class="row">
            <br />
            <div class="col-md-12 text-center form-control">
                Editando publicación de libro...
            </div>
            <div class="row">
                <div class="col-md-12">
                    <br />
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO IES*</asp:Label>
                        <asp:TextBox runat="server" ID="txtEditCodIesLibro" TextMode="Number" CssClass="form-control" Placeholder="Ingrese COD IES..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditCodIesLibro" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO PUBLICACIÓN*</asp:Label>
                        <asp:TextBox runat="server" ReadOnly="true" ID="txtEditCodPubliLibro" CssClass="form-control" Placeholder="Ingrese cod publicación..."></asp:TextBox>
                        
                    </div>
                    <div class="col-md-5">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*TITULO LIBRO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtEditTituloLibro" CssClass="form-control" Placeholder="Ingrese titulo libro..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditTituloLibro" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO ISBN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtEditCodISBNLibro" CssClass="form-control" TextMode="Number" Placeholder="Ingrese cod ISBN..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditCodISBNLibro" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <br />
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*FECHA PUBLI*</asp:Label>
                        <asp:TextBox runat="server" ID="txtEditFechaPubLibro" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditFechaPubLibro" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-4">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CAMPO DETALLADO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtEditCampoDetalladoLibro" CssClass="form-control" Placeholder="Ingrese campo detallado..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditCampoDetalladoLibro" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*REVISADO PARES*</asp:Label>
                        <asp:DropDownList ID="ddlEditParesLibro" runat="server" CssClass="form-control text-center" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                            <asp:ListItem Value="SI">SI</asp:ListItem>
                            <asp:ListItem Value="NO">NO</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlEditParesLibro" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                          <div class="col-md-1">
                        <asp:LinkButton runat="server" ID="btnCheckmarkEditLibro" CssClass="btn btn-success btn-xl btn-circle" Style="color: white;" OnClick="btnCheckmarkEditLibro_Click">
                        <i class="fas fa-pen"></i> <!-- Agrega la clase del icono para el visto -->
                        </asp:LinkButton>
                        <br class="mb-2" />
                        <asp:LinkButton runat="server" CausesValidation="false" ID="btnBroomEditLibro" CssClass="btn btn-warning btn-xl btn-circle" Style="color: white;" OnClick="btnBroomEditLibro_Click">
                        <i class="fas fa-broom"></i> <!-- Agrega la clase del icono para la escoba -->
                        </asp:LinkButton>
                        <br class="mb-2" />
                        <asp:LinkButton runat="server" CausesValidation="false" ID="btnXEditLibro" CssClass="btn-block btn-danger  btn-xl btn-circle" Style="color: white;" OnClick="btnXEditLibro_Click">
                        <i class="fas fa-times"></i> <!-- Agrega la clase del icono para la x -->
                        </asp:LinkButton>
                    </div>
                    </div>
                </div>
            </div>
          
        </div>
    </asp:Panel>



    <asp:Panel ID="pnlADDCapLibro" runat="server" Visible="false">
        <div class="row">
            <br />
            <div class="col-md-12 text-center form-control">
                Agregando publicación de Capitulo de libro...
            </div>
            <div class="row">
                <div class="col-md-12">
                    <br />
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO IES*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCapLibroCodIesAdd" TextMode="Number" CssClass="form-control" Placeholder="Ingrese COD IES..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCapLibroCodIesAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO PUBLICACIÓN*</asp:Label>
                        <asp:TextBox runat="server" ReadOnly="true" ID="txtCapLibroCodPubliAdd" CssClass="form-control" Placeholder="Ingrese cod publicación..."></asp:TextBox>
                        
                    </div>
                    <div class="col-md-4">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*TITULO CAPITULO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCapLibroTituloCapAdd" CssClass="form-control" Placeholder="Ingrese titulo del Capitulo..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCapLibroTituloCapAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-4">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*TITULO LIBRO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCapLibroTituloAdd" CssClass="form-control" Placeholder="Ingrese titulo del libro..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCapLibroTituloAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO ISBN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCapLibroCodISBNAdd" CssClass="form-control" TextMode="Number" Placeholder="Ingrese ISBN..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCapLibroCodISBNAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*EDIT COMPI*</asp:Label>
                        <asp:TextBox ID="txttags1" runat="server" placeholder="Ingrese editor compliador" CssClass="form-control" Width="100%" data-role="tagsinput"></asp:TextBox>

                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txttags1" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*PAGINAS*</asp:Label>
                        <asp:TextBox runat="server" ID="txtPagsCapLibroAdd" CssClass="form-control" TextMode="Number" Placeholder="Ingrese pags..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPagsCapLibroAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*FECHA PUBLICACIÓN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtFechaPubCapLibroAdd" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFechaPubCapLibroAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CAMPO DETALLADO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCampoDetalladoCapLibroAdd" CssClass="form-control" Placeholder="Ingrese campo detallado..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCampoDetalladoCapLibroAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                      <div class="col-md-1">
                        <asp:LinkButton runat="server" ID="btnADDCapLibro" CssClass="btn btn-success btn-xl btn-circle" Style="color: white;" OnClick="btnADDCapLibro_Click">
        <i class="fas fa-check"></i> <!-- Agrega la clase del icono para el visto -->
                        </asp:LinkButton>
                        <br class="mb-2" />
                        <asp:LinkButton runat="server" CausesValidation="false" ID="btnLimpiarCapLibro" CssClass="btn btn-warning btn-xl btn-circle" Style="color: white;" OnClick="btnLimpiarCapLibro_Click">
        <i class="fas fa-broom"></i> <!-- Agrega la clase del icono para la escoba -->
                        </asp:LinkButton>
                        <br class="mb-2" />
                        <asp:LinkButton runat="server" CausesValidation="false" ID="btnCancelarADDCapLibro" CssClass="btn-block btn-danger  btn-xl btn-circle" Style="color: white;" OnClick="btnCancelarADDCapLibro_Click">
        <i class="fas fa-times"></i> <!-- Agrega la clase del icono para la x -->
                        </asp:LinkButton>
                    </div>
                </div>
            </div>

        </div>

    </asp:Panel>


    <asp:Panel ID="pnlEditCapLibro" runat="server" Visible="false">
        <div class="row">
            <br />
            <div class="col-md-12 text-center form-control">
                Editando publicación de Capítulo de libro...
            </div>
            <div class="row">
                <div class="col-md-12">
                    <br />
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO IES*</asp:Label>
                        <asp:TextBox runat="server" ID="txtEditCapLibroCodIes" TextMode="Number" CssClass="form-control" Placeholder="Ingrese COD IES..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditCapLibroCodIes" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO PUBLICACIÓN*</asp:Label>
                        <asp:TextBox runat="server" ReadOnly="true" ID="txtEditCapLibroCodPubli" CssClass="form-control" Placeholder="Ingrese cod publicación..."></asp:TextBox>
                        
                    </div>
                    <div class="col-md-4">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*TITULO CAPITULO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtEditCapLibroTituloCap" CssClass="form-control" Placeholder="Ingrese titulo del Capitulo..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditCapLibroTituloCap" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-4">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*TITULO LIBRO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtEditCapLibroTituloLibro" CssClass="form-control" Placeholder="Ingrese titulo del libro..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditCapLibroTituloLibro" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO ISBN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtEditCapLibroCodISBN" CssClass="form-control" TextMode="Number" Placeholder="Ingrese ISBN..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditCapLibroCodISBN" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*EDIT COMPI*</asp:Label>
                        <asp:TextBox ID="txtEditCapLibroEditorCompilador" runat="server" placeholder="Ingrese editor compilador" CssClass="form-control" Width="100%" data-role="tagsinput"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditCapLibroEditorCompilador" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*PAGINAS*</asp:Label>
                        <asp:TextBox runat="server" ID="txtEditCapLibroPags" CssClass="form-control" TextMode="Number" Placeholder="Ingrese pags..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditCapLibroPags" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*FECHA PUBLICACIÓN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtEditCapLibroFechaPub" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditCapLibroFechaPub" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CAMPO DETALLADO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtEditCapLibroCampoDetallado" CssClass="form-control" Placeholder="Ingrese campo detallado..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditCapLibroCampoDetallado" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                      <div class="col-md-1">
                        <asp:LinkButton runat="server" ID="btnUpdateCapLibro" CssClass="btn btn-success btn-xl btn-circle" Style="color: white;" OnClick="btnUpdateCapLibro_Click">
                        <i class="fas fa-pen"></i> <!-- Agrega la clase del icono para el visto -->
                        </asp:LinkButton>
                        <br class="mb-2" />
                        <asp:LinkButton runat="server" CausesValidation="false" ID="btnBorrarCapLibro" CssClass="btn btn-warning btn-xl btn-circle" Style="color: white;" OnClick="btnBorrarCapLibro_Click1">
                        <i class="fas fa-broom"></i> <!-- Agrega la clase del icono para la escoba -->
                        </asp:LinkButton>
                        <br class="mb-2" />
                        <asp:LinkButton runat="server" CausesValidation="false" ID="btnCancelarEditCapLibro" CssClass="btn-block btn-danger  btn-xl btn-circle" Style="color: white;" OnClick="btnCancelarEditCapLibro_Click">
                        <i class="fas fa-times"></i> <!-- Agrega la clase del icono para la x -->
                        </asp:LinkButton>
                    </div>
                </div>
            </div>

            </div>
        </div>
    </asp:Panel>



    <asp:Panel ID="pnlMemoriaADD" runat="server" Visible="false">
        <div class="row">
            <br />
            <div class="col-md-12 text-center form-control">
                Agregando publicación de Memoria Eventos...
            </div>
            <div class="row">
                <div class="col-md-12">
                    <br />
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO IES*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCodIesMemoriaAdd" TextMode="Number" CssClass="form-control" Placeholder="Ingrese COD IES..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCodIesMemoriaAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*TIPO PUBLICA*</asp:Label>
                        <asp:DropDownList ID="ddlTipoPubAddMemoria" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                            <asp:ListItem Value="Articulo">Articulo</asp:ListItem>
                            <asp:ListItem Value="Revista">Revista</asp:ListItem>
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlTipoPubAddMemoria" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO PUBLICACIÓN*</asp:Label>
                        <asp:TextBox runat="server" ReadOnly="true" ID="txtCodPubliMemoriaAdd" CssClass="form-control" Placeholder="Ingrese cod publicación..."></asp:TextBox>
                        
                    </div>
                    <div class="col-md-4">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*NOMBRE PONENCIA*</asp:Label>
                        <asp:TextBox runat="server" ID="txtNombrePonenciaMemoriaAdd" CssClass="form-control" Placeholder="Ingrese nombre de ponencia..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombrePonenciaMemoriaAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*ISBN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtIsbnMemoriaAdd" CssClass="form-control" Placeholder="Ingrese cod ISBN..." TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtIsbnMemoriaAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-4">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*NOMBRE EVENTO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtNombreEventoMemoriaAdd" CssClass="form-control" Placeholder="Ingrese nombre del evento..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombreEventoMemoriaAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*EDICIÓN*</asp:Label>

               

<!-- Script para aplicar Chosen al DropDownList -->
<script>
    $(document).ready(function () {
        // Asignar la función chosen al DropDownList
        $(".chosen-select").chosen();
    });
</script>

                        <asp:TextBox ID="txtEdicionMemoriaAdd"  CssClass="form-control"
                             runat="server" Width="100%"  placeholder="Ingrese la edición">
                          <%--  <asp:ListItem Value="Primera edicion">Primera edición</asp:ListItem>
                            <asp:ListItem Value="Segunda edicion">Segunda edición</asp:ListItem>
                            <asp:ListItem Value="Tercera edicion">Tercera edición</asp:ListItem>
                            <asp:ListItem Value="Cuarta edicion">Cuarta edición</asp:ListItem>
                            <asp:ListItem Value="Quinta edicion">Quinta edición</asp:ListItem>
                            <asp:ListItem Value="Sexta edicion">Sexta edición</asp:ListItem>
                            <asp:ListItem Value="Septima edicion">Septima edición</asp:ListItem>
                            <asp:ListItem Value="Octava edicion">Octava edición</asp:ListItem>
                            <asp:ListItem Value="Novena edicion">Novena edición</asp:ListItem>
                            <asp:ListItem Value="Decima edicion">Decima edición</asp:ListItem>--%>
                            
                        </asp:TextBox>
                        
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEdicionMemoriaAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-6">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*ORGANIZADOR EVENTO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtOrganizadorMemoriaAdd" CssClass="form-control" Placeholder="Ingrese organizador del evento..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOrganizadorMemoriaAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>

                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*COMITÉ ORGANIZADOR*</asp:Label>
                        <asp:TextBox runat="server" ID="txtComiteMemoriaAdd" CssClass="form-control" Placeholder="Ingrese comité organizador..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtComiteMemoriaAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*PAÍS*</asp:Label>
                        <asp:TextBox runat="server" ID="txtPaisMemoriaAdd" CssClass="form-control" Placeholder="Ingrese país..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPaisMemoriaAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CIUDAD*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCiudadMemoriaAdd" CssClass="form-control" Placeholder="Ingrese ciudad..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCiudadMemoriaAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-5">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*FECHA PUBLICACIÓN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtFechaPubMemoriaAdd" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFechaPubMemoriaAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-6">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CAMPO DETALLADO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCampoDetalladoMemoriaAdd" CssClass="form-control" Placeholder="Ingrese campo detallado..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCampoDetalladoMemoriaAdd" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="col-md-1">
                        <asp:LinkButton runat="server" ID="btnADDMemoria" CssClass="btn btn-success btn-xl btn-circle" Style="color: white;" OnClick="btnADDMemoria_Click">
        <i class="fas fa-check"></i> <!-- Agrega la clase del icono para el visto -->
                        </asp:LinkButton>
                        <br class="mb-2" />
                        <asp:LinkButton runat="server" CausesValidation="false" ID="btnClearMemoria" CssClass="btn btn-warning btn-xl btn-circle" Style="color: white;" OnClick="btnClearMemoria_Click">
        <i class="fas fa-broom"></i> <!-- Agrega la clase del icono para la escoba -->
                        </asp:LinkButton>
                        <br class="mb-2" />
                        <asp:LinkButton runat="server" CausesValidation="false" ID="btnCancellMemoria" CssClass="btn-block btn-danger  btn-xl btn-circle" Style="color: white;" OnClick="btnCancellMemoria_Click">
        <i class="fas fa-times"></i> <!-- Agrega la clase del icono para la x -->
                        </asp:LinkButton>
                    </div>



                </div>
            </div>
        </div>

    </asp:Panel>


    <asp:Panel ID="pnlMemoriaEdit" runat="server" Visible="false">
        <div class="row">
            <br />
            <div class="col-md-12 text-center form-control">
                Editando publicación de Memoria Eventos...
            </div>
            <div class="row">
                <div class="col-md-12">
                    <br />

                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO IES*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCodIesMemoriaEdit" TextMode="Number" CssClass="form-control" Placeholder="Ingrese COD IES..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCodIesMemoriaEdit" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*TIPO PUBLICA*</asp:Label>
                        <asp:DropDownList ID="ddlTipoPubEditMemoria" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                            <asp:ListItem Value="Articulo">Articulo</asp:ListItem>
                            <asp:ListItem Value="Revista">Revista</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlTipoPubEditMemoria" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO PUBLICACIÓN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCodPubliMemoriaEdit" ReadOnly="true" CssClass="form-control" Placeholder="Ingrese cod publicación..."></asp:TextBox>
                       
                    </div>
                    <div class="col-md-4">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*NOMBRE PONENCIA*</asp:Label>
                        <asp:TextBox runat="server" ID="txtNombrePonenciaMemoriaEdit" CssClass="form-control" Placeholder="Ingrese nombre de ponencia..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombrePonenciaMemoriaEdit" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*ISBN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtIsbnMemoriaEdit" CssClass="form-control" Placeholder="Ingrese cod ISBN..." TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtIsbnMemoriaEdit" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">

                    <div class="col-md-4">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*NOMBRE EVENTO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtNombreEventoMemoriaEdit" CssClass="form-control" Placeholder="Ingrese nombre del evento..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombreEventoMemoriaEdit" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*EDICIÓN*</asp:Label>
                        <asp:TextBox ID="txtEdicionMemoriaEdit" CssClass="form-control text-center" runat="server" Width="100%" placeholder="Ingrese la edición">
                           
                        </asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEdicionMemoriaEdit" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-6">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*ORGANIZADOR EVENTO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtOrganizadorMemoriaEdit" CssClass="form-control" Placeholder="Ingrese organizador del evento..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOrganizadorMemoriaEdit" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*COMITÉ ORGANIZADOR*</asp:Label>
                        <asp:TextBox runat="server" ID="txtComiteMemoriaEdit" CssClass="form-control" Placeholder="Ingrese comité organizador..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtComiteMemoriaEdit" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*PAÍS*</asp:Label>
                        <asp:TextBox runat="server" ID="txtPaisMemoriaEdit" CssClass="form-control" Placeholder="Ingrese país..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPaisMemoriaEdit" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CIUDAD*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCiudadMemoriaEdit" CssClass="form-control" Placeholder="Ingrese ciudad..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCiudadMemoriaEdit" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-5">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*FECHA PUBLICACIÓN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtFechaPubMemoriaEdit" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFechaPubMemoriaEdit" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-6">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CAMPO DETALLADO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCampoDetalladoMemoriaEdit" CssClass="form-control" Placeholder="Ingrese campo detallado..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCampoDetalladoMemoriaEdit" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                     
                    <div class="col-md-1">
                        <asp:LinkButton runat="server" ID="btnEditMemoria" CssClass="btn btn-success btn-xl btn-circle" Style="color: white;" OnClick="btnEditMemoria_Click">
                        <i class="fas fa-pen"></i> <!-- Agrega la clase del icono para el visto -->
                        </asp:LinkButton>
                        <br class="mb-2" />
                        <asp:LinkButton runat="server" CausesValidation="false" ID="btnClearMemoriaEdit" CssClass="btn btn-warning btn-xl btn-circle" Style="color: white;" OnClick="btnClearMemoriaEdit_Click">
                        <i class="fas fa-broom"></i> <!-- Agrega la clase del icono para la escoba -->
                        </asp:LinkButton>
                        <br class="mb-2" />
                        <asp:LinkButton runat="server" CausesValidation="false" ID="btnCancelMemoriaEdit" CssClass="btn-block btn-danger  btn-xl btn-circle" Style="color: white;" OnClick="btnCancelMemoriaEdit_Click">
                        <i class="fas fa-times"></i> <!-- Agrega la clase del icono para la x -->
                        </asp:LinkButton>
                    </div>
                  
                </div>
            </div>
       
            </div>

    </asp:Panel>



    <asp:Panel ID="pnlADDRevistas" runat="server" Visible="false">
        <div class="row">
            <br />
            <div class="col-md-12 text-center form-control">
                Agregando publicación de Revistas...
            </div>
            <div class="row">
                <div class="col-md-12">
                    <br />
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*AÑO*</asp:Label>
                        <asp:DropDownList ID="ddlAnioRevista" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlAnioRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO IES*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCodIesAddRevista" TextMode="Number" CssClass="form-control" Placeholder="Ingrese COD IES..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCodIesAddRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*TIPO PUBLICA*</asp:Label>
                        <asp:DropDownList ID="ddlTipoPubAddRevista" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                            <asp:ListItem Value="Articulo">Articulo</asp:ListItem>
                            <asp:ListItem Value="Revista">Revista</asp:ListItem>
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlTipoPubAddRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO PUBLICACIÓN*</asp:Label>
                        <asp:TextBox runat="server" ReadOnly="true" ID="txtCodPubliAddRevista" CssClass="form-control" Placeholder="Ingrese cod publicación..."></asp:TextBox>
                        
                    </div>

                    <div class="col-md-4">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*TITULO PUBLI*</asp:Label>
                        <asp:TextBox runat="server" ID="txtTituloPubliAddRevista" CssClass="form-control" Placeholder="Ingrese titulo de la publicación..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTituloPubliAddRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*BASE DE DATOS INDEX*</asp:Label>
                        <asp:DropDownList ID="ddlBddAddRevista" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                            <asp:ListItem Value="Scopus">Scopus</asp:ListItem>
                            <asp:ListItem Value="Scielo">Scielo</asp:ListItem>
                            <asp:ListItem Value="Goggle Academico">Google Acádemico</asp:ListItem>
                            <asp:ListItem Value="ScienceDirect">ScienceDirect</asp:ListItem>
                            <asp:ListItem Value="Web of Science">Web of Science</asp:ListItem>
                            <asp:ListItem Value="IEEE Xplore">IEEE Xplore</asp:ListItem>
                            <asp:ListItem Value="PubMed">PubMed</asp:ListItem>
                            <asp:ListItem Value="ACM Digital Library">ACM Digital Library</asp:ListItem>
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlBddAddRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*REGIONAL/IMPACTO*</asp:Label>
                        <asp:DropDownList ID="dllRIAddRevista" AutoPostBack="true" OnSelectedIndexChanged="dllRIAddRevista_SelectedIndexChanged" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                            <asp:ListItem Value="Regional">Regional</asp:ListItem>
                            <asp:ListItem Value="Alto Impacto">Alto Impacto</asp:ListItem>

                        </asp:DropDownList>

                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dllRIAddRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO ISSN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCodISSNAddRevista" CssClass="form-control" TextMode="Number" Placeholder="Ingrese ISSN..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCodISSNAddRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-4">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*NOMBRE REVISTA*</asp:Label>
                        <asp:TextBox runat="server" ID="txtNombreAddRevista" CssClass="form-control" Placeholder="Ingrese Nombre Revista..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombreAddRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>

                </div>
            </div>
            <div class="row">
                <div class="col-md-12">

                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*NUM REVISTA*</asp:Label>
                        <asp:TextBox ID="txtNumeroRevistaAddRevista" runat="server" placeholder="Ingrese numero de revista" CssClass="form-control" Width="100%"></asp:TextBox>

                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNumeroRevistaAddRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*SJR*</asp:Label>
                        <asp:TextBox runat="server" ID="txtSjrAddRevista" Enabled="false" CssClass="form-control" TextMode="Number" Placeholder="Ingrese SJR..."></asp:TextBox>
                        
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*FECHA PUBLICACIÓN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtFechaPubAddRevista" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFechaPubAddRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CAMPO DETALLADO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCampoDetAddRevista" CssClass="form-control" Placeholder="Ingrese campo detallado..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCampoDetAddRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*ESTADO*</asp:Label>
                        <asp:DropDownList ID="ddlEstadoAddRevista" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                            <asp:ListItem Value="Publicado">Publicado</asp:ListItem>
                            <asp:ListItem Value="No Publicado">No Publicado</asp:ListItem>
                            <asp:ListItem Value="En revisión">En revisión</asp:ListItem>

                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlEstadoAddRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*LINK PUBLICACIÓN*</asp:Label>

                        <asp:TextBox runat="server" ID="txtLinkPubliAddRevista" CssClass="form-control" Placeholder="Ingrese link de publicación..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLinkPubliAddRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>

                    </div>
                    <div class="col-md-5">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*LINK REVISTA*</asp:Label>

                        <asp:TextBox runat="server" ID="txtLinkRevistaAddRevista" CssClass="form-control" Placeholder="Ingrese link de Revista..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLinkRevistaAddRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>

                    </div>
                     <div class="col-md-1">
                        <asp:LinkButton runat="server" ID="btnAddRevista" CssClass="btn btn-success btn-xl btn-circle" Style="color: white;" OnClick="btnAddRevista_Click">
        <i class="fas fa-check"></i> <!-- Agrega la clase del icono para el visto -->
                        </asp:LinkButton>
                        <br class="mb-2" />
                        <asp:LinkButton runat="server" CausesValidation="false" ID="btnLimpiarRevista" CssClass="btn btn-warning btn-xl btn-circle" Style="color: white;" OnClick="btnLimpiarRevista_Click">
        <i class="fas fa-broom"></i> <!-- Agrega la clase del icono para la escoba -->
                        </asp:LinkButton>
                        <br class="mb-2" />
                        <asp:LinkButton runat="server" CausesValidation="false" ID="btnCancelarRevista" CssClass="btn-block btn-danger  btn-xl btn-circle" Style="color: white;" OnClick="btnCancelarRevista_Click">
        <i class="fas fa-times"></i> <!-- Agrega la clase del icono para la x -->
                        </asp:LinkButton>
                    </div>
                </div>
        </div>

    </asp:Panel>


    <asp:Panel ID="pnlEditRevistas" runat="server" Visible="false">
        <div class="row">
            <br />
            <div class="col-md-12 text-center form-control">
                Editando publicación de Revistas...
            </div>
            <div class="row">
                <div class="col-md-12">
                    <br />
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*AÑO*</asp:Label>
                        <asp:DropDownList ID="ddlAnioRevistaEdit" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlAnioRevistaEdit" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO IES*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCodIesEditRevista" TextMode="Number" CssClass="form-control" Placeholder="Ingrese COD IES..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCodIesEditRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*TIPO PUBLICA*</asp:Label>
                        <asp:DropDownList ID="ddlTipoPubEditRevista" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                            <asp:ListItem Value="Articulo">Articulo</asp:ListItem>
                            <asp:ListItem Value="Revista">Revista</asp:ListItem>
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlTipoPubEditRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO PUBLICACIÓN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCodPubliEditRevista" ReadOnly="true" CssClass="form-control" Placeholder="Ingrese cod publicación..."></asp:TextBox>
                        
                    </div>

                    <div class="col-md-4">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*TITULO PUBLI*</asp:Label>
                        <asp:TextBox runat="server" ID="txtTituloPubliEditRevista" CssClass="form-control" Placeholder="Ingrese titulo de la publicación..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTituloPubliEditRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*BASE DE DATOS INDEX*</asp:Label>
                        <asp:DropDownList ID="ddlBddEditRevista" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                            <asp:ListItem Value="Scopus">Scopus</asp:ListItem>
                            <asp:ListItem Value="Scielo">Scielo</asp:ListItem>
                            <asp:ListItem Value="Goggle Academico">Google Acádemico</asp:ListItem>
                            <asp:ListItem Value="ScienceDirect">ScienceDirect</asp:ListItem>
                            <asp:ListItem Value="Web of Science">Web of Science</asp:ListItem>
                            <asp:ListItem Value="IEEE Xplore">IEEE Xplore</asp:ListItem>
                            <asp:ListItem Value="PubMed">PubMed</asp:ListItem>
                            <asp:ListItem Value="ACM Digital Library">ACM Digital Library</asp:ListItem>
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlBddEditRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*REGIONAL/IMPACTO*</asp:Label>
                        <asp:DropDownList ID="dllRIEditRevista" OnSelectedIndexChanged="dllRIEditRevista_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                            <asp:ListItem Value="Regional">Regional</asp:ListItem>
                            <asp:ListItem Value="Alto Impacto">Alto Impacto</asp:ListItem>

                        </asp:DropDownList>

                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dllRIEditRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CODIGO ISSN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCodISSNEditRevista" CssClass="form-control" TextMode="Number" Placeholder="Ingrese ISSN..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCodISSNEditRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-4">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*NOMBRE REVISTA*</asp:Label>
                        <asp:TextBox runat="server" ID="txtNombreEditRevista" CssClass="form-control" Placeholder="Ingrese Nombre Revista..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombreEditRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>

                </div>
            </div>
            <div class="row">
                <div class="col-md-12">

                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*NUM REVISTA*</asp:Label>
                        <asp:TextBox ID="txtNumeroRevistaEditRevista" runat="server" placeholder="Ingrese numero de revista" CssClass="form-control" Width="100%"></asp:TextBox>

                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNumeroRevistaEditRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*SJR*</asp:Label>
                        <asp:TextBox runat="server" ID="txtSjrEditRevista" Enabled="true" CssClass="form-control" TextMode="Number" Placeholder="Ingrese SJR..."></asp:TextBox>
                       
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*FECHA PUBLICACIÓN*</asp:Label>
                        <asp:TextBox runat="server" ID="txtFechaPubEditRevista" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFechaPubEditRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*CAMPO DETALLADO*</asp:Label>
                        <asp:TextBox runat="server" ID="txtCampoDetEditRevista" CssClass="form-control" Placeholder="Ingrese campo detallado..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCampoDetEditRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*ESTADO*</asp:Label>
                        <asp:DropDownList ID="ddlEstadoEditRevista" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                            <asp:ListItem Value="Publicado">Publicado</asp:ListItem>
                            <asp:ListItem Value="No Publicado">No Publicado</asp:ListItem>
                            <asp:ListItem Value="En revisión">En revisión</asp:ListItem>

                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlEstadoEditRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*LINK PUBLICACIÓN*</asp:Label>

                        <asp:TextBox runat="server" ID="txtLinkPubliEditRevista" CssClass="form-control" Placeholder="Ingrese link de publicación..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLinkPubliEditRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>

                    </div>
                    <div class="col-md-5">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*LINK REVISTA*</asp:Label>

                        <asp:TextBox runat="server" ID="txtLinkRevistaEditRevista" CssClass="form-control" Placeholder="Ingrese link de Revista..."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLinkRevistaEditRevista" ErrorMessage="Este campo es requerido" ForeColor="Red"></asp:RequiredFieldValidator>

                    </div>
                    
                    <div class="col-md-1">
                        <asp:LinkButton runat="server" ID="btnEditRevista" CssClass="btn btn-success btn-xl btn-circle" OnClick="btnEditRevista_Click" Style="color: white;">
                        <i class="fas fa-pen"></i> <!-- Agrega la clase del icono para el visto -->
                        </asp:LinkButton>
                        <br class="mb-2" />
                        <asp:LinkButton runat="server" CausesValidation="false" ID="btnLimpiarEditRevista" CssClass="btn btn-warning btn-xl btn-circle" Style="color: white;" OnClick="btnLimpiarEditRevista_Click">
                        <i class="fas fa-broom"></i> <!-- Agrega la clase del icono para la escoba -->
                        </asp:LinkButton>
                        <br class="mb-2" />
                        <asp:LinkButton runat="server" CausesValidation="false" ID="btnCancelarEditRevista" CssClass="btn-block btn-danger  btn-xl btn-circle" Style="color: white;" OnClick="btnCancelarEditRevista_Click">
                        <i class="fas fa-times"></i> <!-- Agrega la clase del icono para la x -->
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
         </div>
      

    </asp:Panel>



    <script>
        function validarCampos() {
            var txtLibroCodIesAdd = document.getElementById('<%= txtLibroCodIesAdd.ClientID %>');
            var txtLibroCodPubliAdd = document.getElementById('<%= txtLibroCodPubliAdd.ClientID %>');
            var txtLibroTituloAdd = document.getElementById('<%= txtLibroTituloAdd.ClientID %>');
            var txtLibroCodISBNAdd = document.getElementById('<%= txtLibroCodISBNAdd.ClientID %>');
            var txtFechaPubLibroAdd = document.getElementById('<%= txtFechaPubLibroAdd.ClientID %>');
            var txtCampoDetalladoLibroAdd = document.getElementById('<%= txtCampoDetalladoLibroAdd.ClientID %>');
            

            if (txtLibroCodIesAdd.value.trim() === '') {
                toastr.error('El campo Codigo IES es requerido.');
                return false;
            }
           
            if (txtLibroTituloAdd.value.trim() === '') {
                toastr.error('El campo Título Libro es requerido.');
                return false;
            }
            if (txtLibroCodISBNAdd.value.trim() === '') {
                toastr.error('El campo Codigo ISBN es requerido.');
                return false;
            }
            if (txtFechaPubLibroAdd.value.trim() === '') {
                toastr.error('El campo Fecha Publicación es requerido.');
                return false;
            }
            if (txtCampoDetalladoLibroAdd.value.trim() === '') {
                toastr.error('El campo Campo Detallado es requerido.');
                return false;
            }
            
           

            return true;
        }
    </script>



</asp:Content>
