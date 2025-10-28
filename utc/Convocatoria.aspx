
<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Convocatoria.aspx.cs" Inherits="utc._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <link href="prueba/Styles/datatables/datatables.css" rel="stylesheet" />

    <script src="prueba/Scripts/datatables/datatables.js"></script>
    <script src="prueba/Scripts/datatables/datatables.min.js"></script>

    



    <!-- EXPORTAR PDF EXCEL -->
    <script src="prueba/Scripts/datatables_imprimir/pdfmake.min.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/print.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/vfs_fonts.js"></script>
    <script src="prueba/Scripts/propias/datatablesMetodo.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />


    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>


    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-fileinput@5.1.0/dist/css/fileinput.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-fileinput@5.1.0/dist/js/fileinput.min.js"></script>


    <link href="https://cdn.jsdelivr.net/bootstrap.tagsinput/0.8.0/bootstrap-tagsinput.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/bootstrap.tagsinput/0.8.0/bootstrap-tagsinput.min.js"></script>




    <%-- estilos propios para boton redondo--%>
    <link href="prueba/Styles/propio/propio.css" rel="stylesheet" />

    <script type="text/javascript">//para mostrar splash screen
        window.addEventListener('load', function () {
            $(".loading").css("display", "none");
        });


    </script>


    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


        
    <div class="loading">Loading&#8230;</div>

    <%--<script src="https://cdn.ckeditor.com/ckeditor5/35.3.2/classic/ckeditor.js"></script>--%>
    <script src="https://cdn.ckeditor.com/4.18.0/full/ckeditor.js"></script>
    <div class="row">
        <div class="col-md-12 text-center">


            <asp:Panel ID="Panel1" runat="server" BackColor="White" Width="100%">
                <div class="row">
                    <div class="col-md-12 text-center">
                        <div class="col-md-4 text-center">

<%--<asp:button Cssclass="btn btn btn-bitbucket text-center" style="border-radius: 100px; width: 214px; height: 52px;"  BackColor="#312783" ForeColor="White" Font-Bold="True" runat="server" Text="UTC"  ID="btnUtc" ClientIDMode="Static" ToolTip="UNIVERSIDAD TÉCNICA DE COTOPAXI..." Font-Size="25px"> </asp:button>--%>
                        </div>
                        <div class="col-md-4 text-center">
                            <h3 style="color: #312783; font-weight: bold;"><i class="fa fa-book"></i>SISTEMA DE GESTIÓN GENERAL DE INVESTIGACIÓN
                            </h3>
                        </div>
                        <div class="col-md-4 text-center">
                            <asp:LinkButton CssClass="btn btn btn-bitbucket text-center" CausesValidation="false" Style="border-radius: 100px; width: 260px; height: 47px; font-weight: bold;" runat="server" Text="<span><i class='fa fa-chevron-left'></i></span> REGRESAR" BackColor="#312783" ForeColor="White" Font-Bold="True" ID="btnRegresarConvocatoria" ToolTip="REGRESAR..." Font-Size="20px" Visible="false" OnClick="btnRegresarConvocatoria_Click"> </asp:LinkButton>

                        </div>
                    </div>
                </div>
            </asp:Panel>

        
            <asp:Panel ID="pnlOcultarBoton" runat="server">

                <%--    <asp:Button ID="btnCrearCabeceraAcad" runat="server" Text="Nuevo Registo" OnClick="btnCrearCabeceraAcad_Click" CssClass="btn btn-bitbucket " Style="border-radius: 100px;" />--%>
                <asp:Label ID="codigo" runat="server" ForeColor="red" Visible="false"></asp:Label>
                <asp:Label ID="fullpath1" runat="server" ForeColor="red" Visible="false"></asp:Label>

            </asp:Panel>


            <div class="text-right">
            </div>

        </div>
    </div>
 
    <div class="col-md-12 text-center">
        <asp:LinkButton runat="server" ID="lbtNormativa" CausesValidation="false" CssClass="btn btn btn-bitbucket text-center" Style="border-radius: 100px; width: 260px; height: 47px; font-weight: bold;" Visible="false" BackColor="#312783" ForeColor="White" Font-Bold="True">Normativa</asp:LinkButton>

        <asp:LinkButton runat="server" ID="lbtNuevaNormativa" CausesValidation="false" CssClass="btn btn btn-bitbucket text-center" Style="border-radius: 100px; width: 260px; height: 47px; font-weight: bold;" BackColor="#312783" ForeColor="White" Font-Bold="True" OnClick="lbtNuevaNormativa_Click">Agregar Nuevo</asp:LinkButton>
        <asp:Label runat="server" ID="lblMsg" ForeColor="Red"></asp:Label>
        <asp:Panel runat="server" ID="pnlGrilla" Visible="true">
            <br />
            <br />
            <div class="table table-responsive text-center" style="background-color: #F5F5F5;">
                <asp:GridView runat="server"  ID="gvwListadoConvocatoriaInv" CssClass="cabeza table table-bordered table-hover table-responsive text-center" ForeColor="#333333" GridLines="Horizontal" HorizontalAlign="Center" AutoGenerateColumns="false" ToolTip="registros...">
                    <Columns>


                        <asp:BoundField DataField="strId_conv" HeaderText="COD" ItemStyle-Width="15px" ItemStyle-Wrap="true" ItemStyle-Font-Size="X-Small" ReadOnly="true" Visible="true" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                        <asp:BoundField DataField="strArchivo_conv" HeaderText="NOMBRE" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                        <asp:BoundField DataField="strNombre_conv" HeaderText="NOMBRE" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="strDescripcion_conv" HeaderText="DESCRIPCIÓN" HtmlEncode="false" ItemStyle-CssClass="html" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="dtFechaini_conv" HeaderText="FECHA INICIO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="dtFechafin_conv" HeaderText="FECHA FIN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />

                        <asp:TemplateField HeaderText="ACCIONES" HeaderStyle-Font-Size="Small">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnVsiualizaConv" OnClick="btnVsiualizaConv_Click" CausesValidation="false" runat="server" CssClass="btn btn-info btn-xs btn-circle" Text="<span class='glyphicon glyphicon-paperclip'></span>" ToolTip="Visualizar Registro." Style="color: white;" />
                                <asp:LinkButton ID="btnEditarConvInv" CausesValidation="false" runat="server" CssClass="btn btn-warning btn-xs btn-circle" Text="<span class='glyphicon glyphicon-edit'></span>" OnClick="btnEditarConvInv_Click" ToolTip="Editar Registro." Style="color: white;" />
                                <asp:LinkButton ID="btnBorrarConvInv"  runat="server" Text="<span class='glyphicon glyphicon-trash'></span>" CssClass="btn btn-danger btn-xs btn-circle" OnClick="btnBorrarConvInv_Click" Style="color: white;" OnClientClick="return confirm('Esta seguro que desea eliminar este registro, esta opción es irreversible?')" ToolTip="Eliminar registro." />
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
       

    </div>
   

    <asp:Panel runat="server" ID="pnlAgregarConvocatoria" Visible="false" CssClass="form-control">
    <div class="row">
        <div class="col-md-12 text-center">
            Agregando Nueva Convocatoria...
            <br />
            <br />
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-4">
            <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese el nombre de la Convocatoria</asp:Label>
            <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese el nombre..." Width="100%" Style="align-content: center" ID="txtNombreConv"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvNombreConv" runat="server" ErrorMessage="**Campo obligatorio**" ControlToValidate="txtNombreConv" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese la fecha de Inicio</asp:Label>
            <asp:TextBox runat="server" CssClass="text-center form-control datepicker" placeholder="Por favor ingrese la fecha de incio.." TextMode="DateTimeLocal" ID="strFechaIniConv" Width="100%" Style="align-content: center"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvFechaIniConv" runat="server" ErrorMessage="**Campo obligatorio**" ControlToValidate="strFechaIniConv" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese la fecha de Cierre</asp:Label>
            <asp:TextBox runat="server" CssClass="text-center form-control datepicker" placeholder="Por favor ingrese la fecha de cierre.." TextMode="DateTimeLocal" ID="strFechaFinConv" Width="100%" Style="align-content: center"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvFechaFinConv" runat="server" ErrorMessage="**Campo obligatorio**" ControlToValidate="strFechaFinConv" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
     <script>
$(document).ready(function () {
    // Selector de fecha de inicio
    $("#txtFechaIniAdd").datepicker({
        dateFormat: 'yy-mm-dd',
        onSelect: function (dateText, inst) {
            var selectedDate = new Date(dateText);
            var maxDate = new Date(selectedDate);
            maxDate.setFullYear(selectedDate.getFullYear() + 2);
            
            // Establecer la fecha mínima en el selector de fecha de fin
            $("#txtFechaFinAdd").datepicker("option", "minDate", dateText);
            
            // Establecer la fecha máxima en el selector de fecha de fin
            $("#txtFechaFinAdd").datepicker("option", "maxDate", maxDate);
        }
    });

    // Selector de fecha de fin
    $("#txtFechaFinAdd").datepicker({
        dateFormat: 'yy-mm-dd'
    });
});
</script>





         <div class="col-md-2">
            <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Archivo</asp:Label>
            <asp:FileUpload runat="server" CssClass="text-center form-control" ID="flpArchivoConvocatoriaAdd" accept="application/pdf, .xlsx, .xls" Width="100%" Style="align-content: center"></asp:FileUpload>
            <asp:RequiredFieldValidator ID="rfvArchivoAdd" runat="server" ErrorMessage="**Campo obligatorio**" ControlToValidate="flpArchivoConvocatoriaAdd" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 text-center">
            <br />
            <asp:Label runat="server" Font-Bold="true" ForeColor="#312783">Ingrese la descripción de la Convocatoria</asp:Label>
            <asp:TextBox ID="txtDescripcionConv" runat="server" CssClass="form-control" Width="100%" TextMode="MultiLine" ForeColor="Black"></asp:TextBox>
            <script type="text/javascript" lang="javascript">
                CKEDITOR.replace('<%=txtDescripcionConv.ClientID%>');
                CKEDITOR.InnerText('<%=txtDescripcionConv%>');
            </script>
                       <script type="text/javascript">
    function validarCampo() {
        // Obtener el contenido del editor CKEditor
        var contenido = CKEDITOR.instances['<%=txtDescripcionConv.ClientID%>'].getData();

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
            <asp:LinkButton ID="lbtADDConvocatoria" OnClientClick="return validarCampo();" runat="server" CssClass="btn btn-success" OnClick="lbtADDConvocatoria_Click" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-floppy-disk'&gt;&lt;/span&gt; CREAR REGISTRO" />
            <asp:LinkButton ID="lbtCancelarConvocatoria" CausesValidation="false" runat="server" CssClass="btn btn-danger" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-ban-circle'&gt;&lt;/span&gt; CANCELAR REGISTRO" OnClick="lbtCancelarConvocatoria_Click" />
            <br />
            <br />
        </div>
    </div>
</asp:Panel>

    <br />
    <asp:Panel runat="server" ID="pnlEditarConvocatoria" Visible="false" CssClass="form-control">
    <div class="row">
        <div class="col-md-12 text-center">
            Editando Convocatoria...
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-4">
            <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="Ingrese el nombre de la Convocatoria"></asp:Label>
            <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese el nombre..." Width="100%" Style="align-content: center" ID="txtEditNombreConv"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEditNombreConv" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="txtEditNombreConv" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="Ingrese la fecha de Inicio"></asp:Label>
            <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese la fecha de incio.." TextMode="DateTimeLocal" ID="dtEditFechaIni" Width="100%" Style="align-content: center"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEditFechaIni" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="dtEditFechaIni" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" ForeColor="#312783" Font-Bold="true" Text="Ingrese la fecha de Cierre"></asp:Label>
            <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese la fecha de cierre.." TextMode="DateTimeLocal" ID="dtEditFechaFin" Width="100%" Style="align-content: center"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEditFechaFin" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="dtEditFechaFin" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
         <div class="col-md-2">
            <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Archivo</asp:Label>
            <asp:FileUpload runat="server" CssClass="text-center form-control" ID="flpArchivoConvEdit" accept="application/pdf, .xlsx, .xls" Width="100%" Style="align-content: center"></asp:FileUpload>
           
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 text-center">
            <br />
            <asp:Label runat="server" Font-Bold="true" ForeColor="#312783" Text="Ingrese la descripción de la Convocatoria"></asp:Label>
            <asp:TextBox ID="txtEditDescripcionConv" runat="server" CssClass="form-control" Width="100%" TextMode="MultiLine" ForeColor="Black"></asp:TextBox>
            <script type="text/javascript" lang="javascript">
                CKEDITOR.replace('<%=txtEditDescripcionConv.ClientID%>');
                CKEDITOR.InnerText('<%=txtEditDescripcionConv%>');
            </script>
          <script type="text/javascript">
    function validarCampoEdit() {
        // Obtener el contenido del editor CKEditor
        var contenido = CKEDITOR.instances['<%=txtEditDescripcionConv.ClientID%>'].getData();

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
            <asp:LinkButton ID="lbnEditConvocatoria" OnClientClick="return validarCampoEdit();" runat="server" CssClass="btn btn-success" OnClick="lbnEditConvocatoria_Click" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-floppy-disk'&gt;&lt;/span&gt; EDITAR REGISTRO" />
            <asp:LinkButton ID="lbnCancellConvocatoria" CausesValidation="false" runat="server" CssClass="btn btn-danger" Style="border-radius: 100px; color: white;" Text="&lt;span class='glyphicon glyphicon-ban-circle'&gt;&lt;/span&gt; CANCELAR EDICIÓN" OnClick="lbnCancellConvocatoria_Click" />
            <br />
            <br />
        </div>
    </div>
</asp:Panel>


 
</asp:Content>
