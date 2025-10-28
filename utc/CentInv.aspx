<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CentInv.aspx.cs" Inherits="utc.CentInv" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!--datatables  -->

   <%-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.21/css/dataTables.bootstrap.min.css"  />
    <script src="https://code.jquery.com/jquery-2.2.4.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.21/js/jquery.dataTables.min.js" ></script>
    --%>

    <link href="prueba/Styles/datatables/datatables.css" rel="stylesheet" />

    <script src="prueba/Scripts/datatables/datatables.js"></script>
    <script src="prueba/Scripts/datatables/datatables.min.js"></script>

    <!-- EXPORTAR PDF EXCEL -->
    <script src="prueba/Scripts/datatables_imprimir/pdfmake.min.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/print.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/vfs_fonts.js"></script>
    <script src="prueba/Scripts/propias/datatablesMetodo.js"></script>
    <%-- font awesome--%>

   

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />

       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

      <div class="loading">Loading&#8230;</div>

    <%-- estilos propios para boton redondo--%>
    <link href="prueba/Styles/propio/propio.css" rel="stylesheet" />

    <script type="text/javascript">//para mostrar splash screen
        window.addEventListener('load', function () {
            $(".loading").css("display", "none");
        })
    </script>



    <%--<script src="https://cdn.ckeditor.com/ckeditor5/35.3.2/classic/ckeditor.js"></script>--%>
    <script src="https://cdn.ckeditor.com/4.18.0/full/ckeditor.js"></script>
    <div class="row">
        <div class="col-md-12 text-center">


            <asp:Panel ID="Panel1" runat="server" BackColor="White" Width="100%">
                <div class="row">
                    <div class="col-md-12 text-center">
                        <div class="col-md-4 text-center">
<%--<asp:button Cssclass="btn btn btn-bitbucket text-center" style="border-radius: 100px; width: 214px; height: 52px;"  BackColor="#312783" ForeColor="White" Font-Bold="True" runat="server" Text="UTC"  ID="btnUtc" ClientIDMode="Static" ToolTip="UNIVERSIDAD TÉCNICA DE COTOPAXI..." Font-Size="25px"> </asp:button>--%>                            <%-- <label class="" style="color: #312783; font-size:25px;">UTC</label>--%>
                        </div>
                        <div class="col-md-4 text-center">
                            <h3 style="color: #312783; font-weight: bold;"><i class="fa fa-book"></i>SISTEMA DE GESTIÓN GENERAL DE INVESTIGACIÓN
                            </h3>
                        </div>
                        <div class="col-md-4 text-center">
                            <asp:LinkButton CssClass="btn btn btn-bitbucket text-center" CausesValidation="false" Style="border-radius: 100px; width: 260px; height: 47px; font-weight: bold;" runat="server" Text="<span><i class='fa fa-chevron-left'></i></span> REGRESAR" BackColor="#312783" ForeColor="White" Font-Bold="True" ID="btnRegresarCentInv" ToolTip="REGRESAR..." Font-Size="20px" Visible="false" OnClick="btnRegresarCentInv_Click"> </asp:LinkButton>

                        </div>
                    </div>
                </div>
            </asp:Panel>

            <br />
            <asp:Panel ID="pnlOcultarBoton" runat="server">

                <%--    <asp:Button ID="btnCrearCabeceraAcad" runat="server" Text="Nuevo Registo" OnClick="btnCrearCabeceraAcad_Click" CssClass="btn btn-bitbucket " Style="border-radius: 100px;" />--%>
                <asp:Label ID="codigo" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                 <asp:Label ID="fullpath1" runat="server" ForeColor="red" Visible="false"></asp:Label>
                 <asp:Label ID="aux" runat="server" ForeColor="red" Visible="false"></asp:Label>


            </asp:Panel>


            <div class="text-right">
            </div>

        </div>
    </div>

    <div class="col-md-12 text-center">
        <asp:LinkButton runat="server" ID="lbtNuevoCentInv" CausesValidation="false" CssClass="btn btn btn-bitbucket text-center" Style="border-radius: 100px; width: 260px; height: 47px; font-weight: bold;" BackColor="#312783" ForeColor="White" Font-Bold="True" OnClick="lbtNuevoCentInv_Click" Text="&lt;span class='glyphicon glyphicon-plus'&gt;&lt;/span&gt; NUEVO REGISTRO"></asp:LinkButton>
        <asp:LinkButton runat="server" ID="lbtNuevoMiembroCentInv" CausesValidation="false" CssClass="btn btn btn-bitbucket text-center" Style="border-radius: 100px; width: 260px; height: 47px; font-weight: bold;" BackColor="#312783" ForeColor="White" Font-Bold="True"  OnClick="lbtNuevoMiembroCentInv_Click" Text="&lt;span class='glyphicon glyphicon-plus'&gt;&lt;/span&gt; NUEVO INTEGRANTE" Visible="false"></asp:LinkButton>
        <asp:Label runat="server" ID="lblMsg" ForeColor="Red"></asp:Label>
        <br />
        <br />
    </div>


    <asp:Panel runat="server" ID="pnlGrilla" Visible="true">
        <div class="table table-responsive text-center" style="background-color: #F5F5F5;">
            <asp:GridView runat="server" ID="gvwListadoCentInv" CssClass="cabeza table table-bordered table-hover table-responsive text-center"  ForeColor="#333333" GridLines="Horizontal" HorizontalAlign="Center" AutoGenerateColumns="false" ToolTip="registros...">
                <Columns>


                    <asp:BoundField DataField="strId_cen" HeaderText="COD" ItemStyle-Width="15px" ItemStyle-Wrap="true" ItemStyle-Font-Size="X-Small" ReadOnly="true" Visible="true" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                    <asp:BoundField DataField="strArchivo_cen" HeaderText="COD" ItemStyle-Width="15px" ItemStyle-Wrap="true" ItemStyle-Font-Size="X-Small" ReadOnly="true" Visible="true" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                    <asp:BoundField DataField="strNombre_cen" HeaderText="NOMBRE CENTRO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="strDescripcion_cen" HeaderText="DESCRIPCIÓN" HtmlEncode="false" ItemStyle-CssClass="html" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small"  />
                    <asp:BoundField DataField="strObservacion_cen" HeaderText="OBSERVACIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />

                    <asp:TemplateField HeaderText="ACCIONES" HeaderStyle-Font-Size="Small">
                        <ItemTemplate>
                             <asp:LinkButton ID="btnMiembrosCentInv" OnClick="btnMiembrosCentInv_Click" CausesValidation="false" runat="server" CssClass="btn btn-success btn-xs btn-circle" Text="<span class='glyphicon glyphicon-user'></span>" ToolTip="Visualizar Miembros." Style="color: white;" />
                            <asp:LinkButton ID="btnVisualizarCentInv" OnClick="btnVisualizarCentInv_Click" CausesValidation="false" runat="server" CssClass="btn btn-info btn-xs btn-circle" Text="<span class='glyphicon glyphicon-paperclip'></span>" ToolTip="Visualizar Registro." Style="color: white;" />
                            <asp:LinkButton ID="btnEditarCentInv" CausesValidation="false" runat="server" CssClass="btn btn-warning btn-xs btn-circle" Text="<span class='glyphicon glyphicon-edit'></span>" OnClick="btnEditarCentInv_Click" ToolTip="Editar Registro." Style="color: white;" />
                            <asp:LinkButton ID="btnBorrarCentInv" CausesValidation="false" runat="server" Text="<span class='glyphicon glyphicon-trash'></span>" CssClass="btn btn-danger btn-xs btn-circle" OnClick="btnBorrarCentInv_Click" Style="color: white;" OnClientClick="return confirm('Esta seguro que desea eliminar este registro, esta opción es irreversible?')" ToolTip="Eliminar registro." />
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
    <br />


    <br />

     <asp:Panel runat="server" ID="pnlMiembros" Visible="false">
        <div class="table table-responsive text-center" style="background-color: #F5F5F5;">
            <asp:GridView runat="server" ID="gvwMiembros" CssClass="cabeza table table-bordered table-hover table-responsive text-center"  ForeColor="#333333" GridLines="Horizontal" HorizontalAlign="Center" AutoGenerateColumns="false" ToolTip="registros...">
                <Columns>


                    <asp:BoundField DataField="StrIdMie1" HeaderText="COD" ItemStyle-Width="15px" ItemStyle-Wrap="true" ItemStyle-Font-Size="X-Small" ReadOnly="true" Visible="true" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                    <asp:BoundField DataField="StrNombreGru" HeaderText="GRUPO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="StrFuncionMie" HeaderText="FUNCIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="DtFechaIniMie" HeaderText="FECHA INICIO" HtmlEncode="false" ItemStyle-CssClass="html" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small"  />
                    <asp:BoundField DataField="dtFechafin" HeaderText="FECHA FIN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    <asp:BoundField DataField="StrNombreCen" HeaderText="CENTRO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />

                    <asp:TemplateField HeaderText="ACCIONES" HeaderStyle-Font-Size="Small">
                        <ItemTemplate>
                             <asp:LinkButton ID="btnEditarMiembrosInv"  CausesValidation="false" runat="server" CssClass="btn btn-warning btn-xs btn-circle" Text="<span class='glyphicon glyphicon-edit'></span>" OnClick="btnEditarMiembrosInv_Click" ToolTip="Editar Registro." Style="color: white;" />
                            <asp:LinkButton ID="btnBorrarMiembrosCentInv" CausesValidation="false" runat="server" Text="<span class='glyphicon glyphicon-trash'></span>" CssClass="btn btn-danger btn-xs btn-circle" OnClick="btnBorrarMiembrosCentInv_Click" Style="color: white;" OnClientClick="return confirm('Esta seguro que desea eliminar este registro, esta opción es irreversible?')" ToolTip="Eliminar registro." />
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

    <asp:Panel runat="server" ID="pnlAgregarCentInv" Visible="false" CssClass="form-control">
    <div class="row">
        <div class="col-md-12 text-center">
            Agregando Nuevo Centro de Investigación...
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-12">
            
            <div class="col-lg-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese el nombre del centro</asp:Label>
                <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese el nombre..." ID="txtNombreCen" Width="100%" Style="align-content: center"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvNombreCen" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="txtNombreCen" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese la observación...</asp:Label>
                <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese la observación..." ID="txtObservacionCen" Width="100%" Style="align-content: center"></asp:TextBox>
             <asp:RequiredFieldValidator ID="rfvObservacionCen" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="txtObservacionCen" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="col-lg-4">
                 <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">ARCHIVO</asp:Label>
                  <asp:FileUpload runat="server" CssClass="text-center form-control" accept="application/pdf, .xls, .xlsx"  ID="txtCentInvFileAdd" Width="100%" Style="align-content: center"></asp:FileUpload>
             <asp:RequiredFieldValidator ID="rfvArchivoAdd" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="txtCentInvFileAdd" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 text-center">
            <br />
            <asp:Label runat="server" Font-Bold="true" ForeColor="#312783">Ingrese la descripción del centro de investigación</asp:Label>
            <asp:TextBox ID="txtDescripcionCen" runat="server" CssClass="form-control" Width="100%" TextMode="MultiLine" ForeColor="Black"></asp:TextBox>
            <script type="text/javascript" lang="javascript">
                CKEDITOR.replace('<%=txtDescripcionCen.ClientID%>');
                CKEDITOR.InnerText('<%=txtDescripcionCen%>');
            </script>
<script>
    function validarCampo() {
        // Obtener el contenido del editor CKEditor
        var contenido = CKEDITOR.instances['<%=txtDescripcionCen.ClientID%>'].getData();

        // Realizar la validación
        if (contenido.trim() === '') {
            // El campo está vacío, mostrar un mensaje de error o realizar alguna acción
            toastr.error('La descripción es un campo obligatorio.');
            //Msg("La descripción es un campo es obligatorio.", "ii", "SISTEMA INTEGRADO DE GESTIÓN");
            return false; // Cancelar el evento si es necesario
        }

        // El campo es válido, continuar con el proceso o enviar los datos al servidor
        return true;
    }
</script>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 text-center">
            <br />
            <asp:LinkButton ID="lbtADDCentInv" runat="server" OnClientClick="return validarCampo();" CssClass="btn btn-success" OnClick="lbtADDCentInv_Click" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-floppy-disk'&gt;&lt;/span&gt; CREAR REGISTRO" />
            <asp:LinkButton ID="lbtCancelarCentInv" CausesValidation="false" runat="server" CssClass="btn btn-danger" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-ban-circle'&gt;&lt;/span&gt; CANCELAR REGISTRO" OnClick="lbtCancelarCentInv_Click" />
            <br />
            <br />
        </div>
    </div>
</asp:Panel>

    <asp:Panel runat="server" ID="pnlADDmiembro" Visible="false" CssClass="form-control">
    <div class="row">
        <div class="col-md-12 text-center">
            Agregando Nuevo miembro asociado a centro...
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-12">
            
            <div class="col-lg-3">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">GRUPO</asp:Label>
                <asp:DropDownList runat="server" CssClass="text-center form-control" BackColor="#F0AD4E" ForeColor="White" ID="ddlGrupoMiembros" Width="100%" Style="align-content: center"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="ddlGrupoMiembros" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="col-md-3">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">FUNCIÓN</asp:Label>
                <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese la función..." ID="txtFuncionAdd" Width="100%" Style="align-content: center"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="txtFuncionAdd" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="col-lg-3">
                 <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">FECHA INICIO</asp:Label>
                  <asp:TextBox runat="server" TextMode="DateTimeLocal" CssClass="text-center form-control" ID="txtFechaIniAdd" Width="100%" Style="align-content: center"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="txtFechaIniAdd" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
             <div class="col-lg-3">
                 <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">FECHA FIN</asp:Label>
                  <asp:TextBox runat="server" TextMode="DateTimeLocal" CssClass="text-center form-control" ID="txtFechaFinAdd" Width="100%" Style="align-content: center"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="txtFechaFinAdd" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12 text-center">
            <br />
            <asp:LinkButton ID="lbtADDMiembros" runat="server" CssClass="btn btn-success" OnClick="lbtADDMiembros_Click" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-floppy-disk'&gt;&lt;/span&gt; CREAR REGISTRO" />
            <asp:LinkButton ID="lbtCancellAddMiembros" CausesValidation="false" runat="server" CssClass="btn btn-danger" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-ban-circle'&gt;&lt;/span&gt; CANCELAR REGISTRO" OnClick="lbtCancellAddMiembros_Click" />
            <br />
            <br />
        </div>
    </div>

</asp:Panel>
    <br />
      <asp:Panel runat="server" ID="pnlEditarMiembro" Visible="false" CssClass="form-control">
    <div class="row">
        <div class="col-md-12 text-center">
            Editando miembro asociado a centro...
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-12">
            
            <div class="col-lg-3">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">GRUPO</asp:Label>
                <asp:DropDownList runat="server" CssClass="text-center form-control" BackColor="#F0AD4E" ForeColor="White" ID="ddlGrupoEdit" Width="100%" Style="align-content: center"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="ddlGrupoEdit" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="col-md-3">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">FUNCIÓN</asp:Label>
                <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese la función..." ID="txtFuncionEdit" Width="100%" Style="align-content: center"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="txtFuncionEdit" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="col-lg-3">
                 <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">FECHA INICIO</asp:Label>
                  <asp:TextBox runat="server" TextMode="DateTimeLocal" CssClass="text-center form-control" ID="txtFechaIniEdit" Width="100%" Style="align-content: center"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="txtFechaIniEdit" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
             <div class="col-lg-3">
                 <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">FECHA FIN</asp:Label>
                  <asp:TextBox runat="server" TextMode="DateTimeLocal" CssClass="text-center form-control" ID="txtFechaFinEdit" Width="100%" Style="align-content: center"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="txtFechaFinEdit" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12 text-center">
            <br />
            <asp:LinkButton ID="lbtnEditMiembros" OnClick="lbtnEditMiembros_Click" runat="server" CssClass="btn btn-success" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-floppy-disk'&gt;&lt;/span&gt; EDITAR REGISTRO" />
            <asp:LinkButton ID="lbtnCancellEditMiembros" CausesValidation="false" runat="server" CssClass="btn btn-danger" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-ban-circle'&gt;&lt;/span&gt; CANCELAR REGISTRO" OnClick="lbtnCancellEditMiembros_Click" />
            <br />
            <br />
        </div>
    </div>
</asp:Panel>
    <br />

    <asp:Panel runat="server" ID="pnlEditarCentnv" Visible="false" CssClass="form-control">
    <div class="row">
        <div class="col-md-12 text-center">
            Editando Centro de Investigación...
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-12">
            
            <div class="col-lg-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese el nombre del centro</asp:Label>
                <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese el nombre..." ID="txtEditNombreCentro" Width="100%" Style="align-content: center"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEditNombreCentro" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="txtEditNombreCentro" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese la observación</asp:Label>
                <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese la observación..." ID="txtEditObservacionCentro" Width="100%" Style="align-content: center"></asp:TextBox>
             <asp:RequiredFieldValidator ID="rfvEditObservacionCentro" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="txtEditObservacionCentro" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="col-lg-4">
                 <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">ARCHIVO</asp:Label>
                  <asp:FileUpload runat="server" CssClass="text-center form-control" accept="application/pdf, .xls, .xlsx"  ID="flpArchivoEdit" Width="100%" Style="align-content: center"></asp:FileUpload>
             </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 text-center">
            <br />
            <asp:Label runat="server" Font-Bold="true" ForeColor="#312783">Ingrese la descripción del centro de investigación</asp:Label>
            <asp:TextBox ID="txtEditDescripcionCentro" runat="server" CssClass="form-control" Width="100%" TextMode="MultiLine" ForeColor="Black"></asp:TextBox>
            <script type="text/javascript" lang="javascript">
                CKEDITOR.replace('<%=txtEditDescripcionCentro.ClientID%>');
                CKEDITOR.InnerText('<%=txtEditDescripcionCentro%>');
            </script>

            <script>
    function validarCampoEditar() {
        // Obtener el contenido del editor CKEditor
        var contenido = CKEDITOR.instances['<%=txtEditDescripcionCentro.ClientID%>'].getData();

        // Realizar la validación
        if (contenido.trim() === '') {
            // El campo está vacío, mostrar un mensaje de error o realizar alguna acción
            toastr.error('La descripción es un campo obligatorio.');
            //Msg("La descripción es un campo es obligatorio.", "ii", "SISTEMA INTEGRADO DE GESTIÓN");
            return false; // Cancelar el evento si es necesario
        }

        // El campo es válido, continuar con el proceso o enviar los datos al servidor
        return true;
    }
</script>
            <asp:RequiredFieldValidator ID="rfvEditDescripcionCentro" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="txtEditDescripcionCentro" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 text-center">
            <br />
            <asp:LinkButton ID="lbtnEditarCentro" OnClientClick="return validarCampoEditar();" runat="server" CssClass="btn btn-success" OnClick="lbtnEditarCentro_Click" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-floppy-disk'&gt;&lt;/span&gt; EDITAR REGISTRO" />
            <asp:LinkButton ID="lbtnCancellEditCentro" CausesValidation="false" runat="server" CssClass="btn btn-danger" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-ban-circle'&gt;&lt;/span&gt; CANCELAR EDICIÓN" OnClick="lbtnCancellEditCentro_Click" />
            <br />
            <br />
        </div>
    </div>
</asp:Panel>

</asp:Content>
