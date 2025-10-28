<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GrupoInv.aspx.cs" Inherits="utc.GrupoInv" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- ======================= -->
    <!--   ESTILOS Y LIBRERÍAS   -->
    <!-- ======================= -->

    <!-- DataTables CSS -->
    <link href="prueba/Styles/datatables/datatables.css" rel="stylesheet" />

    <!-- Chosen (select mejorado) -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" rel="stylesheet" />

    <!-- Font Awesome (una sola vez, versión moderna) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />

    <!-- Toastr (si usas notificaciones) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css"
          integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />

    <!-- Estilos propios -->
    <link href="prueba/Styles/propio/propio.css" rel="stylesheet" />

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
        }
    </style>

    <!-- ========================= -->
    <!--   SCRIPTS Y FUNCIONALIDAD -->
    <!-- ========================= -->

    <!-- ScriptManager (necesario para postback asíncrono en WebForms) -->
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <!-- DataTables -->
    <script src="prueba/Scripts/datatables/datatables.min.js"></script>

    <!-- Librerías para exportación PDF/Excel -->
    <script src="prueba/Scripts/datatables_imprimir/pdfmake.min.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/vfs_fonts.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/print.js"></script>

    <!-- Script personalizado para DataTables -->
    <script src="prueba/Scripts/propias/datatablesMetodo.js"></script>

    <!-- Chosen -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>

    <!-- Toastr -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"
            integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <!-- SweetAlert2 (NO lo dupliques, ya está en Site.Master) -->
    <!-- <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> -->

    <!-- CKEditor (si lo usas en esta página) -->
    <script src="https://cdn.ckeditor.com/4.18.0/full/ckeditor.js"></script>

    <!-- =============================== -->
    <!--   FUNCIONES PERSONALIZADAS JS   -->
    <!-- =============================== -->


    <div class="row">
        <div class="col-md-12 text-center">
            <asp:Panel ID="Panel1" runat="server" BackColor="White" Width="100%">
                <div class="row">
                    <div class="col-md-12 text-center">
                        <div class="col-md-4 text-center">
                            <%--<asp:button Cssclass="btn btn btn-bitbucket text-center" style="border-radius: 100px; width: 214px; height: 52px;"  BackColor="#312783" ForeColor="White" Font-Bold="True" runat="server" Text="UTC"  ID="btnUtc" ClientIDMode="Static" ToolTip="UNIVERSIDAD TÉCNICA DE COTOPAXI..." Font-Size="25px"> </asp:button>--%>                       <%-- <label class="" style="color: #312783; font-size:25px;">UTC</label>--%>
                        </div>
                        <div class="col-md-4 text-center">
                            <h3 style="color: #312783; font-weight: bold;"><i class="fa fa-book"></i>SISTEMA DE GESTIÓN GENERAL DE INVESTIGACIÓN
                            </h3>
                        </div>
                        <div class="col-md-4 text-center">
                            <asp:LinkButton CssClass="btn btn btn-bitbucket text-center" Style="border-radius: 100px; width: 260px; height: 47px; font-weight: bold;" runat="server" Text="<span><i class='fa fa-chevron-left'></i></span> REGRESAR" BackColor="#312783" ForeColor="White" CausesValidation="false" Font-Bold="True" ID="btnRegresarGruInv" ToolTip="REGRESAR..." Font-Size="20px" Visible="false" OnClick="btnRegresarGruInv_Click"> </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <br />
            <asp:Panel ID="pnlOcultarBoton" runat="server">
                <%-- <asp:Button ID="btnCrearCabeceraAcad" runat="server" Text="Nuevo Registo" OnClick="btnCrearCabeceraAcad_Click" CssClass="btn btn-bitbucket " Style="border-radius: 100px;" />--%>
                <asp:Label ID="codigo" runat="server" Visible="false" ForeColor="red"></asp:Label>
                <asp:Label ID="fullpath1" runat="server" ForeColor="red" Visible="false"></asp:Label>
            </asp:Panel>
            <div class="text-right">
                <asp:Label runat="server" ID="lblcodigo"></asp:Label>
            </div>
        </div>
    </div>
    <div class="col-md-12 text-center">
        <asp:LinkButton runat="server" ID="lbtNuevoGruInv" CausesValidation="false" CssClass="btn btn btn-bitbucket text-center" Style="border-radius: 100px; width: 260px; height: 47px; font-weight: bold;" BackColor="#312783" ForeColor="White" Font-Bold="True" OnClick="lbtNuevoGruInv_Click">Agregar Nuevo</asp:LinkButton>
    </div>

    <asp:Panel runat="server" ID="pnlGrilla" Visible="true">
        <br />
        <div class="table table-responsive text-center" style="background-color: #F5F5F5;">
            <br />
            <asp:GridView runat="server" ID="gvwListadoGruInv" CssClass="cabeza table table-bordered table-hover table-responsive text-center" DataKeyNames="strId_gru" ForeColor="#333333" GridLines="Horizontal" HorizontalAlign="Center" AutoGenerateColumns="false" ToolTip="registros...">
                <Columns>
                    <asp:BoundField DataField="strId_gru" HeaderText="COD" ItemStyle-Width="15px" ItemStyle-Wrap="true" ItemStyle-Font-Size="X-Small" ReadOnly="true" Visible="true" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                    <asp:BoundField DataField="strArchivo_gru" HeaderText="COD" ItemStyle-Width="15px" ItemStyle-Wrap="true" ItemStyle-Font-Size="X-Small" ReadOnly="true" Visible="true" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                    <asp:BoundField DataField="strNombre_gru" HeaderText="NOMBRE GRUPO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="strCoordinador_gru" HeaderText="COORDINADOR" HtmlEncode="false" ItemStyle-CssClass="html" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="dtFechacrea_gru" HeaderText="FECHA CREACIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="strLineasinv_gru" HeaderText="LINEA INV" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="strSublineasinv_gru" HeaderText="SUBLINEA INV" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />

                    <asp:TemplateField HeaderText="ACCIONES" HeaderStyle-Font-Size="Small">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnVerArchivoGruInv" OnClick="btnVerArchivoGruInv_Click" CausesValidation="false" runat="server" CssClass="btn btn-info btn-xs btn-circle" Text="<span class='glyphicon glyphicon-paperclip'></span>"  ToolTip="Ver Adjunto.." Style="color: white;" />
                            <asp:LinkButton ID="btnVerMienbrosGruInv" CausesValidation="false" runat="server" CssClass="btn btn-success btn-xs btn-circle" Text="<span class='glyphicon glyphicon-user'></span>" OnClick="btnVerMienbrosGruInv_Click" ToolTip="Ver Integrantes.." Style="color: white;" />
                            <asp:LinkButton ID="btnEditarGruInv" CausesValidation="false" runat="server" CssClass="btn btn-warning btn-xs btn-circle" Text="<span class='glyphicon glyphicon-edit'></span>" OnClick="btnEditarGruInv_Click" ToolTip="Editar Registro." Style="color: white;" />
                            <asp:LinkButton ID="btnBorrarGruInv" CausesValidation="false" runat="server" Text="<span class='glyphicon glyphicon-trash'></span>" CssClass="btn btn-danger btn-xs btn-circle" OnClick="btnBorrarGruInv_Click" Style="color: white;" OnClientClick="return confirm('Esta seguro que desea eliminar este registro, esta opción es irreversible?')" ToolTip="Eliminar registro." />
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

    <asp:Panel runat="server" ID="pnlAgregarGruInv" Visible="false" CssClass="form-control">
        <div class="row">
            <div class="col-md-12 text-center">
                Agregando Nuevo Grupo de Investigación...
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12">
                <div class="col-md-4">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese el nombre del grupo</asp:Label>
                    <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese el nombre del grupo..." Width="100%" Style="align-content: center" ID="strNombreGru"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNombreGru" runat="server" ControlToValidate="strNombreGru" ErrorMessage="Ingrese el nombre del grupo" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-4">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese el nombre del coordinador</asp:Label>
                    <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese el nombre del coordinador..." Width="100%" Style="align-content: center" ID="strNombreCoorGru"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNombreCoorGru" runat="server" ControlToValidate="strNombreCoorGru" ErrorMessage="Ingrese el nombre del coordinador" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-4">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese la fecha de creación</asp:Label>
                    <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese la fecha de creación.." TextMode="DateTimeLocal" Width="100%" ID="dtFechaCreaGru" Style="align-content: center"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFechaCreaGru" runat="server" ControlToValidate="dtFechaCreaGru" ErrorMessage="Ingrese la fecha de creación" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>

        <hr style="border: solid; color: #F0AD4E;" />

        <div class="row">
            <div class="col-md-12">
                <br />
                <div class="col-md-2">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Seleccione la categoria</asp:Label>
                    <asp:DropDownList ID="ddlCatGruInv" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                        <asp:ListItem Value="EMERGENTE">EMERGENTE</asp:ListItem>
                        <asp:ListItem Value="CONSOLIDADO">CONSOLIDADO</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvCatGruInv" runat="server" ControlToValidate="ddlCatGruInv" ErrorMessage="Seleccione la categoría" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-3">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese la linea de investigación</asp:Label>
                   <asp:DropDownListChosen runat="server" CssClass="chosen-select form-control text-center" ID="strLineaInvGru1" Width="100%" BackColor="#F0AD4E" ForeColor="White" NoResultsText="No se encontraron resultados..." DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="false">
                    <asp:ListItem Value="Analisis, conservacion y aprovechamiento de la biodiversidad local">Analisis, conservacion y aprovechamiento de la biodiversidad local</asp:ListItem>
                    <asp:ListItem Value="Desarrollo y seguridad alimentaria">Desarrollo y seguridad alimentaria</asp:ListItem>
                    <asp:ListItem Value="Salud Animal">Salud Animal</asp:ListItem>
                    <asp:ListItem Value="Procesos Industriales">Procesos Industriales</asp:ListItem>
                    <asp:ListItem Value="Energias alternativas y renovables, eficiencia energetica y proteccion ambiental">Energias alternativas y renovables, eficiencia energetica y proteccion ambiental</asp:ListItem>
                    <asp:ListItem Value="Tecnologias de la informacion y comunicacion (TICS)">Tecnologias de la informacion y comunicacion (TICS)</asp:ListItem>
                    <asp:ListItem Value="Gestión de la calidad y seguridad laboral">Gestión de la calidad y seguridad laboral</asp:ListItem>
                    <asp:ListItem Value="Administración y economia para el desarrollo humano y social">Administración y economia para el desarrollo humano y social</asp:ListItem>
                    <asp:ListItem Value="Planificacion y gestion del turismo sostenible">Planificacion y gestion del turismo sostenible</asp:ListItem>
                    <asp:ListItem Value="Educacion, comunicacion y diseño para el desarrollo humano y social">Educacion, comunicacion y diseño para el desarrollo humano y social</asp:ListItem>
                    <asp:ListItem Value="Cultura, patrimonio y saberes ancestrales">Cultura, patrimonio y saberes ancestrales</asp:ListItem>
                </asp:DropDownListChosen>

                    <asp:RequiredFieldValidator ID="rfvLineaInvGru" runat="server" ControlToValidate="strLineaInvGru1" ErrorMessage="Seleccione la línea de investigación" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-4">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese la sublinea de investigación</asp:Label>
                   <asp:DropDownListChosen runat="server" CssClass="chosen-select form-control text-center" ID="strSLineaInvGru1" Width="100%" BackColor="#F0AD4E" ForeColor="White" NoResultsText="No se encontraron resultados..." DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="false">
                    <asp:ListItem Value="Energetica en sistemas electromecanicos y uso de fuentes renovables de energia">Energética en sistemas electromecánicos y uso de fuentes renovables de energía</asp:ListItem>
                    <asp:ListItem Value="Automatizacion, control y protecciones de sistemas electromecanicos">Automatización, control y protecciones de sistemas electromecánicos</asp:ListItem>
                    <asp:ListItem Value="Diseno construccion y mantenimiento de elementos, prototipos y sistemas electromecanicos">Diseño construcción y mantenimiento de elementos, prototipos y sistemas electromecánicos</asp:ListItem>
                    <asp:ListItem Value="Control y optimizacion en el uso de la energia del sector industrial comercial y residencial">Control y optimización en el uso de la energía del sector industrial comercial y residencial</asp:ListItem>
                    <asp:ListItem Value="Conversion y uso racional de la energia electrica">Conversión y uso racional de la energía eléctrica</asp:ListItem>
                    <asp:ListItem Value="Explotacion y diseno de sistemas electricos de potencia">Explotación y diseño de sistemas eléctricos de potencia</asp:ListItem>
                    <asp:ListItem Value="Inteligencia artificial e inteligencia de negocios">Inteligencia artificial e inteligencia de negocios</asp:ListItem>
                    <asp:ListItem Value="Ciencias Informaticas para la modelacion de sistemas a traves del desarrollo de software">Ciencias Informáticas para la modelación de sistemas a través del desarrollo de software</asp:ListItem>
                    <asp:ListItem Value="Diseno, implementacion y configuracion de redes y seguridad computacional, aplicando normas y estandares internacionales">Diseño, implementación y configuración de redes y seguridad computacional, aplicando normas y estándares internacionales</asp:ListItem>
                    <asp:ListItem Value="Diseno de Sistemas y Procesos Hidraulicos">Diseno de Sistemas y Procesos Hidraulicos</asp:ListItem>
                    <asp:ListItem Value="Tratamiento de Fluidos e Impactos de los Procesos Hidraulicos">Tratamiento de Fluidos e Impactos de los Procesos Hidráulicos</asp:ListItem>
                    <asp:ListItem Value="Hidroenergia y Eficiencia en Instalaciones Hidraulicas">Hidroenergía y Eficiencia en Instalaciones Hidráulicas</asp:ListItem>
                    <asp:ListItem Value="Hidrometeorologia y Prospeccion Hidrica">Hidrometeorología y Prospección Hídrica</asp:ListItem>
                    <asp:ListItem Value="Investigacion de operaciones y tecnologia">Investigación de operaciones y tecnología</asp:ListItem>
                    <asp:ListItem Value="Calidad, diseno de procesos productivos e ingenieria de metodos">Calidad, diseño de procesos productivos e ingeniería de métodos</asp:ListItem>
                    <asp:ListItem Value="Produccion para el desarrollo sostenible">Producción para el desarrollo sostenible</asp:ListItem>
                    <asp:ListItem Value="Administracion y gestion de la producción">Administración y gestión de la producción</asp:ListItem>
                </asp:DropDownListChosen>
                    <asp:RequiredFieldValidator ID="rfvSLineaInvGru" runat="server" ControlToValidate="strSLineaInvGru1" ErrorMessage="Ingrese la sublínea de investigación" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                 <div class="col-md-3">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">ARCHIVO</asp:Label>
                    <asp:FileUpload runat="server" CssClass="text-center form-control" accept="application/pdf, .xls, .xlsx" ID="flpArchivoAdd" Width="100%" Style="align-content: center"></asp:FileUpload>
                    <asp:RequiredFieldValidator ID="rfvArchivoAdd" runat="server" ControlToValidate="flpArchivoAdd" ErrorMessage="Seleccione archivo" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 text-center">
                <br />
                <br />
                <asp:LinkButton ID="lbtADDGruInv" runat="server" CssClass="btn btn-success" OnClick="lbtADDGruInv_Click" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-floppy-disk'&gt;&lt;/span&gt; CREAR REGISTRO" />
                <asp:LinkButton ID="lbtCancelarGruInv" CausesValidation="false" runat="server" CssClass="btn btn-danger" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-ban-circle'&gt;&lt;/span&gt; CANCELAR REGISTRO" OnClick="lbtCancelarGruInv_Click" />
                <br />
                <br />
            </div>
        </div>
    </asp:Panel>


    <asp:Panel runat="server" ID="pnlEditarGrupoInv" Visible="false" CssClass="form-control">
        <div class="row">
            <div class="col-md-12 text-center">
                Editando Grupo de Investigación...
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12">
                <div class="col-md-4">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese el nombre del grupo</asp:Label>
                    <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese el nombre del grupo..." Width="100%" Style="align-content: center" ID="txtGrupoInvEdit"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNombreGrupoEdit" runat="server" ControlToValidate="txtGrupoInvEdit" ErrorMessage="Ingrese el nombre del grupo" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-4">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese el nombre del coordinador</asp:Label>
                    <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese el nombre del coordinador..." Width="100%" Style="align-content: center" ID="txtNombreCoorGruInvEdit"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNombreCoordinadorEdit" runat="server" ControlToValidate="txtNombreCoorGruInvEdit" ErrorMessage="Ingrese el nombre del coordinador" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-4">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese la fecha de creación</asp:Label>
                    <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese la fecha de creación.." TextMode="DateTimeLocal" Width="100%" ID="dtEditFechaCreaEdit" Style="align-content: center"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFechaCreacionEdit" runat="server" ControlToValidate="dtEditFechaCreaEdit" ErrorMessage="Ingrese la fecha de creación" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>

        <hr style="border: solid; color: #F0AD4E;" />

        <div class="row">
            <div class="col-md-12">
                <br />
                <div class="col-md-2">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Seleccione la categoría</asp:Label>
                    <asp:DropDownList ID="ddlEditCategoria" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                        <asp:ListItem Value="EMERGENTE">EMERGENTE</asp:ListItem>
                        <asp:ListItem Value="CONSOLIDADO">CONSOLIDADO</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvCategoriaEdit" runat="server" ControlToValidate="ddlEditCategoria" ErrorMessage="Seleccione la categoría" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-3">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese la línea de investigación</asp:Label>
                    <asp:DropDownList BackColor="#F0AD4E" ForeColor="White" runat="server" CssClass="text-center form-control" ID="txtEditLineaIGru1" Width="100%">
                    
                    <asp:ListItem Value="Analisis, conservacion y aprovechamiento de la biodiversidad local">Analisis, conservacion y aprovechamiento de la biodiversidad local
                        </asp:ListItem>
                         <asp:ListItem Value="Desarrollo y seguridad alimentaria">Desarrollo y seguridad alimentaria
                        </asp:ListItem>
                          <asp:ListItem Value="Salud Animal">Salud Animal
                        </asp:ListItem>
                        <asp:ListItem Value="Procesos Industriales">Procesos Industriales
                        </asp:ListItem>
                         <asp:ListItem Value="Energias alternativas y renovables, eficiencia energetica y proteccion ambiental">Energias alternativas y renovables, eficiencia energetica y proteccion ambiental
                        </asp:ListItem>
                         <asp:ListItem Value="Tecnologias de la informacion y comunicacion (TICS)">Tecnologias de la informacion y comunicacion (TICS)                        </asp:ListItem>
                        <asp:ListItem Value="Gestión de la calidad y seguridad laboral">Gestión de la calidad y seguridad laboral
                        </asp:ListItem>
                         <asp:ListItem Value="Administración y economia para el desarrollo humano y social">Administración y economia para el desarrollo humano y social
                        </asp:ListItem>
                        <asp:ListItem Value="Planificacion y gestion del turismo sostenible">Planificacion y gestion del turismo sostenible
                        </asp:ListItem>
                                      <asp:ListItem Value="Educacion, comunicacion y diseño para el desarrollo humano y social">Educacion, comunicacion y diseño para el desarrollo humano y social
                        </asp:ListItem>
                         <asp:ListItem Value="Cultura, patrimonio y saberes ancestrales">Cultura, patrimonio y saberes ancestrales
                        </asp:ListItem>
                    </asp:DropDownList>

                    <asp:RequiredFieldValidator ID="rfvLineaInvestigacionEdit" runat="server" ControlToValidate="txtEditLineaIGru1" ErrorMessage="seleccione la línea de investigación" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-4">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese la sublínea de investigación</asp:Label>
                    <asp:DropDownList BackColor="#F0AD4E" ForeColor="White" runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese la sublínea de investigación..." ID="txtEditSLineaIGru1" Width="100%">
 <asp:ListItem Value="Energetica en sistemas electromecanicos y uso de fuentes renovables de energia">Energética en sistemas electromecánicos y uso de fuentes renovables de energía</asp:ListItem>
                        <asp:ListItem Value="Automatizacion, control y protecciones de sistemas electromecanicos">Automatización, control y protecciones de sistemas electromecánicos</asp:ListItem>
                        <asp:ListItem Value="Diseno construccion y mantenimiento de elementos, prototipos y sistemas electromecanicos">Diseño construcción y mantenimiento de elementos, prototipos y sistemas electromecánicos</asp:ListItem>


                        
                        <asp:ListItem Value="Control y optimizacion en el uso de la energia del sector industrial comercial y residencial">Control y optimización en el uso de la energía del sector industrial comercial y residencial</asp:ListItem>
                        <asp:ListItem Value="Conversion y uso racional de la energia electrica">Conversión y uso racional de la energía eléctrica</asp:ListItem>
                        <asp:ListItem Value="Explotacion y diseno de sistemas electricos de potencia">Explotación y diseño de sistemas eléctricos de potencia</asp:ListItem>
                        <asp:ListItem Value="Inteligencia artificial e inteligencia de negocios">Inteligencia artificial e inteligencia de negocios</asp:ListItem>
                        <asp:ListItem Value="Ciencias Informaticas para la modelacion de sistemas a traves del desarrollo de software">Ciencias Informáticas para la modelación de sistemas a través del desarrollo de software</asp:ListItem>
                        <asp:ListItem Value="Diseno, implementacion y configuracion de redes y seguridad computacional, aplicando normas y estandares internacionales">Diseño, implementación y configuración de redes y seguridad computacional, aplicando normas y estándares internacionales</asp:ListItem>
                        <asp:ListItem Value="Diseno de Sistemas y Procesos Hidraulicos">Diseno de Sistemas y Procesos Hidraulicos</asp:ListItem>
                        <asp:ListItem Value="Tratamiento de Fluidos e Impactos de los Procesos Hidraulicos">Tratamiento de Fluidos e Impactos de los Procesos Hidráulicos</asp:ListItem>
                         <asp:ListItem Value="Hidroenergia y Eficiencia en Instalaciones Hidraulicas">Hidroenergía y Eficiencia en Instalaciones Hidráulicas</asp:ListItem>
                         <asp:ListItem Value="Hidrometeorologia y Prospeccion Hidrica">Hidrometeorología y Prospección Hídrica</asp:ListItem>
                         <asp:ListItem Value="Investigacion de operaciones y tecnologia">Investigación de operaciones y tecnología</asp:ListItem>
                         <asp:ListItem Value="Calidad, diseno de procesos productivos e ingenieria de metodos">Calidad, diseño de procesos productivos e ingeniería de métodos</asp:ListItem>
                         <asp:ListItem Value="Produccion para el desarrollo sostenible">Producción para el desarrollo sostenible</asp:ListItem>
                         <asp:ListItem Value="Administracion y gestion de la producción">Administración y gestión de la producción</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvSubLineaInvestigacionEdit" runat="server" ControlToValidate="txtEditSLineaIGru1" ErrorMessage="seleccione la sublínea de investigación" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                 <div class="col-md-3">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">ARCHIVO</asp:Label>
                    <asp:FileUpload runat="server" CssClass="text-center form-control" accept="application/pdf, .xls, .xlsx" ID="flpArchivoEdit" Width="100%" Style="align-content: center"></asp:FileUpload>
                    <asp:RequiredFieldValidator ID="rfvArchivoEdit" runat="server" ControlToValidate="flpArchivoEdit" ErrorMessage="Seleccione archivo" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 text-center">
                <br />
                <br />
                <asp:LinkButton ID="lbnEditGruInv" runat="server" CssClass="btn btn-success" OnClick="lbnEditGruInv_Click" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-floppy-disk'&gt;&lt;/span&gt; EDITAR REGISTRO" />
                <asp:LinkButton ID="lbnCancellEditGruInv" CausesValidation="false" runat="server" CssClass="btn btn-danger" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-ban-circle'&gt;&lt;/span&gt; CANCELAR EDICIÓN" OnClick="lbnCancellEditGruInv_Click" />
                <br />
                <br />
            </div>
        </div>
    </asp:Panel>


    <asp:Panel runat="server" BackColor="WhiteSmoke" ID="pnlVerMienbros" Visible="false">

        <div class="row">
            <div class="col-lg-12 text-center">
                <asp:LinkButton runat="server" ID="btnADDMiembros" CssClass="btn btn btn-bitbucket text-center" Style="border-radius: 100px; width: 260px; height: 47px; font-weight: bold;" BackColor="#312783" ForeColor="White" Font-Bold="True" OnClick="btnADDMiembros_Click">Agregar Integrante...</asp:LinkButton>
                <br />
                <div class="table table-responsive text-center" style="background-color: #F5F5F5;">
                    <br />
                    <asp:GridView runat="server" ID="gvwMiembros" CssClass="cabeza table table-bordered table-hover table-responsive text-center" DataKeyNames="strId_int,strId_gru" ForeColor="#333333" GridLines="Horizontal" HorizontalAlign="Center" AutoGenerateColumns="false" ToolTip="registros...">
                        <Columns>


                            <asp:BoundField DataField="strId_int" HeaderText="COD" ItemStyle-Width="15px" ItemStyle-Wrap="true" ItemStyle-Font-Size="X-Small" ReadOnly="true" Visible="true" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                            <asp:BoundField DataField="fkId_gru" HeaderText="INTERNO (1 SI ; 0 NO)" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                            <asp:BoundField DataField="bitPertenece_int" HeaderText="INTERNO (1 SI ; 0 NO)" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                            <asp:BoundField DataField="strCedula_int" HeaderText="CÉDULA" HtmlEncode="false" ItemStyle-CssClass="html" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                            <asp:BoundField DataField="strApellidos_int" HeaderText="APELLIDOS" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                            <asp:BoundField DataField="strNombres_int" HeaderText="NOMBRES" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                            <asp:BoundField DataField="strCarrera_int" HeaderText="CARRERA/INSTITUCIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                            <asp:BoundField DataField="strCorreo" HeaderText="CORREO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                            <asp:BoundField DataField="strFuncion_int" HeaderText="FUNCIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                            <asp:BoundField DataField="dtFechaini_int" HeaderText="FECHA INI" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                            <asp:BoundField DataField="dtFechafin_int" HeaderText="FECHA FIN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                            <asp:BoundField DataField="strObservacion_init" HeaderText="OBSERVACIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                            <asp:BoundField DataField="strNombre_gru" HeaderText="GRUPO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />

                            <asp:TemplateField HeaderText="ESTADO">
                                <ItemTemplate>
                                    <asp:Label ID="lblEstado" runat="server"
                                        Text='<%# Convert.ToBoolean(Eval("bitActivo_int")) ? "ACTIVO" : "INACTIVO" %>'
                                        ForeColor='<%# Convert.ToBoolean(Eval("bitActivo_int")) ? System.Drawing.Color.Green : System.Drawing.Color.Red %>'
                                        Font-Bold="true" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="ACCIONES" HeaderStyle-Font-Size="Small">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hfIdIntegrante" runat="server" Value='<%# Eval("strId_int") %>' />

                                    <!-- Botón Ver Estado -->
                                    <asp:LinkButton ID="btnVerEstadoInt" runat="server"
                                        CssClass="btn btn-primary btn-xs btn-circle"
                                        Text="<span class='glyphicon glyphicon-eye-open' style='color:white;'></span>"
                                        ToolTip="Ver estado del integrante"
                                        OnClick="btnVerEstadoInt_Click" />

                                    <!-- Botón Editar -->
                                    <asp:LinkButton ID="btnEditarIntGruInv" CausesValidation="false" runat="server"
                                        CssClass="btn btn-warning btn-xs btn-circle"
                                        Text="<span class='glyphicon glyphicon-edit' style='color:white;'></span>"
                                        OnClick="btnEditarIntGruInv_Click"
                                        ToolTip="Editar Registro." />

                                    <!-- Botón Eliminar -->
                                    <asp:LinkButton ID="btnBorrarIntGruInv" CausesValidation="false" runat="server"
                                        CssClass="btn btn-danger btn-xs btn-circle"
                                        Text="<span class='glyphicon glyphicon-trash' style='color:white;'></span>"
                                        OnClick="btnBorrarIntGruInv_Click"
                                        ToolTip="Eliminar registro."
                                        OnClientClick="return confirm('¿Está seguro que desea eliminar este registro?');" />
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
            </div>
        </div>
    </asp:Panel>



    <!-- Agrega el modal utilizando ModalPopupExtender -->
    <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btnADDMiembros"
        PopupControlID="pnlModal" BackgroundCssClass="modalBackground" CancelControlID="btnCerrarModal">
    </ajaxToolkit:ModalPopupExtender>

    <!-- Agrega el contenido del modal dentro de un Panel -->
    <!-- Agrega el contenido del modal dentro de un Panel -->
    <asp:Panel ID="pnlModal" runat="server" CssClass="modalPopup" Width="100%" Style="display: none; overflow: auto;" BackColor="WhiteSmoke">
        <div class="panel-primary">
            <div class="panel-heading col-lg-12" style="height: auto; width: 100%">
                <div class="col-sm-8">
                    <strong>.::CREACIÓN DE REGISTROS::.</strong>
                </div>
                <div class="col-sm-4" style="text-align: right;">
                    <asp:Button ID="btnCerrarModal" runat="server" Text="Salir" CssClass="btn btn-warning" />
                </div>
            </div>

            <div class="col-md-12">
                <asp:Panel runat="server" ID="pnlAgregarIntegrante" Visible="true">
                    <div class="col-md-12 text-center">
                        <br />
                        <div class="col-md-3"></div>
                        <div class="col-md-6 text-center">
                            <asp:RadioButtonList runat="server" ID="rblPreguntarNuevo" BackColor="#F0AD4E" CssClass="form-control" OnSelectedIndexChanged="rblPreguntarNuevo_SelectedIndexChanged" Visible="true" TextAlign="right" AutoPostBack="true" RepeatDirection="Horizontal" Width="100%">
                                <asp:ListItem Value="REGISTRADO">MIEMBRO INTERNO</asp:ListItem>
                                <asp:ListItem Value="NO REGISTRADO">MIEMBRO EXTERNO</asp:ListItem>
                            </asp:RadioButtonList>
                            <br />
                        </div>
                        <div class="col-md-3"></div>
                    </div>

                    <asp:Panel runat="server" ID="integranteSinRegistro" Visible="false">
                        <div class="row">
                            <br />
                            <br />
                            <div class="col-md-2"></div>
                            <div class="col-md-8 text-center form-control">
                                Estudiante....
            <br />
                            </div>
                            <div class="col-md-2"></div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 text-center">
                                <br />
                                <div class="col-md-4">
                                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="NOMBRE:"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtNombreNuevoInt" CssClass="form-control" Placeholder="Ingrese el nombre del nuevo Integrante..."></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvNombreNuevoInt" runat="server" ControlToValidate="txtNombreNuevoInt" ErrorMessage="Ingrese el nombre del nuevo integrante" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="APELLIDO:"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtApellidoNuevoInt" CssClass="form-control" Placeholder="Ingrese el apellido del nuevo Integrante..."></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvApellidoNuevoInt" runat="server" ControlToValidate="txtApellidoNuevoInt" ErrorMessage="Ingrese el apellido del nuevo integrante" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="CEDULA / PASS:"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtIdentificacionNuevoInt" CssClass="form-control" TextMode="Number" Placeholder="Ingrese la identificación del nuevo Integrante..."></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvIdentificacionNuevoInt" runat="server" ControlToValidate="txtIdentificacionNuevoInt" ErrorMessage="Ingrese la identificación del nuevo integrante" ForeColor="Red"></asp:RequiredFieldValidator>
                                     <asp:CustomValidator ID="cvIdentificacionNuevoInt" runat="server" ControlToValidate="txtIdentificacionNuevoInt" ClientValidationFunction="validateCedula" ErrorMessage="La cédula no es válida o tiene una longitud incorrecta" ForeColor="Red"></asp:CustomValidator>
                                </div>
                            </div>

                            <script>
    function validateCedula(source, args) {
        var cedula = args.Value;
        
        // Validar longitud
        if (cedula.length !== 10) {
            args.IsValid = false;
            return;
        }

        // Validar formato de cédula ecuatoriana
        var cedulaRegex = /^[0-9]{10}$/;
        if (!cedulaRegex.test(cedula)) {
            args.IsValid = false;
            return;
        }

        // Validar dígito verificador
        var provincia = parseInt(cedula.substring(0, 2));
        if (provincia < 1 || provincia > 24) {
            args.IsValid = false;
            return;
        }

        var coeficientes = [2, 1, 2, 1, 2, 1, 2, 1, 2];
        var suma = 0;
        for (var i = 0; i < 9; i++) {
            var digito = parseInt(cedula.charAt(i));
            var producto = digito * coeficientes[i];
            if (producto >= 10) {
                producto -= 9;
            }
            suma += producto;
        }

        var digitoVerificador = 10 - (suma % 10);
        if (digitoVerificador === 10) {
            digitoVerificador = 0;
        }

        if (digitoVerificador !== parseInt(cedula.charAt(9))) {
            args.IsValid = false;
            return;
        }

        args.IsValid = true;
    }
</script>

                            <div class="col-md-12 text-center">
                                <br />
                                <br />
                                <div class="col-md-4">
                                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="FUNCIÓN:"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtFuncionNuevoInt" CssClass="form-control" Placeholder="Ingrese la función del nuevo Integrante..."></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvFuncionNuevoInt" runat="server" ControlToValidate="txtFuncionNuevoInt" ErrorMessage="Ingrese la función del nuevo integrante" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="FECHA INICIO:"></asp:Label>
                                    <asp:TextBox runat="server" ID="dtFechaInicioNuevoInt" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvFechaInicioNuevoInt" runat="server" ControlToValidate="dtFechaInicioNuevoInt" ErrorMessage="Ingrese la fecha de inicio del nuevo integrante" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="FECHA FIN:"></asp:Label>
                                    <asp:TextBox runat="server" ID="dtFechaFinNuevoInt" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvFechaFinNuevoInt" runat="server" ControlToValidate="dtFechaFinNuevoInt" ErrorMessage="Ingrese la fecha de fin del nuevo integrante" ForeColor="Red" Enabled="false"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4 text-center">
                                <br />
                                <br />
                                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="INSTITUCIÓN:"></asp:Label>
                                <asp:TextBox runat="server" ID="txtCarreraNuevoInt" CssClass="form-control" Placeholder="Ingrese la institución a la que pertenece el Integrante..."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvCarreraNuevoInt" runat="server" ControlToValidate="txtCarreraNuevoInt" ErrorMessage="Ingrese la institución del nuevo integrante" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-4 text-center">
                                <br />
                                <br />
                                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="OBSERVACIÓN:"></asp:Label>
                                <asp:TextBox runat="server" ID="txtObservacionNuevoInt" CssClass="form-control" Placeholder="Ingrese Observación"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtObservacionNuevoInt" ErrorMessage="Ingrese la observación" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                             <div class="col-md-4 text-center">
                                <br />
                                <br />
                                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="CORREO ELECTRONICO:"></asp:Label>
                                <asp:TextBox runat="server" ID="txtCorreoNuevoInt" onkeyup="validarCorreo()" CssClass="form-control" Placeholder="Ingrese correo.." TextMode="Email"></asp:TextBox>
                                  <asp:RequiredFieldValidator ID="rfvCorreoInt" runat="server" ControlToValidate="txtCorreoNuevoInt" ErrorMessage="Ingrese correo del nuevo integrante" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                            

                            <script>
                                function validarCorreo() {
                                    var correo = document.getElementById('txtCorreoNuevoInt').value;
                                    var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

                                    if (emailRegex.test(correo)) {
                                        // El formato del correo es válido
                                        toastr.success('El formato del correo es válido.');
                                    } else {
                                        // El formato del correo es inválido
                                        toastr.error('El formato del correo es inválido.');
                                    }
                                }
                            </script>
                            <div class="col-md-12 text-center">
                                <br />
                                <br />
                                <asp:LinkButton ID="lbtnAddIntegranteSinRegistrar" runat="server" CssClass="btn btn-success" OnClick="lbtnAddIntegranteSinRegistrar_Click" Style="border-radius: 100px; color: white;">
                <span class="glyphicon glyphicon-floppy-disk"></span> CREAR REGISTRO</asp:LinkButton>
                                <asp:LinkButton ID="lbtCancellIntegranteSinRegistrar" runat="server" CssClass="btn btn-danger" CausesValidation="false" Style="border-radius: 100px; color: white;">
                <span class="glyphicon glyphicon-ban-circle"></span> CANCELAR REGISTRO</asp:LinkButton>
                            </div>
                        </div>
                    </asp:Panel>

                </asp:Panel>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel runat="server" ID="pnlEditarIntegrantesGruInv" Visible="false">
    <div class="row">
        <br />
        <br />
        <div class="col-md-2"></div>
        <div class="col-md-8 text-center form-control">
            Editando Estudiante o Individuo Externo....
            <br />
        </div>
        <div class="col-md-2"></div>
    </div>
    <div class="row">
        <div class="col-md-12 text-center">
            <br />
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="NOMBRE:"></asp:Label>
                <asp:TextBox runat="server" ID="txtEditNombreInt" CssClass="form-control" Placeholder="Ingrese el nombre del nuevo Integrante..."></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEditNombreInt" runat="server" ControlToValidate="txtEditNombreInt" ErrorMessage="Ingrese el nombre del integrante" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="APELLIDO:"></asp:Label>
                <asp:TextBox runat="server" ID="txtEditApellidoInt" CssClass="form-control" Placeholder="Ingrese el apellido del nuevo Integrante..."></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEditApellidoInt" runat="server" ControlToValidate="txtEditApellidoInt" ErrorMessage="Ingrese el apellido del integrante" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="CEDULA / PASS:"></asp:Label>
                <asp:TextBox runat="server" ID="txtCedulaEditInt" CssClass="form-control" TextMode="Number" Placeholder="Ingrese la identificación del nuevo Integrante..."></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCedulaEditInt" runat="server" ControlToValidate="txtCedulaEditInt" ErrorMessage="Ingrese la identificación del integrante" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="col-md-12 text-center">
            <br />
            <br />
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="FUNCIÓN:"></asp:Label>
                <asp:TextBox runat="server" ID="txtFuncionEdit" CssClass="form-control" Placeholder="Ingrese la función del nuevo Integrante..."></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFuncionEdit" runat="server" ControlToValidate="txtFuncionEdit" ErrorMessage="Ingrese la función del integrante" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="FECHA INICIO:"></asp:Label>
                <asp:TextBox runat="server" ID="dtFechaIniEdit" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFechaIniEdit" runat="server" ControlToValidate="dtFechaIniEdit" ErrorMessage="Ingrese la fecha de inicio del integrante" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="FECHA FIN:"></asp:Label>
                <asp:TextBox runat="server" ID="dtFechaFinEdit" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFechaFinEdit" runat="server" ControlToValidate="dtFechaFinEdit" ErrorMessage="Ingrese la fecha de fin del integrante" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="col-md-4 text-center">
            <br />
            <br />
            <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="INSTITUCIÓN:"></asp:Label>
            <asp:TextBox runat="server" ID="txtCarreraEdit" CssClass="form-control" Placeholder="Ingrese la institución a la que pertenece el nuevo Integrante..."></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvCarreraEdit" runat="server" ControlToValidate="txtCarreraEdit" ErrorMessage="Ingrese la institución del integrante" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="col-md-4 text-center">
            <br />
            <br />
            <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="OBSERVACIÓN:"></asp:Label>
            <asp:TextBox runat="server" ID="txtObservacionEdit" CssClass="form-control" Placeholder="Ingrese Observación (Opcional)..."></asp:TextBox>
        </div>
        <div class="col-md-4 text-center">
                                <br />
                                <br />
                                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="CORREO ELECTRONICO:"></asp:Label>
                                <asp:TextBox runat="server" ID="txtCorreoNuevoIntEdit" CssClass="form-control" Placeholder="Ingrese correo.." TextMode="Email"></asp:TextBox>
                                  <asp:RequiredFieldValidator ID="rfvCorreoIntEdit" runat="server" ControlToValidate="txtCorreoNuevoIntEdit" ErrorMessage="Ingrese correo del nuevo integrante" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
        <div class="col-md-12 text-center">
            <br />
            <br />
            <asp:LinkButton ID="lbtnEditIntegrantesGruInv" runat="server" CssClass="btn btn-success" OnClick="lbtnEditIntegrantesGruInv_Click" Style="border-radius: 100px; color: white;">
                <span class="glyphicon glyphicon-floppy-disk"></span> EDITAR REGISTRO</asp:LinkButton>
            <asp:LinkButton ID="lbtnCancellEditIntegrantesGruInv" CausesValidation="false" runat="server" CssClass="btn btn-danger" OnClick="lbtnCancellEditIntegrantesGruInv_Click" Style="border-radius: 100px; color: white;">
                <span class="glyphicon glyphicon-ban-circle"></span> CANCELAR REGISTRO</asp:LinkButton>
        </div>
    </div>
</asp:Panel>



    <div class="col-lg-11 col-md-11 col-sm-11 text-right"></div>
    <div class="col-sm-12">
        <br />
    </div>

    <br />

    <!-- Modal Ver Estado Integrante -->
    <ajaxToolkit:ModalPopupExtender 
        ID="ModalEstadoIntegrante" 
        runat="server" 
        TargetControlID="btnDummyEstado"
        PopupControlID="pnlEstadoIntegrante"
        BackgroundCssClass="modalBackground"
        CancelControlID="btnCerrarEstado">
    </ajaxToolkit:ModalPopupExtender>

    <asp:Button ID="btnDummyEstado" runat="server" Style="display:none;" />

    <asp:Panel ID="pnlEstadoIntegrante" runat="server" CssClass="modalPopup" Width="60%" BackColor="WhiteSmoke" Style="display:none; padding:20px;">
        <div class="panel-heading text-center" style="font-weight:bold; font-size:18px; color:#312783;">
            <asp:Label ID="lblTituloEstado" runat="server" Text="Detalle del Integrante"></asp:Label>
        </div>
        <hr />
        <div class="text-center">
            <asp:Label ID="lblInfoIntegrante" runat="server" Font-Size="Large" ForeColor="#312783"></asp:Label>
            <br /><br />
            <asp:Label ID="lblEstadoIntegrante" runat="server" Font-Bold="True" Font-Size="Large"></asp:Label>
            <br /><br />

            <asp:Button ID="btnDarDeBaja" runat="server" CssClass="btn btn-danger"
                Text="Dar de baja" OnClick="btnDarDeBaja_Click"
                OnClientClick="return confirm('¿Está seguro que desea dar de baja a este integrante?');" />

            <asp:Button ID="btnReactivar" runat="server" CssClass="btn btn-success"
                Text="Reactivar integrante" OnClick="btnReactivar_Click"
                OnClientClick="return confirm('¿Desea reactivar a este integrante?');" Visible="false" />
        
            &nbsp;
            <asp:Button ID="btnCerrarEstado" runat="server" CssClass="btn btn-secondary" Text="Cerrar" />
        </div>
    </asp:Panel>


    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const bajaBtn = document.getElementById('<%= btnDarDeBaja.ClientID %>');
            if (bajaBtn) {
                bajaBtn.onclick = function(e) {
                    if (!confirm("¿Seguro que deseas dar de baja a este integrante?")) {
                        e.preventDefault();
                        return false;
                    }
                };
            }
        });
    </script>


</asp:Content>
